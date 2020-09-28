
import 'package:demo/api/api_service.dart';
import 'package:demo/model/topic_model.dart';
import 'package:demo/provider/paging_list_model.dart';

class TopicPageModel extends PagingListModel<TopicItemModel,TopicModel>{

  @override
  String getUrl() {
    return ApiService.topics_url;
  }

  @override
  TopicModel getModel(Map<String, dynamic> json) {
    return TopicModel.fromJson(json);
  }

}
