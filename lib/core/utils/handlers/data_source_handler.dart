import 'package:dio/dio.dart';
import '../../error/exceptions.dart';

class DataSourceHandler {
  DataSourceHandler();

  dynamic call(
    Future<Response> Function() response,
  ) async {
    final res = await response();

    if (res.statusCode.toString().startsWith('2')) {
      return res.data;
    }
    // Failed with Server Exception
    if (res.statusCode.toString().startsWith('4')) {
      throw ServerException(res);
    }

    /// Todo here , this space for adding extra Status code depending on BackEnd status code response
    /// *** Should map general exception and map it to specific failure
    throw Exception();
  }
}
