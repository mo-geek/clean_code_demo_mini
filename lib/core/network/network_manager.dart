import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:nawytask/core/error/exceptions.dart';
import 'package:nawytask/core/utils/constant.dart';

class NetworkManager {
  final Dio dio;

  const NetworkManager._(this.dio);

  factory NetworkManager() {
    final dio = Dio();

    dio.interceptors.add(const ErrorCodesInterceptor());

    return NetworkManager._(dio);
  }

  Future<Response<T>> request<T>({
    required RequestMethod method,
    String baseUrl = kBaseUrl,
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.request(
      baseUrl + endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        method: method.name.toUpperCase(),
      ),
    );
  }
}

enum RequestMethod {
  get,
  head,
  post,
  put,
  delete,
  connect,
  options,
  trace,
  patch,
}

class ErrorCodesInterceptor implements Interceptor {
  const ErrorCodesInterceptor();
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    Logger().e("${err.toString() + "\n" + err.requestOptions.uri.toString()}");
    throw ServerException(err.response);

    // handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
    // Logger().e(options.data);
    // Logger().e(options.uri);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    handler.next(response);
    // Logger().e(response.statusCode);
    // Logger().e(response.data);
  }
}
