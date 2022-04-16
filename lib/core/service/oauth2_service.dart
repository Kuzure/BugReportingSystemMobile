import 'package:bugreportingsystem/core/client/identity_client.dart';
import 'package:bugreportingsystem/core/model/identity/user.dart';
import 'package:bugreportingsystem/core/model/identity/user_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth_dio/oauth_dio.dart';

import '../../app_settings.dart';

class OAuth2Service {
  final _IdentityOAuth _oAuth;

  OAuth2Service({
    required AuthSettings config
  }) : _oAuth = _IdentityOAuth(
            baseUrl: config.baseUrl,
            tokenEndpoint: config.tokenEndpoint,
            clientId: config.clientId,
            storage: _OAuthSecureStorage()
        );


  Dio get httpClient => Dio()..interceptors.add(BearerInterceptor(_oAuth));

  Future<bool> get isAuthenticated async => await _oAuth.fetchOrRefreshAccessToken() != null;

  Future<String> get accessToken async => ((await _oAuth.fetchOrRefreshAccessToken())!.accessToken)!;

  Future authenticate(String firstName,String lastName,String phoneNumber, String password, bool rememberMe) {
    if (!rememberMe) {
      _oAuth.storage = OAuthMemoryStorage();
    }
    return _oAuth.requestTokenAndSave(
        _IdentityPasswordGrant(
            clientId: _oAuth.clientId,
            password: password,
            lastName: lastName,
            firstName: firstName,
            phoneNumber: phoneNumber
        )
    );
  }

  Future<User>? getUser() {
    try {
      IdentityClient identityClient = IdentityClient(
          httpClient, baseUrl: _oAuth.baseUrl);

      return identityClient.getUser();
    }
    catch(e){
      print(e.toString());
    }
  }
  Future<UserInfo> getUserFull(String id) {
    IdentityClient identityClient = IdentityClient(httpClient, baseUrl: _oAuth.baseUrl);
    return identityClient.getUserFull(id);
  }

  Future clear() {
    return _oAuth.storage.clear();
  }
}

class _IdentityOAuth extends OAuth {
  final String baseUrl;
  _IdentityOAuth({
    required this.baseUrl,
    required String tokenEndpoint,
    required String clientId,
    required OAuthStorage storage
  }) : super(
      tokenUrl: baseUrl + tokenEndpoint,
      clientId: clientId,
      storage: storage,
      extractor: _IdentityOAuthTokenExtractor().extract,
      validator: _IdentityAuthTokenValidator().validate,
      clientSecret:'',
  );

  @override
  Future<OAuthToken> refreshAccessToken() async {
    OAuthToken token = (await storage.fetch())!;

    return this.requestToken(_IdentityRefreshTokenGrant(
        clientId: clientId,
        refreshToken: token.refreshToken!
    ));
  }
}

class _IdentityOAuthToken extends OAuthToken {
  final DateTime expirationDate;

  _IdentityOAuthToken({
    required String accessToken,
    required String refreshToken,
    required this.expirationDate
  }) : super(
      accessToken: accessToken,
      refreshToken: refreshToken
  );

  @override
  String toString() => accessToken!;
}

class _IdentityOAuthTokenExtractor {
  _IdentityOAuthToken extract(Response response) =>
      _IdentityOAuthToken(
          accessToken: response.data['access_token'],
          refreshToken: response.data['refresh_token'],
          expirationDate: DateTime.now().add(Duration(seconds: response.data['expires_in']))
      );
}

class _IdentityAuthTokenValidator {
  Future<bool> validate(OAuthToken token) {
    final identityToken = token as _IdentityOAuthToken;
    return Future.value(identityToken.expirationDate.isAfter(DateTime.now()));
  }
}

class _IdentityPasswordGrant extends OAuthGrantType {
  String clientId;
  String firstName;
  String lastName;
  String phoneNumber;
  String password;
  _IdentityPasswordGrant({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
  });

  @override
  RequestOptions handle (RequestOptions request) {
    return RequestOptions(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: {
          'client_id' : clientId,
          'grant_type' : 'password',
          'firstName' : firstName,
          'lastName':lastName,
          'username':phoneNumber,
          'password' : password
        }, path: ''
    );
  }
}

class _IdentityRefreshTokenGrant extends OAuthGrantType {
  String clientId;
  String refreshToken;

  _IdentityRefreshTokenGrant({
    required this.clientId,
    required this.refreshToken
  });

  @override
  RequestOptions handle(RequestOptions request) {
    return RequestOptions(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: {
          'client_id' : clientId,
          'grant_type' : 'refresh_token',
          'refresh_token' : refreshToken
        },
        path: ''
    );
  }
}

class _OAuthSecureStorage extends OAuthStorage {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String _accessTokenKey = 'accessToken';
  final String _refreshTokenKey = 'refreshToken';
  final String _expirationDateKey = 'expirationDate';

  @override
  Future<_IdentityOAuthToken> fetch() async {
    final bool containsAccessToken = await storage.containsKey(key: _accessTokenKey);
    final bool containsRefreshToken = await storage.containsKey(key: _refreshTokenKey);
    final bool containsExpirationDate = await storage.containsKey(key: _expirationDateKey);

    if (containsAccessToken && containsRefreshToken && containsExpirationDate) {
      return _IdentityOAuthToken(
          accessToken: (await storage.read(key: _accessTokenKey))!,
          refreshToken: (await storage.read(key: _refreshTokenKey))!,
          expirationDate: DateTime.parse((await storage.read(key: _expirationDateKey))!)
      );
    }
    return _IdentityOAuthToken(accessToken: '_accessTokenKey', refreshToken: '_refreshTokenKey', expirationDate: DateTime.parse('_expirationDateKey'));

  }

  @override
  Future<_IdentityOAuthToken> save(OAuthToken token) async {
    final identityToken = token as _IdentityOAuthToken;
    await storage.write(key: _accessTokenKey, value: identityToken.accessToken);
    await storage.write(key: _refreshTokenKey, value: identityToken.refreshToken);
    await storage.write(key: _expirationDateKey, value: identityToken.expirationDate.toString());
    return token;
  }

  @override
  Future<void> clear() async {
    await storage.delete(key: _accessTokenKey);
    await storage.delete(key: _refreshTokenKey);
    await storage.delete(key: _expirationDateKey);
  }
}