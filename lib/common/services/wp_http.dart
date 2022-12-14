import 'dart:io';

import 'package:flutter_woo_commerce_getx_learn/common/index.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

class WPHttpService extends GetxService {
  static WPHttpService get to => Get.find<WPHttpService>();

  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    var options = BaseOptions(
      baseUrl: Constants.wpApiBaseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    _dio.interceptors.add(RequestInterceptors());
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Response response = await _dio.get(
      url,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.post(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.put(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  Future<Response> delete(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.delete(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }
}

/// ??????
class RequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // super.onRequest(options, handler);
    // if (UserService.to.hasToken) {
    //   options.headers['Authorization'] = 'Bearer ${UserService.to.token}';
    // }
    return handler.next(options);
    // ??????????????????????????????????????????????????????????????????resolve??????Response?????? `handler.resolve(response)`???
    // ????????????????????????????????????then???????????????then???????????????????????????????????????response.
    //
    // ?????????????????????????????????????????????,?????????????????????`DioError`??????,???`handler.reject(error)`???
    // ????????????????????????????????????????????????catchError???????????????
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 200 ????????????, 201 ????????????
    if (response.statusCode != 200 && response.statusCode != 201) {
      handler.reject(
        DioError(
          requestOptions: response.requestOptions,
          response: response,
          type: DioErrorType.response,
        ),
        true,
      );
    } else {
      handler.next(response);
    }
  }

  /// ?????????????????????
  // Future<void> _errorNoAuthLogout() async {
  //   await UserService.to.logout();
  //   Get.toNamed(RouteNames.systemLogin);
  // }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final exception = HttpException(err.message);
    switch (err.type) {
      case DioErrorType.response: // ?????????????????????????????????
        {
          // final response = err.response;
          // final errorMessage = ErrorMessageModel.fromJson(response?.data);
          // switch (errorMessage.statusCode) {
          //   case 401:
          //     _errorNoAuthLogout();
          //     break;
          //   case 404:
          //     break;
          //   case 500:
          //     break;
          //   case 502:
          //     break;
          //   default:
          //     break;
          // }
          // Loading.error(errorMessage.message);
        }
        break;
      case DioErrorType.other:
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectTimeout:
        break;
      default:
        break;
    }
    err.error = exception;
    handler.next(err);
  }
}
