import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // For Obx

import '../../Functions/Function.dart';
import '../../Widgets/AlertDialogBuilder.dart';
import '../../Widgets/ScrollConfig.dart';
import 'Widgets/SettingsHeader.dart';
import '../../api/Anilist/Anilist.dart';
import '../../api/Discord/Discord.dart';

class SettingsAccountScreen extends StatelessWidget {
  const SettingsAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollConfig(
        context,
        children: [
          SliverToBoxAdapter(
            child: SettingsHeader(
              context,
              'Accounts',
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  size: 52,
                  Icons.person,
                  color: theme.onSurface,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ..._buildSettings(context),
                  const SizedBox(height: 42),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSettings(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return [
      _buildAccountSection(
        context,
        iconPath: 'assets/svg/anilist.svg',
        title: 'Anilist',
        isLoggedIn: Anilist.token,
        username: Anilist.username,
        avatarUrl: Anilist.avatar,
        onLogOut: () => AlertDialogBuilder(context)
          ..setTitle('Logout Anilist')
          ..setMessage('Are you sure you want to logout?')
          ..setPositiveButton('Yes', Anilist.removeSavedToken)
          ..setNegativeButton('No', null)
          ..show(),
        onLogIn: () => snackString('Anilist'),
        onAvatarTap: () => snackString('Avatar Tapped'),
        onIconTap: () => snackString('Edit Icon Tapped'),
        onIconLongTap: () => snackString('Long Pressed'),
      ),
      const SizedBox(height: 16),
      _buildAccountSection(
        context,
        icon: Icon(
          Icons.discord,
          size: 26,
          color: theme.primary,
        ),
        title: 'Discord',
        isLoggedIn: Discord.token,
        username: Discord.userName,
        avatarUrl: Discord.avatar,
        onLogOut: () => AlertDialogBuilder(context)
          ..setTitle('Logout Discord')
          ..setMessage('Are you sure you want to logout?')
          ..setPositiveButton('Yes', Discord.removeSavedToken)
          ..setNegativeButton('No', null)
          ..show(),
        onLogIn: () => Discord.warning(context),
        onAvatarTap: () => snackString('Discord Avatar Tapped'),
        onIconTap: () => snackString('Discord Edit Icon Tapped'),
        onIconLongTap: () => snackString('Discord Long Pressed'),
      ),
    ];
  }

  Widget _buildAccountSection(
    BuildContext context, {
    String? iconPath,
    Widget? icon,
    required String title,
    required RxString isLoggedIn,
    required RxString username,
    required RxString avatarUrl,
    required Function() onLogOut,
    required Function() onLogIn,
    required Function() onAvatarTap,
    required Function() onIconTap,
    required Function() onIconLongTap,
  }) {
    var theme = Theme.of(context).colorScheme;

    final leadingIcon = iconPath != null
        ? SvgPicture.asset(
            iconPath,
            width: 26,
            height: 26,
            // ignore: deprecated_member_use
            color: theme.primary,
          )
        : icon!;

    return Obx(() => isLoggedIn.value.isNotEmpty
        ? _logged(context, leadingIcon, title, username, avatarUrl, onLogOut,
            onAvatarTap, onIconTap, onIconLongTap)
        : _notLogged(leadingIcon, onLogIn));
  }

  Widget _logged(
    BuildContext context,
    Widget leadingIcon,
    String? title,
    RxString username,
    RxString avatarUrl,
    Function() onPressed,
    Function() onAvatarTap,
    Function() onIconTap,
    Function()? onIconLongTap,
  ) {
    var theme = Theme.of(context).colorScheme;
    return Obx(() {
      return ListTile(
        leading: leadingIcon,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                username.value.isNotEmpty ? username.value : title ?? '',
                style: TextStyle(
                  color: theme.secondary,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Logout',
                style: TextStyle(
                  color: theme.onSurface,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            Row(
              children: [
                GestureDetector(
                  onTap: onIconTap,
                  onLongPress: onIconLongTap,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.primary,
                    ),
                    child: Icon(
                      Icons.question_mark, // Small icon
                      size: 14,
                      color: theme.surface,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onAvatarTap,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 26.0,
                    backgroundImage: avatarUrl.value.isNotEmpty
                        ? CachedNetworkImageProvider(avatarUrl.value)
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: onPressed,
      );
    });
  }

  Widget _notLogged(Widget leadingIcon, Function() onPressed) {
    return ListTile(
      leading: leadingIcon,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 0.8,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 32,
            ),
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}