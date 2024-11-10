import 'package:peakbit_blog/models/error/error_model.dart';

String getErrorMessage(dynamic errorMessage) {
  String concatenatedMessage = "";
  if(errorMessage is List<dynamic>) {
    List<ErrorModel> errors = errorMessage.map((element) => ErrorModel.fromJson(element)).toList();
    for (var error in errors) {
      concatenatedMessage += "${error.errorCode} ${error.message}\n";
    }
  } else {
    ErrorModel errorModel = ErrorModel.fromJson(errorMessage);
    concatenatedMessage = "${errorModel.errorCode} ${errorModel.message}";
  }

  return concatenatedMessage;
}