class NetworkException extends _AppException {
  NetworkException([message]) : super(message);
}

class LogoutException extends _AppException {
  LogoutException([message]) : super(message);
}

class AuthTokenException extends _AppException {
  AuthTokenException([message]) : super(message);
}

class UserNotFoundException extends _AppException {
  UserNotFoundException([message]) : super(message);
}

class SchoolNotFoundException extends _AppException {
  SchoolNotFoundException([message]) : super(message);
}

class ProfessionException extends _AppException {
  ProfessionException([message]) : super(message);
}

class WorkPhotosException extends _AppException {
  WorkPhotosException([message]) : super(message);
}

class DocumentsException extends _AppException {
  DocumentsException([message]) : super(message);
}

class ResponseException extends _AppException {
  ResponseException([
    String? message,
    String? prefix,
  ]) : super(message, prefix ?? 'Response: ');
}

class _AppException implements Exception {
  _AppException([
    this._message,
    this._prefix,
  ]);

  final String? _message;
  final dynamic _prefix;

  @override
  String toString() {
    return '${_prefix ?? ''}${_message ?? 'Error'}';
  }
}
