import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/app/helper/ex_log.dart';
import 'package:e_commerce_app/app/helper/pref_helper.dart';
import 'package:get/get.dart';
import 'http_exception.dart';
import 'http_interceptor.dart';

part 'http_outcome.dart';

class HttpService extends GetConnect {
  HttpService({
    required this.baseURL,
    required this.baseHeader,
    required this.maxTimeOut,
    this.allowAutoSignedCertificate = true,
    this.useUserAgent = false,
    this.customUserAgent = '',
    this.allowFollowRedirects = false,
    this.maxRedirectURL = 3,
    this.maxAuthRetry = 3,
    this.showLogHeader = false,
    this.showLogResponse = false,
  });

  final String baseURL;
  final Map<String, String> baseHeader;
  final bool allowAutoSignedCertificate;
  final String customUserAgent;
  final bool useUserAgent;
  final bool allowFollowRedirects;
  final int maxRedirectURL;
  final int maxAuthRetry;
  final Duration maxTimeOut;
  final bool showLogHeader;
  final bool showLogResponse;

  @override
  Future<void> onInit() async {
    HttpOverrides.global = MyHttpOverrides(); // Fix Http Issue on Android SDK < 23

    try {
      allowAutoSignedCert = allowAutoSignedCertificate;
      httpClient
        ..baseUrl = baseURL
        ..errorSafety = true
        ..followRedirects = allowFollowRedirects
        ..timeout = maxTimeOut
        ..maxAuthRetries = maxAuthRetry
        ..maxRedirects = maxRedirectURL
        ..sendUserAgent = useUserAgent
        ..userAgent = customUserAgent
        ..addRequestModifier<void>((request) async {
          final token = PrefHelper.userToken;
          if (token != null && token.isNotEmpty) {
            request.headers['Authorization'] = 'Bearer $token';
          }
          request.headers['Accept'] = 'application/json';
          request.headers['mobile'] = 'true';
          request.headers.addAll(baseHeader);
          return request;
        })
        ..addResponseModifier((request, response) async => response);
        /*..addAuthenticator<void>((request) async {
          if (PrefHelper.userToken.isNotNullOrEmpty) {
            await httpGet(endPoint: 'v1/refresh-token').then((value) {
              final response = value.body as Map<String, dynamic>;
              final data = RefreshTokenEntity.fromJson(response);
              PrefHelper.setUserToken(data.message?.token ?? '');
              PrefHelper.setExpUserToken(data.message?.expiredAt ?? '');
              request.headers['Authorization'] = 'Bearer ${data.message?.token}';
            }).catchError((dynamic error) {
              PrefHelper.resetData();
              PrefHelper.setIsLogin(false);
              Get.offAllNamed<dynamic>(Routes.LOGIN);
            });
          } else {
            PrefHelper.resetData();
            PrefHelper.setIsLogin(false);
            await Get.offAllNamed<dynamic>(Routes.LOGIN);
          }
          return request;
        });*/
    } on Exception {
      throw ApiException('Please Inject APIService on your DI');
    }
    super.onInit();
  }

  /// Request http with manual scheme
  /// You must include your own method, full url, header
  /// Query and body are used based on the method you use
  Future<Outcome<dynamic>> http({required Method method, required String url, Map<String, String>? header, Map<String, String>? query, Map<String, dynamic>? body}) async {
    final result = Outcome<dynamic>();
    await onInit();
    httpClient.baseUrl = '';

    Response res;
    switch (method) {
      case Method.GET:
        res = await get(url, query: query, headers: header);
        break;
      case Method.POST:
        res = await post(url, body, headers: header);
        break;
      case Method.PUT:
        res = await put(url, body, headers: header);
        break;
      case Method.DELETE:
        res = await delete(url, headers: header);
        break;
    }

    await ApiUtils.apiLog(response: res, showHeader: showLogHeader, showResponse: showLogResponse);
    if (res.isOk) {
      result
        ..body = res.body
        ..isFailure = false;
      return result;
    } else {
      return ErrorInterceptorHandling(response: res, result: result, url: '${httpClient.baseUrl} | $url');
    }
  }

  /// Request http with GET method
  /// You just include the endpoint only without the base url.
  /// You also don't need to include an authorization token header if the endpoint requires authorization.
  /// It's already included in the HttpService injection
  Future<Outcome<dynamic>> httpGet({required String endPoint, Map<String, dynamic>? query, Map<String, String>? header}) async {
    await onInit();
    final result = Outcome<dynamic>();
    final res = await get<dynamic>(endPoint, query: query, headers: header);
    await ApiUtils.apiLog(response: res, showHeader: showLogHeader, query: query, showResponse: showLogResponse);

    if (res.isOk) {
      return result
        ..body = res.body
        ..isFailure = false;
    } else {
      return ErrorInterceptorHandling(response: res, result: result, url: '${httpClient.baseUrl}$endPoint');
    }
  }

