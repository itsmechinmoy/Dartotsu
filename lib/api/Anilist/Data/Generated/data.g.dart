// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) =>
    UserListResponse(
      data: json['data'] == null
          ? null
          : UserListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserListResponseToJson(UserListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserListData _$UserListDataFromJson(Map<String, dynamic> json) => UserListData(
      currentAnime: json['currentAnime'] == null
          ? null
          : MediaListCollection.fromJson(
              json['currentAnime'] as Map<String, dynamic>),
      repeatingAnime: json['repeatingAnime'] == null
          ? null
          : MediaListCollection.fromJson(
              json['repeatingAnime'] as Map<String, dynamic>),
      favoriteAnime: json['favoriteAnime'] == null
          ? null
          : User.fromJson(json['favoriteAnime'] as Map<String, dynamic>),
      plannedAnime: json['plannedAnime'] == null
          ? null
          : MediaListCollection.fromJson(
              json['plannedAnime'] as Map<String, dynamic>),
      currentManga: json['currentManga'] == null
          ? null
          : MediaListCollection.fromJson(
              json['currentManga'] as Map<String, dynamic>),
      repeatingManga: json['repeatingManga'] == null
          ? null
          : MediaListCollection.fromJson(
              json['repeatingManga'] as Map<String, dynamic>),
      favoriteManga: json['favoriteManga'] == null
          ? null
          : User.fromJson(json['favoriteManga'] as Map<String, dynamic>),
      plannedManga: json['plannedManga'] == null
          ? null
          : MediaListCollection.fromJson(
              json['plannedManga'] as Map<String, dynamic>),
      recommendationQuery: json['recommendationQuery'] == null
          ? null
          : Page.fromJson(json['recommendationQuery'] as Map<String, dynamic>),
      recommendationPlannedQueryAnime:
          json['recommendationPlannedQueryAnime'] == null
              ? null
              : MediaListCollection.fromJson(
                  json['recommendationPlannedQueryAnime']
                      as Map<String, dynamic>),
      recommendationPlannedQueryManga:
          json['recommendationPlannedQueryManga'] == null
              ? null
              : MediaListCollection.fromJson(
                  json['recommendationPlannedQueryManga']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserListDataToJson(UserListData instance) =>
    <String, dynamic>{
      'currentAnime': instance.currentAnime,
      'repeatingAnime': instance.repeatingAnime,
      'favoriteAnime': instance.favoriteAnime,
      'plannedAnime': instance.plannedAnime,
      'currentManga': instance.currentManga,
      'repeatingManga': instance.repeatingManga,
      'favoriteManga': instance.favoriteManga,
      'plannedManga': instance.plannedManga,
      'recommendationQuery': instance.recommendationQuery,
      'recommendationPlannedQueryAnime':
          instance.recommendationPlannedQueryAnime,
      'recommendationPlannedQueryManga':
          instance.recommendationPlannedQueryManga,
    };

MediaResponse _$MediaResponseFromJson(Map<String, dynamic> json) =>
    MediaResponse(
      data: json['data'] == null
          ? null
          : MediaData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaResponseToJson(MediaResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

MediaData _$MediaDataFromJson(Map<String, dynamic> json) => MediaData(
      media: json['Media'] == null
          ? null
          : Media.fromJson(json['Media'] as Map<String, dynamic>),
      page: json['Page'] == null
          ? null
          : Page.fromJson(json['Page'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaDataToJson(MediaData instance) => <String, dynamic>{
      'Media': instance.media,
      'Page': instance.page,
    };

MediaListCollectionResponse _$MediaListCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    MediaListCollectionResponse(
      data: json['data'] == null
          ? null
          : MediaListCollectionData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaListCollectionResponseToJson(
        MediaListCollectionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

MediaListCollectionData _$MediaListCollectionDataFromJson(
        Map<String, dynamic> json) =>
    MediaListCollectionData(
      mediaListCollection: json['MediaListCollection'] == null
          ? null
          : MediaListCollection.fromJson(
              json['MediaListCollection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaListCollectionDataToJson(
        MediaListCollectionData instance) =>
    <String, dynamic>{
      'MediaListCollection': instance.mediaListCollection,
    };

ViewerResponse _$ViewerResponseFromJson(Map<String, dynamic> json) =>
    ViewerResponse(
      data: json['data'] == null
          ? null
          : ViewerData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewerResponseToJson(ViewerResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ViewerData _$ViewerDataFromJson(Map<String, dynamic> json) => ViewerData(
      user: json['Viewer'] == null
          ? null
          : User.fromJson(json['Viewer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewerDataToJson(ViewerData instance) =>
    <String, dynamic>{
      'Viewer': instance.user,
    };

AnimeListResponse _$AnimeListResponseFromJson(Map<String, dynamic> json) =>
    AnimeListResponse(
      data: json['data'] == null
          ? null
          : AnimeListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeListResponseToJson(AnimeListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AnimeListData _$AnimeListDataFromJson(Map<String, dynamic> json) =>
    AnimeListData(
      recentUpdates: json['recentUpdates'] == null
          ? null
          : Page.fromJson(json['recentUpdates'] as Map<String, dynamic>),
      trendingMovies: json['trendingMovies'] == null
          ? null
          : Page.fromJson(json['trendingMovies'] as Map<String, dynamic>),
      topRated: json['topRated'] == null
          ? null
          : Page.fromJson(json['topRated'] as Map<String, dynamic>),
      mostFav: json['mostFav'] == null
          ? null
          : Page.fromJson(json['mostFav'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeListDataToJson(AnimeListData instance) =>
    <String, dynamic>{
      'recentUpdates': instance.recentUpdates,
      'trendingMovies': instance.trendingMovies,
      'topRated': instance.topRated,
      'mostFav': instance.mostFav,
    };

MangaListResponse _$MangaListResponseFromJson(Map<String, dynamic> json) =>
    MangaListResponse(
      data: json['data'] == null
          ? null
          : MangaListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MangaListResponseToJson(MangaListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

MangaListData _$MangaListDataFromJson(Map<String, dynamic> json) =>
    MangaListData(
      trendingManga: json['trendingManga'] == null
          ? null
          : Page.fromJson(json['trendingManga'] as Map<String, dynamic>),
      trendingManhwa: json['trendingManhwa'] == null
          ? null
          : Page.fromJson(json['trendingManhwa'] as Map<String, dynamic>),
      trendingNovel: json['trendingNovel'] == null
          ? null
          : Page.fromJson(json['trendingNovel'] as Map<String, dynamic>),
      topRated: json['topRated'] == null
          ? null
          : Page.fromJson(json['topRated'] as Map<String, dynamic>),
      mostFav: json['mostFav'] == null
          ? null
          : Page.fromJson(json['mostFav'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MangaListDataToJson(MangaListData instance) =>
    <String, dynamic>{
      'trendingManga': instance.trendingManga,
      'trendingManhwa': instance.trendingManhwa,
      'trendingNovel': instance.trendingNovel,
      'topRated': instance.topRated,
      'mostFav': instance.mostFav,
    };

PageResponse _$PageResponseFromJson(Map<String, dynamic> json) => PageResponse(
      data: json['data'] == null
          ? null
          : MediaData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PageResponseToJson(PageResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

PageData _$PageDataFromJson(Map<String, dynamic> json) => PageData(
      page: json['Page'] == null
          ? null
          : Page.fromJson(json['Page'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PageDataToJson(PageData instance) => <String, dynamic>{
      'Page': instance.page,
    };