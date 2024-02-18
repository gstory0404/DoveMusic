import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/album/album_page.dart';
import 'package:dovemusic/pages/albumlist/album_list_page.dart';
import 'package:dovemusic/pages/console/console_page.dart';
import 'package:dovemusic/pages/home/home_page.dart';
import 'package:dovemusic/pages/index/index_page.dart';
import 'package:dovemusic/pages/like/like_page.dart';
import 'package:dovemusic/pages/login/login_page.dart';
import 'package:dovemusic/pages/mine/mine_page.dart';
import 'package:dovemusic/pages/play/play_page.dart';
import 'package:dovemusic/pages/recently/recently_page.dart';
import 'package:dovemusic/pages/search/search_page.dart';
import 'package:dovemusic/pages/setting/setting_page.dart';
import 'package:dovemusic/pages/singer/singer_page.dart';
import 'package:dovemusic/pages/singerlist/singer_list_page.dart';
import 'package:dovemusic/pages/songlist/song_list_page.dart';
import 'package:dovemusic/pages/songlist_detail/songlist_detail_page.dart';
import 'package:dovemusic/pages/splash/splash_page.dart';
import 'package:dovemusic/utils/sp/sp_manager.dart';
import 'package:logger/logger.dart';

import '../manager/tray_manager.dart';
import '../utils/log/log_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 12:09
/// @Email gstory0404@gmail.com
/// @Description: 路由

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class RouterPage {
  static const String splash = "splash";
  static const String login = "login";
  static const String index = "index";
  static const String home = "home";
  static const String like = "like";
  static const String recently = "recently";
  static const String singerList = "singerList";
  static const String singer = "singer";
  static const String play = "play";
  static const String songList = "songList";
  static const String songListDetail = "songListDetail";
  static const String albumList = "albumList";
  static const String album = "album";
  static const String search = "search";
  static const String mine = "mine";
  static const String setting = "setting";
  static const String console = "console";
}

//手机端路由
final phoneRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  observers: [
    GoRouterObserver(),
  ],
  routes: [
    GoRoute(
      name: RouterPage.splash,
      path: '/splash',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, SplashPage());
      },
    ),
    GoRoute(
      name: RouterPage.home,
      path: '/home',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, IndexPage());
      },
    ),
    ...routers(rootNavigatorKey),
    GoRoute(
      name: RouterPage.login,
      path: '/login',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, LoginPage());
      },
    ),
  ],
  redirect: _myGoRouterRedirect(),
);

//桌面端路由
final desktopRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  observers: [
    GoRouterObserver(),
  ],
  routes: [
    GoRoute(
      name: RouterPage.splash,
      path: '/splash',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, SplashPage());
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return IndexPage(child: child);
      },
      observers: [
        GoRouterObserver(),
      ],
      routes: [
        GoRoute(
          name: RouterPage.home,
          path: '/home',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return _transitionBuild(context, state, HomePage());
          },
        ),
        ...routers(_shellNavigatorKey)
      ],
    ),
    GoRoute(
      name: RouterPage.login,
      path: '/login',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        //初始化
        TrayManager.instance;
        return _transitionBuild(context, state, LoginPage());
      },
    ),
  ],
  redirect: _myGoRouterRedirect(),
);

_myGoRouterRedirect() {
  return (BuildContext context, GoRouterState state) {
    //如果未登录就跳转登录页面
    if (!SPManager.instance.isLogin() && state.uri.toString() != "/splash") {
      // return context.namedLocation(RouterPage.login);
      return "/login";
    } else {
      return null;
    }
  };
}

List<RouteBase> routers(GlobalKey<NavigatorState>? navigatorKey) {
  return [
    GoRoute(
      name: RouterPage.like,
      path: '/like',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, const LikePage());
      },
    ),
    GoRoute(
      name: RouterPage.recently,
      path: '/recently',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, RecentlyPage());
      },
    ),
    GoRoute(
      name: RouterPage.singerList,
      path: '/singerList',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, SingerListPage());
      },
    ),
    GoRoute(
      name: RouterPage.singer,
      path: '/singer/:singerId',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        int id = int.parse(state.pathParameters['singerId'] ?? "0");
        return _transitionBuild(context, state, SingerPage(singerId: id));
      },
    ),
    GoRoute(
      name: RouterPage.play,
      path: '/play',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, PlayPage());
      },
    ),
    GoRoute(
      name: RouterPage.songList,
      path: '/songList',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, SongListPage());
      },
    ),
    GoRoute(
      name: RouterPage.songListDetail,
      path: '/songList/:songListId',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        int id = int.parse(state.pathParameters['songListId'] ?? "0");
        return _transitionBuild(
            context, state, SongListDetailPage(songListId: id));
      },
    ),
    GoRoute(
      name: RouterPage.albumList,
      path: '/albumList',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, AlbumListPage());
      },
    ),
    GoRoute(
      name: RouterPage.album,
      path: '/album/:albumId',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        int id = int.parse(state.pathParameters['albumId'] ?? "0");
        return _transitionBuild(context, state, AlbumPage(albumId: id));
      },
    ),
    GoRoute(
      name: RouterPage.search,
      path: '/search',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, const SearchPage());
      },
    ),
    GoRoute(
      name: RouterPage.mine,
      path: '/mine',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, MinePage());
      },
    ),
    GoRoute(
      name: RouterPage.setting,
      path: '/setting',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, SettingPage());
      },
    ),
    GoRoute(
      name: RouterPage.console,
      path: '/console',
      parentNavigatorKey: navigatorKey,
      pageBuilder: (context, state) {
        return _transitionBuild(context, state, ConsolePage());
      },
    ),
  ];
}

//切换动画
CustomTransitionPage _transitionBuild(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

//路由跳转监听
class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    LogUtil.d('GoRouterObserver didPush: $route  $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    LogUtil.d('GoRouterObserver didPop: $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    LogUtil.d('GoRouterObserver didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    LogUtil.d('GoRouterObserver didReplace: $newRoute');
  }
}
