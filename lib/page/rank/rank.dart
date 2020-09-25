import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  void initState() {
    super.initState();
    print('热门初始化方法...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('热门'),
      ),
      body: Center(
        child: Text('RankPage-->热门'),
      ),
    );
  }
}
