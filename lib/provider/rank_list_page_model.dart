import 'package:flutter/material.dart';
import 'package:demo/api/api_service.dart';
import 'package:demo/model/issue_model.dart';
import 'package:demo/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListPageModel with ChangeNotifier {
  List<Item> itemList = [];
  bool loading = true;
  bool error = false;
  String apiUrl;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init(String apiUrl) {
    this.apiUrl = apiUrl;
  }

  void loadData(){
    ApiService.request(apiUrl,
        success: (result) {
          Issue issueModel = Issue.fromJson(result);

          itemList = issueModel.itemList;
          loading = false;
          error = false;
          refreshController.refreshCompleted();
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          refreshController.refreshFailed();
          loading = false;
          error = true;
        },
        complete: () => notifyListeners());
  }

  retry(){
    loading = true;
    notifyListeners();
    loadData();
  }
}
