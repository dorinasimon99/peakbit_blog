import 'dart:convert';

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
        ArticleModel article = ArticleModel.fromJson(jsonDecode(response.data) as Map<String, dynamic>);
        return article;
      } else {
        String errorMessage = getErrorMessage(response.data);
        debugPrint('Get article list error: \n$errorMessage');
      }
    } catch (e) {
      debugPrint('Get article list error: ${e.toString()}');
    }
    return null;
  }
}