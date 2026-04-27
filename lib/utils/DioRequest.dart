// 基于Dio进行二次封装

import 'package:dio/dio.dart';
import 'package:my_shop/constants/index.dart';

class DioRequest {
  final _dio = Dio(); // dio请求对象
  // 基础地址拦截器
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    // 拦截器
    _addInterceptor();
  }
  // 添加拦截器
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) {
          // 1. 处理 HTTP 状态码
          if (response.statusCode! < 200 || response.statusCode! > 300) {
            handler.reject(
              DioException(requestOptions: response.requestOptions),
            );
            return;
          }

          // 2. 处理业务状态码
          final data = response.data as Map<String, dynamic>;
          if (data["code"] == GlobalConstants.SUCCESS_CODE) {
            // 直接替换 response.data，让调用方拿到 result
            response.data = data['result'];
            handler.next(response);
          } else {
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                message: data['msg'] ?? "请求异常",
              ),
            );
          }
        },
        onError: (error, handler) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data['msg'] ?? '',
            ),
          );
        },
      ),
    );
  }

  // GET方法
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    final res = await _dio.get(url, queryParameters: params);
    return res.data;
  }

  // POST方法
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
    final res = await _dio.post(url, data: data);
    return res.data;
  }
}

// 单例对象
final dioRequest = DioRequest();
