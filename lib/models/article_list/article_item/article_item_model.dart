import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_item_model.freezed.dart';
part 'article_item_model.g.dart';

@freezed
class ArticleItemModel with _$ArticleItemModel {
  const factory ArticleItemModel({
    required int id,
    required String title,
    required String imageUrl,
    required int readingTime,
  }) = _ArticleItemModel;

  factory ArticleItemModel.fromJson(Map<String, Object?> json) => _$ArticleItemModelFromJson(json);
}