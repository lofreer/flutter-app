import 'package:demo/config/string.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:demo/nav_router/manager.dart';

class Browser extends StatefulWidget {

  const Browser({Key key, this.url, this.title}) : super(key: key);

  final String url;
  final String title;

  @override
  _Browser createState() => _Browser();
}

class _Browser extends State<Browser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  _buildAppbar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Color(0xccd0d7),
        title: Text(widget.title ?? MString.news_title, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Color(0xFF23ADE5),), onPressed: () {
          NavigatorManager.pop();
        })
    );
  }

}
