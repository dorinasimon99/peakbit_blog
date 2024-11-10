import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_model.freezed.dart';
part 'token_model.g.dart';

@freezed
class TokenModel with _$TokenModel {
  const factory TokenModel({
    required String platform,
    required String token,
    required int availableUsages
  }) = _TokenModel;

  factory TokenModel.fromJson(Map<String, Object?> json) => _$TokenModelFromJson(json);
}