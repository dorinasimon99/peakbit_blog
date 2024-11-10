import 'dart:convert';

import 'package:peakbit_blog/models/error/error_model.dart';

String getErrorMessage(String errorMessage) {
  String concatenatedMessage = "";
  if(jsonDecode(errorMessage) is List<dynamic>) {
    List<ErrorModel> errors = (jsonDecode(errorMessage) as List<dynamic>).map((element) => ErrorModel.fromJson(element)).toList();
    for (var error in errors) {
      concatenatedMessage += "${error.errorCode} ${error.message}\n";
    }
  } else {
    ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(errorMessage) as Map<String, dynamic>);
    concatenatedMessage = "${errorModel.errorCode} ${errorModel.message}";
  }

  return concatenatedMessage;
}