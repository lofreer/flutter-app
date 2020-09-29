import 'package:flutter/material.dart';
import 'package:demo/api/api_service.dart';
import 'package:demo/model/issue_model.dart';
import 'package:demo/util/toast_util.dart';

class VideoDetailPageModel with ChangeNotifier {
  List<Item> itemList = [];
  bool loading = true;
  bool error = false;
  int _videoId;

  void loadVideoRelateData(int id) {
    _videoId = id;
    ApiService.request('${ApiService.video_related_url}$id').then((res) {
      Issue issue = Issue.fromJson(res);
      itemList = issue.itemList;
      loading = false;
      error = false;
    }).catchError((e) {
      ToastUtil.showError(e.toString());
      loading = false;
      error = true;
    }).whenComplete(() => notifyListeners());
  }

  void retry() {
    loading = true;
    notifyListeners();
    loadVideoRelateData(_videoId);
  }
}
