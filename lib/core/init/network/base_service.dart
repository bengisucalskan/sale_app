import 'package:dio/dio.dart';
import 'package:sale_app/core/consts/app_consts.dart';
import 'package:sale_app/core/extension/string_extension.dart';

class BaseService {
  final Dio _dio;

  BaseService() : _dio = Dio(BaseOptions(baseUrl: AppConsts.BASE_URL.toEnv));

  Future<Response> get(String endpoint) async {
    try {
      final response = _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      return Response(requestOptions: e.requestOptions, statusCode: 500);
    }
  }
}
