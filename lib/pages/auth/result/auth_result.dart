import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult<T> with _$AuthResult<T> {
  factory AuthResult.success(T response) = Sucess;
  factory AuthResult.error(String message) = Error;
}
