import 'package:demo/config/string.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:demo/nav_router/manager.dart';

class Browser extends StatefulWidget {

  const Browser({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _Browser createState() => _Browser();
}

class _Browser extends State<Browser> {
  WebViewController _controller;
  String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) => {
            _controller.evaluateJavascript("document.title").then((result){
              setState(() {
                title = result;
              });
            }
          )
        },
        onPageStarted: (url) => {
          print('url: '+url)
        },
      ),
    );
  }

  _buildAppbar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Color(0xccd0d7),
        title: Text(title ?? MString.news_title, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Color(0xFF23ADE5),), onPressed: () async {
          if (await _controller.canGoBack()) {
            _controller.goBack();
          } else {
            NavigatorManager.pop();
          }
        })
    );
  }

}
