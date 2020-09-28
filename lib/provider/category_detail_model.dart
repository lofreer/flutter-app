import 'package:flutter/material.dart';
import 'package:demo/api/api_service.dart';
import 'package:demo/model/issue_model.dart';
import 'package:demo/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryDetailModel extends ChangeNotifier {
  int category;
  List<Item> itemList = [];
  String _nextPageUrl;
  bool loading = true;
  bool error = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  bool expend = true;

  CategoryDetailModel(this.category);

  void loadMore({loadMore = true}) async {
    String url;
    if (loadMore) {
      if (_nextPageUrl == null) {
        refreshController.loadNoData();
        return;
      }
      url = _nextPageUrl +
          "&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url, loadMore);
    } else {
      url = ApiService.category_video_url +
          "id=$category&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url, loadMore);
    }
  }

  void getData(String url, bool loadMore) {
    ApiService.request(url,
      success: (result) {
        Issue issue = Issue.fromJson(result);
        loading = false;
        if (!loadMore) error = false;
        itemList.addAll(issue.itemList);
        _nextPageUrl = issue.nextPageUrl;
        refreshController.loadComplete();
      },
      fail: (e) {
        loading = false;
        if (!loadMore) error = true;
        ToastUtil.showError(e.toString());
        refreshController.loadFailed();
      },
      complete: () => notifyListeners()
    );
  }

  retry(){
    loading = true;
    notifyListeners();
    loadMore(loadMore: false);
  }

  void changeExpendStatusByOffset(int statusBarHeight, int offset) {
    if (offset > statusBarHeight && offset < 250) {
      if (!expend) {
        expend = true;
      }
    } else {
      if (expend) {
        expend = false;
      }
    }
  }
}
