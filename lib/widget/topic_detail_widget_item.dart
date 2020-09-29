import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/nav_router/manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/config/color.dart';
import 'package:demo/config/string.dart';
import 'package:demo/model/topic_detail_model.dart';
import 'package:demo/page/home/video_detail_page.dart';
import 'package:demo/util/date_util.dart';
import 'package:demo/util/share_util.dart';

class TopicDetailWidgetItem extends StatelessWidget {
  final TopicDetailItemData model;

  const TopicDetailWidgetItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            NavigatorManager.push(VideoDetailPage(data: model.data.content.data)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headWidget(),
            _desWidget(),
            _tagWidget(),
            _feedWidget(context),
            _consumptionWidget(),
            _dividerWidget()
          ],
        ));
  }

  Widget _headWidget() {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
            child: ClipOval(
                child: CachedNetworkImage(
              width: 45,
              height: 45,
              imageUrl:
                  model.data.header.icon == null ? '' : model.data.header.icon,
            ))),
        Expanded(
            child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.data.header.issuerName == null
                    ? ''
                    : model.data.header.issuerName,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Row(
                children: <Widget>[
                  Text(
                    '${DateUtils.formatDateMsByYMD(model.data.header.time)}发布：',
                    style: TextStyle(color: MColor.hitTextColor, fontSize: 12),
                  ),
                  Expanded(
                      child: Text(
                    model.data.content.data.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ))
                ],
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget _desWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Text(
        model.data.content.data.description,
        style: TextStyle(fontSize: 14, color: MColor.desTextColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget _tagWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: _getTagWidgetList(model),
      ),
    );
  }

  Widget _feedWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              child: Hero(
                  tag: '${model.id}${model.data.content.data.time}',
                  child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      imageUrl: model.data.content.data.cover.feed,
                      errorWidget: (context, url, error) =>
                          Image.asset('images/img_load_fail.png'),
                      fit: BoxFit.cover)), //充满容器，可能会被截断
              borderRadius: BorderRadius.circular(4)),
          Positioned(
              right: 8,
              bottom: 8,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.black54),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        DateUtils.formatDateMsByMS(
                            model.data.content.data.duration * 1000),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ))))
        ],
      ),
    );
  }

  Widget _consumptionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.favorite_border, size: 20, color: MColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                  '${model.data.content.data.consumption.collectionCount}',
                  style: TextStyle(fontSize: 12, color: MColor.hitTextColor)),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.message, size: 20, color: MColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('${model.data.content.data.consumption.replyCount}',
                  style: TextStyle(fontSize: 12, color: MColor.hitTextColor)),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.star_border, size: 20, color: MColor.hitTextColor),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(MString.collect_text,
                  style: TextStyle(fontSize: 12, color: MColor.hitTextColor)),
            )
          ],
        ),
        IconButton(
            icon: Icon(Icons.share, color: MColor.hitTextColor),
            onPressed: () => ShareUtil.share(model.data.content.data.title,
                model.data.content.data.webUrl.forWeibo))
      ],
    );
  }

  Widget _dividerWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Divider(
        height: 0.5,
      ),
    );
  }

  List<Widget> _getTagWidgetList(TopicDetailItemData itemData) {
    List<Widget> widgetList = itemData.data.content.data.tags.map((tag) {
      return Container(
          margin: EdgeInsets.only(right: 5),
          alignment: Alignment.center,
          height: 20,
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: MColor.tabBgColor, borderRadius: BorderRadius.circular(4)),
          child: Text(
            tag.name,
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ));
    }).toList();
    return widgetList.length > 3 ? widgetList.sublist(0, 3) : widgetList;
  }
}
