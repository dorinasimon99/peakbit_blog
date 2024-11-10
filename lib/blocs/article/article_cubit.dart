import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:peakbit_blog/common/error_message_handler.dart';
import 'package:peakbit_blog/models/article/article_model.dart';
import 'package:peakbit_blog/repositories/article_repository.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final ArticleRepository _articleRepository = ArticleRepository();

  ArticleCubit() : super(ArticleInitial());

  void getArticle({required int id}) async {
    emit(ArticleLoading());
    try {
      ArticleModel? article = await _articleRepository.getArticle(id: id);
      if(article != null) {
        emit(ArticleSuccess(article));
      } else {
        if(_articleRepository.errorMessage != null) {
          emit(ArticleFailure(errorMessage: _articleRepository.errorMessage));
        } else {
          emit(ArticleFailure());
        }
      }
    } catch (e) {
      if(e is DioException) {
        if(e.type == DioExceptionType.connectionError) {
          emit(ArticleNetworkError());
        } else {
          String errorMessage = getErrorMessage(e.response?.data);
          emit(ArticleFailure(errorMessage: errorMessage));
        }
      } else {
        emit(ArticleFailure(errorMessage: e.toString()));
      }
    }
  }

}
