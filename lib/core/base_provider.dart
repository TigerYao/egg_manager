import 'dart:convert';

import 'package:get/get.dart';
import 'package:egg_manager/service_manager.dart';

import 'base_model.dart';

typedef ResponseInterceptor = void Function(dynamic data);

const String _defaultBaseUrl = 'https://hooks.slack.com/services/';

class BaseProvider extends GetConnect {
  String serviceUrl;

  BaseProvider({this.serviceUrl = _defaultBaseUrl});

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = serviceUrl;
  }

  void onTokenChange(String token) {
    httpClient.addRequestModifier<dynamic>((request) {
      final String token = ServiceManager().getValue<String>('token') ?? '';
      request.headers['token'] = token;
      return request;
    });
  }

  Future<Response<T>> requestData<T>(String path, dynamic params, {bool isPost = true}) {
    var req = {'text': params};
    if (params != null && params is BaseMode) {
      req = {'text': json.encode(params)};
    }
    return isPost ? post(path, req) : get(path, query: req);
  }

  Future<Response<T>> getData<T>(String path, dynamic params,
      {ResponseInterceptor? success, ResponseInterceptor? fail, bool isPost = true}) {
    Future<Response<T>> result = requestData<T>(path, params, isPost: isPost);
    if (success != null && fail != null)
      result.then((Response<T> value) {
        if (value.hasError)
          fail(value.statusText);
        else
          success(value.body);
      });
    return result;
  }
}
