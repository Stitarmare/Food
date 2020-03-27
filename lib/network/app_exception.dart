import 'package:foodzi/Utils/String.dart';

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, STR_ERROR_COMMUNICATION);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, STR_INVALID_REQUEST);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, STR_UNAUTHORISED);
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, STR_INVALID_INPUT);
}
