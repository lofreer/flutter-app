import '../net/data_helper.dart';
import '../net/http_manager.dart';
import '../net/address.dart';

class Api {
  ///示例请求
  static request(String param) {
    var params = DataHelper.getBaseMap();
    params['param'] = param;
    return HttpManager.getInstance().get(Address.COURSE_LIST, params: params);
  }
}
