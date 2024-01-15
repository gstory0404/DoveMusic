import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/manager/audio_manager.dart';
import 'package:dovemusic/pages/home/home_page.dart';
import 'package:dovemusic/pages/mine/mine_page.dart';
import 'package:dovemusic/pages/play/play_page.dart';
import 'package:dovemusic/pages/play/play_provider.dart';
import 'package:dovemusic/utils/log/log_util.dart';
import 'package:dovemusic/widget/background_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';
import 'package:logger/logger.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/4/26 18:19
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
class IndexMobilePage extends ConsumerStatefulWidget {
  IndexMobilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndexMobilePageState();
}

class _IndexMobilePageState extends ConsumerState<IndexMobilePage>
    with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;

  //PageController
  late PageController _pageController;
  late final AnimationController _repeatController;
  late final Animation<double> _animation;

  final List<Widget> _pages = [
    HomePage(),
    MinePage(),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentIndex, keepPage: true);
    //旋转动画
    _repeatController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_repeatController);
  }

  @override
  Widget build(BuildContext context) {
    var isPlaying = ref.watch(playProvider.select((value) => value.isPlaying));
    ref.listen(playProvider, (previous, next) {
      if (previous?.isPlaying != next.isPlaying) {
        next.isPlaying ? _repeatController.repeat() : _repeatController.stop();
      }
    });
    return Stack(
      children: [
        BackGroundWidget(
          child: Scaffold(
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
            bottomNavigationBar: BottomAppBar(
              notchMargin: 6,
              shape: const CircularNotchedRectangle(),
              child: Row(
                //里边可以放置大部分Widget，让我们随心所欲的设计底栏
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _tabItem(
                    position: 0,
                    curPosition: _currentIndex,
                    iconData: Icons.my_library_music,
                    label: S.current.library,
                  ),
                  _tabItem(
                    position: 1,
                    curPosition: _currentIndex,
                    iconData: Icons.people,
                    label: S.current.mine,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                PlayPage.go(context);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RotationTransition(
                    turns: _animation,
                    child: ClipOval(
                      child: Consumer(
                        builder: (context, ref, _) {
                          return PlaceholderImage(
                            width: 80,
                            height: 80,
                            image: ref.watch(
                              playProvider.select(
                                  (value) => value.musicEntity?.picture ?? ""),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Icon(
                    isPlaying
                        ? Icons.pause_circle_outline_outlined
                        : Icons.play_circle_outlined,
                    size: 26,
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        ),
      ],
    );
  }

  Widget _tabItem(
      {required int position,
      required int curPosition,
      required IconData iconData,
      required String label}) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          _currentIndex = position;
          _pageController.jumpToPage(_currentIndex);
        });
      },
      child: Container(
        child: Column(
          children: [
            Icon(
              iconData,
              color: position == curPosition
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              size: 26,
            ),
            Text(
              label,
              style: TextStyle(
                color: position == curPosition
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
