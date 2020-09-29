import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:demo/config/color.dart';
import 'package:demo/model/news_model.dart';
import 'package:demo/page/web_page.dart';
import 'package:demo/page/browser.dart';
import 'package:demo/nav_router/manager.dart';

class NewsTitleWidgetItem extends StatelessWidget {
  final NewsItemModel newsItemModel;

  const NewsTitleWidgetItem({Key key, this.newsItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5),
      child: Text(newsItemModel.data.text,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff3f3f3f))),
    );
  }
}

class NewsContentWidgetItem extends StatelessWidget {
  final NewsItemModel newsItemModel;

  const NewsContentWidgetItem({Key key, this.newsItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          String url = Uri.decodeComponent(newsItemModel.data.actionUrl
              .substring(newsItemModel.data.actionUrl.indexOf("url")));
          url = url.substring(4, url.length);
          NavigatorManager.push(Browser(url: 'https://h5.koudaikaoyan.com'));
        },
        child: Padding(
            padding: EdgeInsets.all(10),
            child: PhysicalModel(
              color: Color(0xFFEDEDED),
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            imageUrl: newsItemModel.data.backgroundImage,
                            errorWidget: (context, url, error) =>
                                Image.asset('images/img_load_fail.png'),
                            fit: BoxFit.fill),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _getTitleList(newsItemModel.data.titleList),
                      )
                    ],
                  )),
            )));
  }

  List<Widget> _getTitleList(List<String> titleList) {
    return titleList.map((title) {
      return Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(title,
              style: TextStyle(color: MColor.desTextColor, fontSize: 12),
              maxLines: 3,
              overflow: TextOverflow.ellipsis));
    }).toList();
  }
}
