import 'package:bright_hr_posts/common/values/constants.dart';
import 'package:dio/dio.dart';

class HttpUtils {
  static final HttpUtils _instance = HttpUtils._internal();
  factory HttpUtils() {
    return _instance;
  }
  late Dio dio;
  HttpUtils._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {},
      contentType: "application/json:charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);
  }
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic response;

    try {
      response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } catch (e) {
      print("here is try exception: ${e.toString()}");
    }
    return response.data;
  }

  Future get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic response;
    try {
      response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      print("here is response $response");
    } catch (e) {
      print("here is try exception: ${e.toString()}");
    }
    return response;
  }
}
