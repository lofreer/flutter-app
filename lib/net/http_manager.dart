import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'code.dart';
import 'dio_log_interceptor.dart';
import 'response_interceptor.dart';
import 'pretty_dio_logger.dart';
import 'result_data.dart';
import 'address.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(baseUrl: Address.BASE_URL, connectTimeout: 15000));
      _dio.interceptors.add(new DioLogInterceptor());
      _dio.interceptors.add(new PrettyDioLogger());
      _dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Address.BASE_URL) {
        _dio.options.baseUrl = Address.BASE_URL;
      }
    }
    return this;
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  _request({
    @required String url,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    withLoading = true
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      EasyLoading.showError("请求网络异常，请稍后重试！");
      return;
    }

    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';

    options?.method = method;

    options = options ?? Options(method: method);

    // headers设置
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('user_token') ?? '';
    if (accessToken != null) {
      options = options.merge(headers: {"Authorization": accessToken});
    }
    url = _restfulUrl(url, params);

    if (withLoading) {
      EasyLoading.show(status: 'loading...');
    }

    Response response;
    try {
      response = await _dio.request(url,
        data: data,
        queryParameters: params,
        options: options);
      if (withLoading) {
        EasyLoading.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        EasyLoading.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///通用的GET请求
  get(String url, {params, withLoading = true}) async {

    return await _request(
      url: url,
      method: 'get',
      params: params,
    );
  }

  ///通用的POST请求
  post(String url, {params, withLoading = true}) async {

    return await _request(
      url: url,
      method: 'post',
      data: params,
    );
  }

  ///restful处理
  String _restfulUrl(String url, Map<String, dynamic> params) {
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

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = new Response(statusCode: 666);
  }
  if (e.type == DioErrorType.CONNECT_TIMEOUT ||
      e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  }
  return new ResultData(
      errorResponse.statusMessage, false, errorResponse.statusCode);
}
