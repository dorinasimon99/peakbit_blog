import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../common/error_message_handler.dart';
import '../models/article_list/article_list_model.dart';
import '../services/network_service.dart';

class ArticleListRepository {
  final _dio = NetworkService.instance.dio;
  String? errorMessage;

  Future<ArticleListModel?> getArticles({int page = 1, int pageSize = 4}) async {
    try {
      Response response = await _dio.get('/articles/list?page=$page&pageSize=$pageSize');
      if(response.statusCode == 200) {
        ArticleListModel articles = ArticleListModel.fromJson(response.data);
        return articles;
      } else if(response.statusCode == 401) {
        response = await _dio.get('/articles/list?page=$page&pageSize=$pageSize');
        if(response.statusCode == 200) {
          ArticleListModel articles = ArticleListModel.fromJson(response.data);
          return articles;
        }
        return null;
      } else {
        errorMessage = getErrorMessage(response.data);
        debugPrint('Get article list error: \n$errorMessage');
      }
    } catch (e) {
      if(e is DioException) {
        errorMessage = getErrorMessage(e.response?.data);
        debugPrint('Get article list error: $errorMessage');
      } else {
        debugPrint('Get article list error: ${e.toString()}');
      }
    }
    return null;
  }
}