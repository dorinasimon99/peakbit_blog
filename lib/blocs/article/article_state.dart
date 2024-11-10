part of 'article_cubit.dart';

sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class ArticleLoading extends ArticleState {}

final class ArticleSuccess extends ArticleState {
  final ArticleModel article;

  ArticleSuccess(this.article);
}

final class ArticleFailure extends ArticleState {
  final String? errorMessage;

  ArticleFailure({this.errorMessage});
}

final class ArticleNetworkError extends ArticleState {}
