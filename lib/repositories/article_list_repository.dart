import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../common/error_message_handler.dart';
import '../models/article_list/article_list_model.dart';
import '../services/network_service.dart';

class ArticleListRepository {
  final _dio = NetworkService.instance.dio;

  Future<ArticleListModel?> getArticles({int page = 1, int pageSize = 4}) async {
    try {
      Response response = await _dio.get('/articles/list?page=$page&pageSize=$pageSize');
      if(response.statusCode == 200) {
        ArticleListModel articles = ArticleListModel.fromJson(response.data);
        return articles;
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