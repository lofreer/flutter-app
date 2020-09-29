import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/nav_router/manager.dart';
import 'package:flutter/material.dart';
import 'package:demo/model/topic_detail_model.dart';
import 'package:demo/provider/topic_detail_page_model.dart';
import 'package:demo/widget/loading_container.dart';
import 'package:demo/widget/provider_widget.dart';
import 'package:demo/widget/topic_detail_widget_item.dart';

class TopicDetailPage extends StatefulWidget {
  final int detailId;

  const TopicDetailPage({Key key, this.detailId}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TopicDetailPageModel>(
        model: TopicDetailPageModel(),
        onModelInit: (model) {
          model.loadTopicDetailData(widget.detailId);
        },
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: _appBar(model.topicDetailModel),
              body: LoadingContainer(
                  loading: model.loading,
                  error: model.error,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      _headWidget(model.topicDetailModel),
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        return TopicDetailWidgetItem(
                            model: model.itemList[index]);
                      }, childCount: model.itemList.length))
                    ],
                  ),
                  retry: model.retry));
        });
  }

  _appBar(TopicDetailModel topicDetailModel) {
    return AppBar(
      title: Text(
        topicDetailModel.brief,
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      brightness: Brightness.light,
      //白底黑字
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => NavigatorManager.pop()),
    );
  }

  _headWidget(TopicDetailModel topicDetailModel) {
    return SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  imageUrl: topicDetailModel.headerImage,
                  errorWidget: (context, url, error) =>
                      Image.asset('images/img_load_fail.png'),
                  fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: Text(
                  topicDetailModel.text,
                  style: TextStyle(fontSize: 12, color: Color(0xff9a9a9a)),
                ),
              ),
              Container(
                height: 5,
                color: Colors.black12,
              )
            ],
          ),
          Positioned(
              left: 20,
              right: 20,
              top: 230,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    topicDetailModel.brief,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFF5F5F5)),
                      borderRadius: BorderRadius.circular(4))))
        ],
      ),
    );
  }
}
