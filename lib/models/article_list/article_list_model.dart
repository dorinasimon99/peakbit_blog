import 'package:freezed_annotation/freezed_annotation.dart';

import 'article_item/article_item_model.dart';

part 'article_list_model.freezed.dart';
part 'article_list_model.g.dart';

@freezed
class ArticleListModel with _$ArticleListModel {
  const factory ArticleListModel({
    required List<ArticleItemModel> list,
  }) = _ArticleListModel;

  factory ArticleListModel.fromJson(Map<String, Object?> json) => _$ArticleListModelFromJson(json);
}
