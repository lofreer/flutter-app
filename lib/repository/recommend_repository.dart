import 'package:demo/api/api_service.dart';
import 'package:demo/model/recommend_model.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:demo/util/toast_util.dart';

class RecommendRepository extends LoadingMoreBase<RecommendItem> {
  String nextPageUrl;
  bool _hasMore = true;
  bool forceRefresh = false;

  @override
  bool get hasMore => _hasMore || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    forceRefresh = !notifyStateChanged;
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    String url = '';
    if (isloadMoreAction) {
      url = nextPageUrl;
    } else {
      url = ApiService.community_url;
    }
    bool isSuccess = true;

    try {
      var result = await ApiService.request(url);
      RecommendModel model = RecommendModel.fromJson(result);
      model.itemList.removeWhere((item) {
        return item.type == 'horizontalScrollCard';
      });
      if (!isloadMoreAction) {
        clear();
      }
      addAll(model.itemList);
      nextPageUrl = model.nextPageUrl;
      _hasMore = nextPageUrl != null;
      isSuccess = true;
    } catch (e) {
      isSuccess = false;
      ToastUtil.showError(e.toString());
    }

    return isSuccess;
  }
}
