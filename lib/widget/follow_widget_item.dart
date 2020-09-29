import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:demo/model/issue_model.dart';
import 'package:demo/page/home/video_detail_page.dart';
import 'package:demo/util/date_util.dart';
import 'package:demo/nav_router/manager.dart';

class FollowWidgetItem extends StatelessWidget {
  final Item item;

  const FollowWidgetItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
          NavigatorManager.push(VideoDetailPage(data: item.data))
        },
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Hero(
                        tag: '${item.data.id}${item.data.time}',
                        child: CachedNetworkImage(
                          width: 300,
                          height: 180,
                          imageUrl: item.data.cover.feed,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                      right: 8,
                      top: 8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(color: Colors.white54),
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                item.data.category,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ))))
                ],
              ),
              Container(
                width: 300,
                padding: EdgeInsets.only(top: 3),
                child: Text(item.data.title,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              Container(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                    DateUtils.formatDateMsByYMDHM(
                        item.data.author.latestReleaseTime),
                    style: TextStyle(fontSize: 12, color: Colors.black26)),
              )
            ],
          ),
        ));
  }
}
