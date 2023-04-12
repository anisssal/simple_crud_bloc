import 'package:dio/dio.dart' hide Headers;

import 'error_response.dart';

class ServerError implements Exception {
  int? _errorCode;
  String? _errorMessage = "";

  ServerError.withUserError(this._errorMessage);

  ServerError.withError({required Object? error}) {
    if(error ==null || error is! DioError ){
      _errorMessage = "Unknown Error";
    }else{
      _handleError(error);
    }
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.other:
        _errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.response:
        final Response? res = error.response;
        _errorCode = error.response?.statusCode;
        print("errorny $res" );
        if(_errorCode == 400) {
          _errorMessage = ErrorResponse.fromJson(res?.data).message;
          break ;
        }
        if(_errorCode==401){
          _errorMessage = ErrorResponse.fromJson(res?.data).message;
          break ;
        }
        _errorMessage = "Received invalid status code: ${error.response?.statusCode}";
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        break;

    }

    return _errorMessage;
  }
}