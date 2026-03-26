import 'package:clean_architecture_test/features/auth/domain/entity/auth_token_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token_model.freezed.dart';

part 'auth_token_model.g.dart';

@freezed
abstract class AuthTokenModel with _$AuthTokenModel {
  const factory AuthTokenModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _AuthTokenModel;

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenModelFromJson(json);
}

extension AuthTokenModelExt on AuthTokenModel {
  AuthTokenEntity toEntity() =>
      AuthTokenEntity(accessToken: accessToken, refreshToken: refreshToken);
}
