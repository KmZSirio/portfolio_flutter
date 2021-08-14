import 'dart:async';

import 'package:sirio_portfolio/main/spotify/models/authorization_model.dart';

import 'authorition_api_provider.dart';
import 'authorization_token_api_provider.dart';

class RepositoryAuthorization {
  final authorizationCodeApiProvider  = AuthorizationApiProvider();
  final authorizationTokenApiProvider = AuthorizationTokenApiProvider();
  Future<String> fetchAuthorizationCode() => authorizationCodeApiProvider.fetchAuthCode();
  Future<AuthorizationModel> fetchAuthorizationToken(String code) => authorizationTokenApiProvider.fetchToken(code);
}