import 'package:http/http.dart' show Client;
import '../models/authorization_model.dart';
import 'dart:convert';
import 'dart:async';
import '../../core/const.dart';

class AuthorizationTokenApiProvider {
  Client client = Client();

  static String _endpoint = "/api/token";
  static String _authorizationString = "$clientIdSpotify:$clientSecretSpotify";
  static var bytes = utf8.encode(_authorizationString);
  static var base64Str = base64.encode(bytes);

  String _authorizationBasic = "Basic " + base64Str;

  Future<AuthorizationModel> fetchToken( String code ) async {
    
    try {
      final response = await client.post( Uri.https(accountsUrlSpotify, _endpoint),
        body: {
          "grant_type": "authorization_code",
          "code": code,
          "redirect_uri": redirectUri
        },
        headers: { "Authorization": _authorizationBasic }
      );

      if ( response.statusCode == 200 ) {
        return AuthorizationModel.fromJson(json.decode(response.body));
      } else {
        return Future.error(response.statusCode);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}