  /// Request http with POST method
  /// You just include the endpoint only without the base url.
  /// You also don't need to include an authorization token header if the endpoint requires authorization.
  /// It's already included in the HttpService injection
  Future<Outcome<dynamic>> httpPost({String endPoint = '', dynamic body, Map<String, String>? header}) async {
    await onInit();
    final result = Outcome<dynamic>();

    final res = await httpClient.post<dynamic>(endPoint, body: body, headers: header);
    await ApiUtils.apiLog(response: res, showHeader: showLogHeader, body: body as Map<String, dynamic>, showResponse: showLogResponse);

    if (res.isOk) {
      return result
        ..body = res.body
        ..isFailure = false;
    } else {
      return ErrorInterceptorHandling(response: res, result: result, url: '${httpClient.baseUrl}$endPoint');
    }
  }

  /// Request http with PUT method
  /// You just include the endpoint only without the base url.
  /// You also don't need to include an authorization token header if the endpoint requires authorization.
  /// It's already included in the HttpService injection
  Future<Outcome<dynamic>> httpPut({String endPoint = '', dynamic body, Map<String, String>? header}) async {
    await onInit();
    final result = Outcome<dynamic>();

    final res = await httpClient.put<dynamic>(endPoint, body: body);
    await ApiUtils.apiLog(response: res, showHeader: showLogHeader, body: body as Map<String, String>, showResponse: showLogResponse);

    if (res.isOk) {
      return result
        ..body = res.body
        ..isFailure = false;
    } else {
      return ErrorInterceptorHandling(response: res, result: result, url: '${httpClient.baseUrl}$endPoint');
    }
  }

  /// Request http with DELETE method
  /// You just include the endpoint only without the base url.
  /// You also don't need to include an authorization token header if the endpoint requires authorization.
  /// It's already included in the HttpService injection
  Future<Outcome<dynamic>> httpDelete({String endPoint = '', Map<String, String>? header}) async {
    await onInit();
    final result = Outcome<dynamic>();

    final res = await httpClient.delete<dynamic>(endPoint);
    await ApiUtils.apiLog(response: res, showHeader: showLogHeader, showResponse: showLogResponse);

    if (res.isOk) {
      return result
        ..body = res.body
        ..isFailure = false;
    } else {
      return ErrorInterceptorHandling(response: res, result: result, url: '${httpClient.baseUrl}$endPoint');
    }
  }

  /// Request http to upload files
  /// You just include the endpoint only without the base url.
  /// You also don't need to include an authorization token header if the endpoint requires authorization.
  /// It's already included in the HttpService injection
  Future<Outcome<dynamic>> httpUploadMultipart({
    required String endPoint,
    required File file,
    Map<String, String>? header,
    String? fileName,
  }) async {
    await onInit();
    final result = Outcome<dynamic>();

    final form = FormData({
      'file': MultipartFile(file, filename: fileName ?? ''),
    });
    final res = await post<dynamic>(
      endPoint,
      form,
      headers: header,
      contentType: 'multipart/form-data',
      uploadProgress: (progress) {},
    );
    await ApiUtils.apiLog(response: res, showHeader: showLogHeader, showResponse: showLogResponse);

    if (res.isOk) {
      result.body = res.body;
      result.isFailure = false;
      return result;
    } else {
      return ErrorInterceptorHandling(response: res, result: result, url: '${httpClient.baseUrl} | $endPoint');
    }
  }

  @override
  void onReady() {
    logW('Api Service Ready!');
    super.onReady();
  }

  @override
  void onClose() {
    logW('Api Service Closed!');
    super.onClose();
  }
}

enum Method { GET, POST, PUT, DELETE }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

/// Helper class
mixin ApiUtils {
  static Future<void> apiLog({
    required Response<dynamic> response,
    bool? showHeader,
    bool? showResponse,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
  }) async {
    // output += '—————————————————————————————————————————————————————————————————————————————\n';
    log('${response.request?.method ?? '-'} | ${response.request?.url ?? '-'} | ${response.statusCode ?? '-'}');

    if (showHeader ?? true) log('header : ${jsonEncode(response.request?.headers)}');

    try {
      if (query != null) log('query : ${jsonEncode(query)}');
    } catch (e) {
      if (query != null) log('query : $query');
    }

    try {
      if (body != null) log('body : ${jsonEncode(body)}');
    } catch (e) {
      if (body != null) log('body : $body');
    }

    try {
      if (showResponse ?? true && response.isOk) {
        logI('${response.bodyString}');
      }
    } on Exception catch (e) {
      log(e);
    }
  }
}
