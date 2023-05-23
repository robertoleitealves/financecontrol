// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as _developer;
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:izconsultores/src/constants/constants.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class ErrorRequest {
  int? statusCode;
  String? message;
  ErrorRequest({
    this.statusCode,
    this.message,
  });
}

class HttpManager {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
  ));

  Future restRequest({
    required String url,
    required String method,
    bool removeHeaders = false,
    Map? headers,
    dynamic body,
  }) async {
    // Headers da requisição
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
        {"Content-Type": "application/json"},
      );

    try {
      Response response = await _dio.request(
        url,
        options: Options(
          headers: removeHeaders ? null : defaultHeaders,
          method: method,
        ),
        data: body,
      );
      // Retorno do resultado do backend
      return response.data;
    } on DioError catch (error) {
      // Retorno do erro do dio request

      throw ErrorRequest(
          message: error.response?.data.toString(),
          statusCode: error.response?.statusCode);
    } catch (error) {
      // Retorno de map vazio para erro generalizado
      return {};
    }
  }

  Future uploadFile({
    required File file,
    required String path,
    required int userId,
    String endPoint = Endpoints.uploadPhoto,
  }) async {
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "photo": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    try {
      var response = await _dio.post(
        '$endPoint&path=$path&userId=$userId',
        data: data,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response.data;
    } on DioError catch (error) {
      // Retorno do erro do dio request
      _developer.log("Erro na requisição", name: 'http_manager', error: error);
      return error.response?.statusCode;
    } catch (error) {
      // Retorno de map vazio para erro generalizado
      _developer.log("Erro genérico na requisição",
          name: 'http_manager', error: error);
      return {};
    }
  }
}
