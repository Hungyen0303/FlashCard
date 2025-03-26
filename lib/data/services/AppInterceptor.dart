import 'dart:math';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../ui/auth/AppManager.dart';
import '../URL.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor(this.dio);

  final Dio dio;
  bool isRefreshing = false;
  List<RequestOptions> pendingRequests = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.connectTimeout = Duration(seconds: 10);
    options.receiveTimeout = Duration(seconds: 10);

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    Logger logger = Logger("ON REFRESHING");
    logger.info("refreshing ...");
    if (err.response?.statusCode == 401) {
      RequestOptions options = err.requestOptions;

      if (isRefreshing) {
        pendingRequests.add(options);
        return;
      }

      isRefreshing = true;
      try {
        // Gọi API refresh token
        final refreshResponse = await Dio().post(
          URL.verify,
          data: {
            "token": AppManager.getRefreshToken(),
            "refreshToken": AppManager.getRefreshToken()
          },
        );
        if (refreshResponse.data["status"] == "SUCCESS") {
          String newAccessToken = refreshResponse.data["data"]["newToken"];
          AppManager.saveToken(newAccessToken, AppManager.getRefreshToken());

          // Thử lại request gốc với token mới
          options.headers["Authorization"] = "Bearer $newAccessToken";
          final retryResponse = await dio.fetch(options);
          handler.resolve(retryResponse);

          // Xử lý các request đang đợi
          for (var pending in pendingRequests) {
            pending.headers["Authorization"] = "Bearer $newAccessToken";
            final retry = await dio.fetch(pending);
            handler.resolve(retry);
          }
          pendingRequests.clear();
        } else {
          throw Exception("Please login again");
        }
      } catch (e) {
        handler.reject(err); // Refresh thất bại, trả lỗi về
        AppManager.clearToken(); // Có thể logout user
        pendingRequests.clear();
      } finally {
        isRefreshing = false;
      }
    } else {
      handler.next(err); // Lỗi khác, không xử lý
    }
  }
}
