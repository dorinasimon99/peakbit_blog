import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peakbit_blog/services/network_service.dart';

import '../common/error_message_handler.dart';
import '../common/platform_helper.dart';
import '../models/auth/token_model.dart';

class TokenService {
  static TokenService instance = TokenService._();
  final Dio _dio = NetworkService.instance.dio;
  late TokenModel token;

  TokenService._();

  Future<void> setupToken() async {
    try {
      Response response = await _dio.get('/token/generate/${PlatformHelper.instance.currentPlatform.name}');
      if(response.statusCode == 200) {
        token = TokenModel.fromJson((jsonDecode(response.data) as Map<String, dynamic>));
      } else {
        String errorMessage = getErrorMessage(response.data);
        debugPrint("Generate token error: \n$errorMessage");
      }
    } catch (e) {
      debugPrint("Generate token error: ${e.toString()}");
    }
  }

  Future<void> renewToken() async {
    try {
      Response response = await _dio.get('/token/renew');
      if(response.statusCode != 200) {
        String errorMessage = getErrorMessage(response.data);
        debugPrint("Renew token error: \n$errorMessage");
      }
    } catch (e) {
      debugPrint("Renew token error: ${e.toString()}");
    }
  }

}