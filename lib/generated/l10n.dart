// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `LarkMusic`
  String get appName {
    return Intl.message(
      'LarkMusic',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Recommend`
  String get home {
    return Intl.message(
      'Recommend',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Play List`
  String get playList {
    return Intl.message(
      'Play List',
      name: 'playList',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get musicName {
    return Intl.message(
      'Name',
      name: 'musicName',
      desc: '',
      args: [],
    );
  }

  /// `Singer`
  String get singer {
    return Intl.message(
      'Singer',
      name: 'singer',
      desc: '',
      args: [],
    );
  }

  /// `Classify`
  String get classify {
    return Intl.message(
      'Classify',
      name: 'classify',
      desc: '',
      args: [],
    );
  }

  /// `Album`
  String get album {
    return Intl.message(
      'Album',
      name: 'album',
      desc: '',
      args: [],
    );
  }

  /// `Collect`
  String get collect {
    return Intl.message(
      'Collect',
      name: 'collect',
      desc: '',
      args: [],
    );
  }

  /// `Song List`
  String get songList {
    return Intl.message(
      'Song List',
      name: 'songList',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `My Song list`
  String get mySongList {
    return Intl.message(
      'My Song list',
      name: 'mySongList',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Simplified Chinese`
  String get simplifiedChinese {
    return Intl.message(
      'Simplified Chinese',
      name: 'simplifiedChinese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Server Address`
  String get serviceUrl {
    return Intl.message(
      'Server Address',
      name: 'serviceUrl',
      desc: '',
      args: [],
    );
  }

  /// `account`
  String get account {
    return Intl.message(
      'account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Server Address cannot be empty`
  String get serviceUrlNotEmpty {
    return Intl.message(
      'Server Address cannot be empty',
      name: 'serviceUrlNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `account cannot be empty`
  String get accountNotEmpty {
    return Intl.message(
      'account cannot be empty',
      name: 'accountNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `password cannot be empty`
  String get passwordNotEmpty {
    return Intl.message(
      'password cannot be empty',
      name: 'passwordNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get loginSuccess {
    return Intl.message(
      'Login Success',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Search Music`
  String get searchMusic {
    return Intl.message(
      'Search Music',
      name: 'searchMusic',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Recent`
  String get recent {
    return Intl.message(
      'Recent',
      name: 'recent',
      desc: '',
      args: [],
    );
  }

  /// `Personal Center`
  String get personalCenter {
    return Intl.message(
      'Personal Center',
      name: 'personalCenter',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePsd {
    return Intl.message(
      'Change Password',
      name: 'changePsd',
      desc: '',
      args: [],
    );
  }

  /// `Enter old password`
  String get enterOldPsd {
    return Intl.message(
      'Enter old password',
      name: 'enterOldPsd',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password`
  String get enterNewPsd {
    return Intl.message(
      'Enter a new password',
      name: 'enterNewPsd',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the new password`
  String get enterSurePsd {
    return Intl.message(
      'Confirm the new password',
      name: 'enterSurePsd',
      desc: '',
      args: [],
    );
  }

  /// `Sure`
  String get sure {
    return Intl.message(
      'Sure',
      name: 'sure',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `The new password is inconsistent with the confirmed password`
  String get surePsdErr {
    return Intl.message(
      'The new password is inconsistent with the confirmed password',
      name: 'surePsdErr',
      desc: '',
      args: [],
    );
  }

  /// `The new password cannot be the same as the old password`
  String get psdConsistent {
    return Intl.message(
      'The new password cannot be the same as the old password',
      name: 'psdConsistent',
      desc: '',
      args: [],
    );
  }

  /// `Change Success`
  String get changeSuccess {
    return Intl.message(
      'Change Success',
      name: 'changeSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Lyric Empty`
  String get lyricEmpty {
    return Intl.message(
      'Lyric Empty',
      name: 'lyricEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter search keywords`
  String get enterMusicName {
    return Intl.message(
      'Enter search keywords',
      name: 'enterMusicName',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Console`
  String get console {
    return Intl.message(
      'Console',
      name: 'console',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `PlaybackSetting`
  String get playbackSetting {
    return Intl.message(
      'PlaybackSetting',
      name: 'playbackSetting',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get appVersion {
    return Intl.message(
      'App',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `A Beautiful music player`
  String get appDesc {
    return Intl.message(
      'A Beautiful music player',
      name: 'appDesc',
      desc: '',
      args: [],
    );
  }

  /// `App Homepage`
  String get appHome {
    return Intl.message(
      'App Homepage',
      name: 'appHome',
      desc: '',
      args: [],
    );
  }

  /// `Protocol`
  String get protocol {
    return Intl.message(
      'Protocol',
      name: 'protocol',
      desc: '',
      args: [],
    );
  }

  /// `Deletion of playlist successful`
  String get deleteSongListSuccess {
    return Intl.message(
      'Deletion of playlist successful',
      name: 'deleteSongListSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Add Music`
  String get songListAddMusic {
    return Intl.message(
      'Add Music',
      name: 'songListAddMusic',
      desc: '',
      args: [],
    );
  }

  /// `Create SongList`
  String get createSongList {
    return Intl.message(
      'Create SongList',
      name: 'createSongList',
      desc: '',
      args: [],
    );
  }

  /// `SongList name`
  String get songListName {
    return Intl.message(
      'SongList name',
      name: 'songListName',
      desc: '',
      args: [],
    );
  }

  /// `SongList desc`
  String get songListDesc {
    return Intl.message(
      'SongList desc',
      name: 'songListDesc',
      desc: '',
      args: [],
    );
  }

  /// `SongList name empty`
  String get songListNameEmpty {
    return Intl.message(
      'SongList name empty',
      name: 'songListNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `SongList desc empty`
  String get songListDescEmpty {
    return Intl.message(
      'SongList desc empty',
      name: 'songListDescEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Desc`
  String get desc {
    return Intl.message(
      'Desc',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Play All`
  String get playAll {
    return Intl.message(
      'Play All',
      name: 'playAll',
      desc: '',
      args: [],
    );
  }

  /// `Import songs`
  String get importSongs {
    return Intl.message(
      'Import songs',
      name: 'importSongs',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get songListDelete {
    return Intl.message(
      'Delete',
      name: 'songListDelete',
      desc: '',
      args: [],
    );
  }

  /// `play`
  String get play {
    return Intl.message(
      'play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `Add to playlist`
  String get addToSongList {
    return Intl.message(
      'Add to playlist',
      name: 'addToSongList',
      desc: '',
      args: [],
    );
  }

  /// `Last`
  String get lastMusic {
    return Intl.message(
      'Last',
      name: 'lastMusic',
      desc: '',
      args: [],
    );
  }

  /// `Play/Pause`
  String get pauseOrPlay {
    return Intl.message(
      'Play/Pause',
      name: 'pauseOrPlay',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextMusic {
    return Intl.message(
      'Next',
      name: 'nextMusic',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Sync Music`
  String get syncMusic {
    return Intl.message(
      'Sync Music',
      name: 'syncMusic',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get emptyTips {
    return Intl.message(
      'No data',
      name: 'emptyTips',
      desc: '',
      args: [],
    );
  }

  /// `Request failed`
  String get errorTips {
    return Intl.message(
      'Request failed',
      name: 'errorTips',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `LoginOut`
  String get loginOut {
    return Intl.message(
      'LoginOut',
      name: 'loginOut',
      desc: '',
      args: [],
    );
  }

  /// `Mine`
  String get mine {
    return Intl.message(
      'Mine',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get library {
    return Intl.message(
      'Library',
      name: 'library',
      desc: '',
      args: [],
    );
  }

  /// `Recommend`
  String get recommend {
    return Intl.message(
      'Recommend',
      name: 'recommend',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add Success`
  String get addSuccess {
    return Intl.message(
      'Add Success',
      name: 'addSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Delete Success`
  String get deleteSuccess {
    return Intl.message(
      'Delete Success',
      name: 'deleteSuccess',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
