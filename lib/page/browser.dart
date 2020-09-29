import 'dart:convert';

import 'package:demo/config/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:demo/nav_router/manager.dart';

class Browser extends StatefulWidget {

  const Browser({Key key, this.url, this.isLocalUrl = false,}) : super(key: key);

  final String url;
  final bool isLocalUrl;

  @override
  _Browser createState() => _Browser();
}

class _Browser extends State<Browser> {
  WebViewController _webViewController;
  String title;

  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
    name: 'jsbridge', // 与h5 端的一致 不然收不到消息
    onMessageReceived: (JavascriptMessage message) async{
      debugPrint(message.message);
    }
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody()
    );
  }

  _buildAppbar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Color(0xccd0d7),
        title: Text(title ?? MString.news_title, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () async {
          if (await _webViewController.canGoBack()) {
            _webViewController.goBack();
          } else {
            NavigatorManager.pop();
          }
        })
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 1,
          width: double.infinity,
          child: const DecoratedBox(decoration: BoxDecoration(color: Color(0xFFEEEEEE))),
        ),
        Expanded(
          flex: 1,
          child: WebView(
            initialUrl: widget.isLocalUrl ? Uri.dataFromString(widget.url, mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
                .toString() : widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>[
              jsBridge(context)
            ].toSet(),
            onWebViewCreated: (WebViewController controller){
              _webViewController = controller;
              if(widget.isLocalUrl){
                _loadHtmlAssets(controller);
              }else{
                controller.loadUrl(widget.url);
              }
            },
            onPageFinished: (String value){
              _webViewController.evaluateJavascript('document.title').then((result) => {
                setState(() {
                  title = result;
                })
              });
            },
          ),
        )
      ],
    );
  }

  //加载本地文件
  _loadHtmlAssets(WebViewController controller) async {
    String htmlPath = await rootBundle.loadString(widget.url);
    controller.loadUrl(Uri.dataFromString(htmlPath,mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

}
