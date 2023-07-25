import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/handlers/error_message_handler.dart';

class ServerException implements Exception {
  Response<dynamic>? response;
  ServerException(this.response);

  @override
  String toString() {
    String errorMessage = 'Server Error!';
    try {
      if (response?.data is Map) {
        if (response?.data['message'] != null) {
          errorMessage =
              response?.data['message']?.toString() ?? 'ERROR MESSAGE';
        } else if (response?.data['errors'] is List) {
          final List<dynamic> errors = response?.data['errors'] as List;
          errorMessage = "";
          errors.forEach((e) {
            errorMessage =
                errorMessage + ErrorMassageHandler()(e as String) + "\n";
          });
          if (errorMessage == "") {
            errorMessage = "Server Error!";
          }
        }
      } else if (response?.statusMessage.toString() != 'null') {
        errorMessage = response?.statusMessage?.toString() ?? 'ERROR';
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return errorMessage;
  }
}

class DataParsingException implements Exception {
  final String cause;
  DataParsingException(this.cause);
}
