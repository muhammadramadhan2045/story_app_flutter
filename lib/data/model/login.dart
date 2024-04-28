import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login.g.dart';
part 'login.freezed.dart';

@freezed
class Login with _$Login {
  // bool? error;
  // String? message;
  // LoginResult? loginResult;

  // Login({this.error, this.message, this.loginResult});
  const factory Login({
    bool? error,
    String? message,
    LoginResult? loginResult,
  }) = _Login;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}

@Freezed()
class LoginResult with _$LoginResult {
  const factory LoginResult({
    String? token,
    String? name,
    String? email,
  }) = _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);
}
