import 'server_error.dart';

class BaseDTOModel<T> {
  ServerError? _error;
  T? data;
  String? successMessage;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  ServerError? get getException {
    return _error;
  }
}
