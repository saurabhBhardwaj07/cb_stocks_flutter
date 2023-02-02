import 'package:cb_stocks/data/local_repository.dart';
import 'package:dio/dio.dart';

class Repository extends LocalRepository {
  Future<Response> fetchLatestImage() {
    return dio.get('image');
  }

  Future<Response> fetchColors() {
    return dio.get('color');
  }

  Future<Response> fetchCategory() {
    return dio.get('category');
  }
}

Dio _instance() {
  var dio = Dio();
  dio.options.responseType = ResponseType.json;
  // dio.options.baseUrl = "https://cfe3d0869a.nxcli.net/wp-json/";
  //MARK: - staging
  dio.options.baseUrl = "https://cb.techrapid.in/";
  //MARK: - Production
  // dio.options.baseUrl = Constants.apiBaseUrl;
  // dio.options.baseUrl = "https://staging.yatilabs.com/shotpro/wp-json/";

  // dio.interceptors.add(RetryOnConnectionChangeInterceptor(dio: dio));

  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions options, RequestInterceptorHandler handler) async {
    // print(options.path);

    return handler.next(options);
  }, onError: (DioError e, handler) async {
    return handler.next(e);
    // Do something with response error
    // return handler.next(e); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: `handler.resolve(response)`.
  }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }));

  dio.interceptors.add(LogInterceptor(
      requestBody: true, responseBody: true, requestHeader: true));

  return dio;
}

final dio = _instance();
final repository = Repository();
