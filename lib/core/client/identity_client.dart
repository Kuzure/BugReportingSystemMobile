
import 'package:bugreportingsystem/core/model/identity/user.dart';
import 'package:bugreportingsystem/core/model/identity/user_info.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'identity_client.g.dart';

@RestApi()
abstract class IdentityClient {
  factory IdentityClient(Dio dio, {String baseUrl}) = _IdentityClient;

  @GET("/connect/userinfo")
  Future<User> getUser();

  @GET("/GetUser")
  Future<UserInfo> getUserFull(@Query("userId")String userId);
}