import 'dart:async';
import 'dart:io';

import 'package:dantotsu/Functions/Extensions.dart';
import 'package:dantotsu/Functions/Function.dart';
import 'package:dantotsu/Screens/Login/LoginScreen.dart';
import 'package:dantotsu/Screens/Manga/MangaScreen.dart';
import 'package:dantotsu/api/Sources/Model/Manga.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as provider;
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:uni_links_desktop/uni_links_desktop.dart';
import 'package:window_manager/window_manager.dart';

import 'Functions/GetExtensions.dart';
import 'Preferences/PrefManager.dart';
import 'Screens/Anime/AnimeScreen.dart';
import 'Screens/Home/HomeScreen.dart';
import 'Screens/HomeNavbar.dart';
import 'Services/MediaService.dart';
import 'Services/ServiceSwitcher.dart';
import 'StorageProvider.dart';
import 'Theme/ThemeManager.dart';
import 'Theme/ThemeProvider.dart';
import 'api/Discord/Discord.dart';
import 'api/TypeFactory.dart';
import 'logger.dart';

late Isar isar;
WebViewEnvironment? webViewEnvironment;

void main(List<String> args) async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await init();
      runApp(
        provider.ProviderScope(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeNotifier()),
              ChangeNotifierProvider(create: (_) => MediaServiceProvider()),
            ],
            child: const MyApp(),
          ),
        ),
      );
    },
    (error, stackTrace) {
      Logger.log('Uncaught error: $error\n$stackTrace');
      throw ('Uncaught error: $error\n$stackTrace');
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String message) {
        Logger.log(message);
        parent.print(zone, message);
      },
    ),
  );
}

Future init() async {
  if (Platform.isWindows) {
    ['dar', 'anymex', 'sugoireads'].forEach(registerProtocol);
  }
  await StorageProvider.requestPermission();
  await dotenv.load(fileName: ".env");
  await PrefManager.init();
  isar = await StorageProvider.initDB(null);
  await Logger.init();
  await Extensions.init();
  initializeMediaServices();
  MediaKit.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await WindowManager.instance.ensureInitialized();
  }

  TypeFactory.registerAllTypes();
  initializeDateFormatting();
  final supportedLocales = DateFormat.allLocalesWithSymbols();
  for (var locale in supportedLocales) {
    initializeDateFormatting(locale);
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    final availableVersion = await WebViewEnvironment.getAvailableVersion();
    if (availableVersion != null) {
      final document = await getApplicationDocumentsDirectory();
      webViewEnvironment = await WebViewEnvironment.create(
          settings: WebViewEnvironmentSettings(
              userDataFolder: p.join(document.path, 'flutter_inappwebview')));
    }
  }
  Discord.getSavedToken();
  initDeepLinkListener();
  Get.config(
    enableLog: true,
    logWriterCallback: (text, {isError = false}) async {
      Logger.log(text);
      debugPrint(text);
    },
  );
}

void initDeepLinkListener() async {
  try {
    final initialUri = await getInitialUri();
    if (initialUri != null) handleDeepLink(initialUri);
  } catch (err) {
    snackString('Error getting initial deep link: $err');
  }

  uriLinkStream.listen(
    (uri) => uri != null ? handleDeepLink(uri) : null,
    onError: (err) => snackString('Error Opening link: $err'),
  );
}

void handleDeepLink(Uri uri) {
  if (uri.host != "add-repo") return;

  final repoMap = {
    ItemType.anime: uri.queryParameters["url"] ?? uri.queryParameters["anime_url"],
    ItemType.manga: uri.queryParameters["manga_url"],
    ItemType.novel: uri.queryParameters["novel_url"],
  };

  bool isRepoAdded = false;

  repoMap.forEach((type, url) {
    if (url != null && url.isNotEmpty) {
      Extensions.setRepo(type, url);
      isRepoAdded = true;
    }
  });

  snackString(isRepoAdded ? "Added Repo Links Successfully!" : "Missing required parameters in the link.");
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeManager.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (KeyEvent event) async {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            if (Get.previousRoute.isNotEmpty) {
              Get.back();
            }
          } else if (event.logicalKey == LogicalKeyboardKey.f11) {
            bool isFullScreen = await windowManager.isFullScreen();
            windowManager.setFullScreen(!isFullScreen);
          } else if (event.logicalKey == LogicalKeyboardKey.enter) {
            final isAltPressed = HardwareKeyboard.instance.logicalKeysPressed
                    .contains(LogicalKeyboardKey.altLeft) ||
                HardwareKeyboard.instance.logicalKeysPressed
                    .contains(LogicalKeyboardKey.altRight);
            if (isAltPressed) {
              bool isFullScreen = await windowManager.isFullScreen();
              windowManager.setFullScreen(!isFullScreen);
            }
          }
        }
      },
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return GetMaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(loadData(PrefName.defaultLanguage)),
            navigatorKey: navigatorKey,
            title: 'Dartotsu',
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: getTheme(lightDynamic, themeManager),
            darkTheme: getTheme(darkDynamic, themeManager),
            home: const MainActivity(),
          );
        },
      ),
    );
  }
}

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  MainActivityState createState() => MainActivityState();
}

late FloatingBottomNavBar navbar;

class MainActivityState extends State<MainActivity> {
  int _selectedIndex = 1;

  void _onTabSelected(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    navbar = FloatingBottomNavBar(
      selectedIndex: _selectedIndex,
      onTabSelected: _onTabSelected,
    );

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return IndexedStack(
              index: _selectedIndex,
              children: [
                const AnimeScreen(),
                context.currentService().data.token.value.isNotEmpty
                    ? const HomeScreen()
                    : const LoginScreen(),
                const MangaScreen(),
              ],
            );
          }),
          navbar,
        ],
      ),
    );
  }
}
