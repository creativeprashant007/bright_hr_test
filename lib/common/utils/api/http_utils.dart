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
      contentType:
          "application/json; charset=utf-8", // Corrected the contentType
      responseType: ResponseType.json,
    );
    dio = Dio(options);

    // Add logging interceptor to monitor requests and responses
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.uri}');
          print('Headers: ${options.headers}');
          if (options.data != null) {
            print('Request body: ${options.data}');
          }
          return handler.next(options); // continue with the request
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // continue with the response
        },
        onError: (DioError e, handler) {
          if (e.response != null) {
            print(
              'Error Response: ${e.response?.statusCode} ${e.response?.data}',
            );
          } else {
            print('Error: ${e.message}');
          }
          return handler.next(e); // continue with the error
        },
      ),
    );
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

      // Check if the response is successful
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Error: Received status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        // Handle DioError specifically
        print("Dio Error: ${e.response?.statusCode} ${e.response?.data}");
      } else {
        print("General Error: ${e.toString()}");
      }
      return null;
    }
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
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type':
                'application/json; charset=utf-8', // Corrected content type
          },
        ),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        return response;
      } else {
        print('Error: Received status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        // Handle DioError specifically
        print("Dio Error: ${e.response?.statusCode} ${e.response?.data}");
      } else {
        print("General Error: ${e.toString()}");
      }
      return null;
    }
  }
}
