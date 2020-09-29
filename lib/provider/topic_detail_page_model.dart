import 'package:flutter/material.dart';
import 'package:demo/api/api_service.dart';
import 'package:demo/model/topic_detail_model.dart';
import 'package:demo/util/toast_util.dart';

class TopicDetailPageModel with ChangeNotifier {
  TopicDetailModel topicDetailModel = TopicDetailModel();
  List<TopicDetailItemData> itemList = [];

  bool loading = true;
  bool error = false;
  int _id;

  void loadTopicDetailData(int id) {
    _id = id;
    ApiService.request('${ApiService.topics_detail_url}$id').then((res) {
      topicDetailModel = TopicDetailModel.fromJson(res);
      itemList = topicDetailModel.itemList;
      loading = false;
      error = false;
    }).catchError((e) {
      ToastUtil.showError(e.toString());
      loading = false;
      error = true;
    }).whenComplete(() => notifyListeners());
  }

  retry() {
    loading = true;
    notifyListeners();
    loadTopicDetailData(_id);
  }
}
