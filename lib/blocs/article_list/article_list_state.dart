part of 'article_list_cubit.dart';

sealed class ArticleListState {}

final class ArticleListInitial extends ArticleListState {}

final class ArticleListLoading extends ArticleListState {}

final class ArticleListSuccess extends ArticleListState {
  final ArticleListModel articleList;

  ArticleListSuccess({required this.articleList});
}

final class ArticleListFailure extends ArticleListState {
  final String? errorMessage;

  ArticleListFailure({this.errorMessage});
}

final class ArticleListNetworkError extends ArticleListState {}
