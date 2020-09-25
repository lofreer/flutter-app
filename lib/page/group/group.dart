import 'package:flutter/material.dart';
import 'card_item.dart';

class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  void initState() {
    super.initState();
    print('小组初始化方法...');
  }

  @override
  Widget build(BuildContext context) {
    ///一个页面的开始
    ///如果是新页面，会自带返回按键
    return new Scaffold(
      ///背景样式
      backgroundColor: Colors.blue,
      ///标题栏，当然不仅仅是标题栏
      appBar: new AppBar(
        ///这个title是一个Widget
        title: new Text("Title"),
      ),
      ///正式的页面开始
      ///一个ListView，20个Item
      body: new ListView.builder(
        itemBuilder: (context, index) {
          return new DemoItem();
        },
        itemCount: 20,
      ),
    );
  }
}
