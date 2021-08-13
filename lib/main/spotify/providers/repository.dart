import 'dart:async';

import 'authorition_api_provider.dart';

class RepositoryAuthorization {
  final authorizationCodeApiProvider = AuthorizationApiProvider();
  Future<String> fetchAuthorizationCode() => authorizationCodeApiProvider.fetchAuthCode();
}