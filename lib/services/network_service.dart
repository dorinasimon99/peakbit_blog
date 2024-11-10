import 'package:dio/dio.dart';
import 'package:peakbit_blog/services/token_service.dart';

class NetworkService {
  static final _dio = Dio();
  static NetworkService instance = NetworkService._();

  NetworkService._();

  void setupDio() {
    _dio.options.baseUrl = 'https://trial.peakbit.tech/api';
    TokenService.instance.setupToken();
    _dio.interceptors.addAll(
      [
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers = {
              'X-TOKEN': TokenService.instance.token.token,
              'accept': 'application/json',
            };
            return handler.next(options);
          },
          onResponse: (response, handler) {
            if(response.statusCode == 401) {
              TokenService.instance.renewToken();
            }
          }
        ),
        LogInterceptor(responseBody: true),
      ],
    );
  }

  Dio get dio => _dio;

}