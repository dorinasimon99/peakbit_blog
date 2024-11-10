import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../common/error_message_handler.dart';
import '../models/article/article_model.dart';
import '../services/network_service.dart';

class ArticleRepository {
  final _dio = NetworkService.instance.dio;

  Future<ArticleModel?> getArticle({required int id}) async {
    try {
      Response response = await _dio.get('/articles/get/$id');
      if(response.statusCode == 200) {
        ArticleModel article = ArticleModel.fromJson(response.data);
        return article;
      } else if(response.statusCode == 401) {
        response = await _dio.get('/articles/get/$id');
        if(response.statusCode == 200) {
          ArticleModel article = ArticleModel.fromJson(response.data);
          return article;
        }
        return null;
      } else {
        String errorMessage = getErrorMessage(response.data);
        debugPrint('Get article list error: \n$errorMessage');
      }
    } catch (e) {
      if(e is DioException) {
        String errorMessage = getErrorMessage(e.response?.data);
        debugPrint('Get article list error: $errorMessage');
      } else {
        debugPrint('Get article list error: ${e.toString()}');
      }
    }
    return null;
  }
}