import 'dart:async';
import 'package:bugreportingsystem/core/exceptions/authentication_exceptions.dart';
import 'package:bugreportingsystem/core/model/identity/user.dart';
import 'package:bugreportingsystem/core/service/oauth2_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_configuration.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final StreamController<AuthenticationStatus> _controller = StreamController<AuthenticationStatus>();
  final OAuth2Service _oauth2Service;
  User? _user;
  late String _user_node;
  AuthenticationRepository({
    required OAuth2Service? oauth2Service
  }) : assert(oauth2Service != null),
        _oauth2Service = oauth2Service!;


  Stream<AuthenticationStatus> get status async* {
    try {
      yield await _oauth2Service.isAuthenticated ? AuthenticationStatus.authenticated : AuthenticationStatus.unauthenticated;
    } on Exception catch(_) {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }
  Future<User?> get user async {
    if (_user == null) {
      _user = (await _getUser(isSilent: true));
    }
    return _user;
  }
  setUserFirstName(String firstName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('firstName', firstName);
  }
  setUserLastName(String lastName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('lastName', lastName);
  }
  setUserPhoneNumber(String phoneNumber) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('phoneNumber', phoneNumber);
  }
  setRealUserPhoneNumber(String phoneNumber) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('phoneNumberReal', phoneNumber);
  }
  Future<String> getUserFirstName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String firstName=preferences.getString('firstName') ?? '';
    return firstName;
  }
  Future<String> getUserLastName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String lastName=preferences.getString('lastName') ?? '';
    return lastName;
  }
  Future<String> getUserPhoneNumber() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String phoneNumber=preferences.getString('phoneNumber') ?? '';
    return phoneNumber;
  }
  Future<String> getRealUserPhoneNumber() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String phoneNumber=preferences.getString('phoneNumberReal') ?? '';
    return phoneNumber;
  }

  Future<String> get userInfo async {
    if (_user != null) {
      _user_node = (await _getUserFull(_user!.sub))!;
    }
    return _user_node;
  }

  Dio get securedHttpClient => _oauth2Service.httpClient;

  Future<String?> get accessToken => _oauth2Service.accessToken;

  Future<void> logIn({
   required String firstName,
    required String lastName,
    required String phoneNumber,
   required String password,
   required bool rememberMe
  }) async {
    setUserLastName(lastName);
    setUserPhoneNumber(phoneNumber);
    setUserFirstName(firstName);
      await _oauth2Service.authenticate(firstName,lastName,phoneNumber, password, rememberMe);
    _user = (await _getUser(isSilent: false));
    _controller.add(AuthenticationStatus.authenticated);

  }

  Future<void> logOut() async {
    await _oauth2Service.clear();
    _user = null;
    _controller.add(AuthenticationStatus.unauthenticated);
  }
  void dispose() => _controller.close();

  Future<User?> _getUser({bool isSilent = false}) async {
    try {
      User? user = await _oauth2Service.getUser();
      print(user!.toJson().toString());
      //todo change
      //User user = new User('8add8a48-7fad-4462-b3a2-29a23085095a', ['null'], 'Admin', 'null', 'zotyto@mailinator.com');

      if (!AppConfiguration().configuration.allowedRoles.contains(user.role)) {
        await _oauth2Service.clear();

        throw InvalidRoleException();
      }

      return user;
    }
    catch (ex) {
      if (!isSilent) {
        throw ex;
      }

      return null;
    }
  }
  Future<String?> _getUserFull(String id) async {
    try {
      var user = await _oauth2Service.getUserFull(id);
      return user.nodeId;
    }
    catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}