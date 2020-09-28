import 'package:flutter/material.dart';
import 'package:demo/api/api_service.dart';
import 'package:demo/model/category_model.dart';
import 'package:demo/util/toast_util.dart';

class CategoryPageModel with ChangeNotifier {
  List<CategoryModel> list = [];
  bool loading = true;
  bool error = false;

  void loadData() async {
    ApiService.request(ApiService.category_url,
        success: (result) {
          List responseList = result as List;
          List<CategoryModel> categoryList = responseList
              .map((model) => CategoryModel.fromJson(model))
              .toList();
          this.list = categoryList;
          loading = false;
          error = false;
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
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
