import 'package:flutter/material.dart';
import 'package:demo/config/color.dart';
import 'package:demo/page/discovery/recommend_page.dart';
import 'package:demo/page/discovery/topics_page.dart';
import 'package:demo/page/discovery/category_page.dart';
import 'package:demo/page/discovery/follow_page.dart';
import 'package:demo/page/discovery/news_list_page.dart';

const TAB_LABEL = ['关注', '分类', '专题', '资讯', '推荐'];

final List<Color> colorList = [
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.pink,
  Colors.teal,
  Colors.deepPurpleAccent
];

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
  }

  Widget renderTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("this.title"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          this.renderTitle('SliverGrid'),
          SliverGrid.count(
            crossAxisCount: 3,
            children: colorList.map((color) => Container(color: color)).toList(),
          ),
          this.renderTitle('SliverList'),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(color: colorList[index]),
              childCount: colorList.length,
            ),
            itemExtent: 100,
          ),
          new SliverAppBar(
            title: Text("Silver AppBar With ToolBar"),
            pinned: true,
            expandedHeight: 160.0,
            bottom: new TabBar(
              tabs: TAB_LABEL.map((String label) {
                    return Tab(text: label);
                  }).toList(),
              controller: _tabController,
            ),
          ),
          new SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                FollowPage(),
                CategoryPage(),
                TopicsPage(),
                NewsListPage(),
                RecommendPage()
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
