import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo/config/string.dart';
import 'package:demo/page/discovery/discovery.dart';
import 'package:demo/page/home/home.dart';
import 'package:demo/page/mine/mine.dart';
import 'package:demo/page/rank/rank.dart';
import 'package:demo/util/toast_util.dart';

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  DateTime lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomePage(),
              DiscoveryPage(),
              RankPage(),
              MinePage()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                _pageController.jumpToPage(index); //跳转到指定页面
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed, //显示标题
              items: [
                _bottomItem(MString.daily_paper, 'images/ic_home_normal.png',
                    'images/ic_home_selected.png', 0),
                _bottomItem(MString.discover, 'images/ic_discovery_normal.png',
                    'images/ic_discovery_selected.png', 1),
                _bottomItem(MString.hot, 'images/ic_hot_normal.png',
                    'images/ic_hot_selected.png', 2),
                _bottomItem(MString.mime, 'images/ic_mine_normal.png',
                    'images/ic_mine_selected.png', 3)
              ]),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      ToastUtil.showTip(MString.exit_tip);
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }

  _bottomItem(String title, String normalIcon, String selectIcon, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(normalIcon, width: 24, height: 24),
      activeIcon: Image.asset(selectIcon, width: 24, height: 24),
      title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(title,
              style: TextStyle(
                  color:
                      Color(_currentIndex == index ? 0xff000000 : 0xff9a9a9a),
                  fontSize: 14))),
    );
  }
}
