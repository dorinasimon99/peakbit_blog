import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_model.freezed.dart';
part 'meta_model.g.dart';

@freezed
class MetaModel with _$MetaModel {
  const factory MetaModel({
    required int currentPage,
    required int pageCount,
    required int pageSize,
    required int count,
  }) = _MetaModel;

  factory MetaModel.fromJson(Map<String, Object?> json) => _$MetaModelFromJson(json);
}