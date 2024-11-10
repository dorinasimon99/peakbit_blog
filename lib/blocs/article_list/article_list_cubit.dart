import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:peakbit_blog/models/article_list/article_list_model.dart';
import 'package:peakbit_blog/repositories/article_list_repository.dart';

import '../../common/error_message_handler.dart';

part 'article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  final ArticleListRepository _articleListRepository = ArticleListRepository();

  ArticleListCubit() : super(ArticleListInitial());

  Future<void> getArticleList({int page = 1, int pageSize = 4}) async {
    emit(ArticleListLoading());
    try {
      ArticleListModel? articleList = await _articleListRepository.getArticles(page: page, pageSize: pageSize);
      if(articleList != null) {
        emit(ArticleListSuccess(articleList: articleList));
      } else {
        if(_articleListRepository.errorMessage != null) {
          emit(ArticleListFailure(errorMessage: _articleListRepository.errorMessage));
        } else {
          emit(ArticleListFailure());
        }
      }
    } catch (e) {
      if(e is DioException) {
        if(e.type == DioExceptionType.connectionError) {
          emit(ArticleListNetworkError());
        } else {
          String errorMessage = getErrorMessage(e.response?.data);
          emit(ArticleListFailure(errorMessage: errorMessage));
        }
      } else {
        emit(ArticleListFailure(errorMessage: e.toString()));
      }
    }
  }
}
