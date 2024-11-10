import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required int id,
    required String title,
    required String description,
    required int readingTime,
    required String imageUrl,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, Object?> json) => _$ArticleModelFromJson(json);
}