import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class ApiService {
  ApiService._();

  static const base_url = 'http://baobab.kaiyanapp.com/api/';

  static const feed_url = '${base_url}v2/feed?num=1';

  static const follow_url = '${base_url}v4/tabs/follow';

  static const community_url = '${base_url}v7/community/tab/rec';

  static const rank_url = '${base_url}v4/rankList';

  static const category_url = '${base_url}v4/categories';

  static const video_related_url = '${base_url}v4/video/related?id=';

  static const keyword_url = '${base_url}v3/queries/hot';

  static const topics_url = '${base_url}v3/specialTopics';

  static const topics_detail_url = '${base_url}v3/lightTopics/internal/';

  static const news_url = '${base_url}v7/information/list?vc=6030000&deviceModel=';

  static const search_url = "${base_url}v1/search?query=";

  static const category_video_url = '${base_url}v4/categories/videoList?';


  static Dio _dio;

  static Dio getInstance() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 10000,
      );
      _dio = new Dio(options);
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print('=============================request============================');
        print('url:${options.uri}');
        print('method ${options.method}');
        print('headers:${options.headers}');
        print('data:\n${options.data}');
        print('queryParameters:\n${options.queryParameters}');
        return options;
      }, onResponse: (Response response) {
        print('=============================response============================');
        print('url:${response.request.uri}');
        print('response:${response.data}');
        return response;
      }, onError: (DioError e) {
        print('Error url:${e.request.uri}');
        return e;
      }));

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
          client.findProxy = (url) {
            ///设置代理 电脑ip地址
            // return "PROXY 127.0.0.1:8888";

            ///不设置代理
            return 'DIRECT';
          };

          ///忽略证书
          // client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
    return _dio;
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[success] 请求成功回调
  ///[fail] 请求失败回调
  ///[complete] 请求失败回调
  ///[options] 请求配置
  static request(String url, {
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    Function success,
    Function fail,
    Function complete
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (fail != null) {
        fail("网络异常，请稍后重试！");
      }
      return;
    }

    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';

    options?.method = method;

    options = options ?? Options(method: method);

    // headers设置
    // final prefs = await SharedPreferences.getInstance();
    // final accessToken = prefs.getString('user_token') ?? '';
    // if (accessToken != null) {
    //   options = options.merge(headers: {"Authorization": accessToken});
    // }

    url = _restfulUrl(url, params);

    try {
      Response response = await getInstance().request(url, data: data, queryParameters: params, options: options);
      if (success != null) {
        success(response.data);
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      if (fail != null) {
        fail(e);
      } else {
        throw e;
      }
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  ///restful处理
  static String _restfulUrl(String url, Map<String, dynamic> params) {
    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }
}
