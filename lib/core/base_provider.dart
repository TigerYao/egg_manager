import 'package:get/get.dart';
import 'package:egg_service_manager/service_manager.dart';

import 'base_model.dart';

typedef ResponseInterceptor = bool Function(dynamic data);

const String _defaultBaseUrl = 'https://hooks.slack.com/services/';

class BaseProvider extends GetConnect {
  String? serviceUrl = _defaultBaseUrl;

  BaseProvider({this.serviceUrl});

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = serviceUrl;
  }

  void onTokenChange(String token){
    httpClient.addRequestModifier((request) {
      final String token = ServiceManager().getValue<String>('token');
      request.headers['token'] = token;
      return request;
    });
  }

  Future<Response<T>> requestData<T extends BaseMode>(String path,
      dynamic params,
      {bool isPost = true}) {
    if (isPost) {
      return post(path, params);
    }
    if (params?.isNotEmpty == true && params is BaseMode) {
      return get(path, query: params.toJson());
    } else if (params?.isNotEmpyt == true && params is Map<String, dynamic>)
      return get(path, query: params);
    else
      return get(path);
  }

  Future<Response<T>> getData<T extends BaseMode>(String path, dynamic params,
      {ResponseInterceptor? success,
        ResponseInterceptor? fail,
        bool isPost = true}) {
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
