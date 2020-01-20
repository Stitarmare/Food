class AuthModel {
  final bool sessionExpired;
  final String message;

  AuthModel({this.sessionExpired, this.message});

  factory AuthModel.fromMap(Map<String, dynamic> json) {
    return AuthModel(
        sessionExpired: json['session_expired'], message: json['message']);
  }
}
