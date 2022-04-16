import 'package:bugreportingsystem/core/interceptors/api_response_interceptor.dart';
import 'package:bugreportingsystem/core/model/api/mobile_version_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_anonymous_client.g.dart';

@RestApi()
abstract class ApiAnonymousClient {
  factory ApiAnonymousClient({ required String baseUrl}) {
    var dio = Dio();
    dio..interceptors.add(ApiResponseInterceptor());
    return _ApiAnonymousClient(dio, baseUrl: baseUrl);
  }

  @GET('/api/MobileVersion')
  Future<MobileVersionModel> getAppVersion();
}

