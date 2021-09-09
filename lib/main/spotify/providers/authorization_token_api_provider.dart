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

  //* Kotlin App Test
  // static String _authKotlinString = ":";
  // static var bytesKotlin = utf8.encode(_authKotlinString);
  // static var base64StrKotlin = base64.encode(bytesKotlin);

  // String _authorizationBasicKotlin = "Basic " + base64StrKotlin;
  //

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
      //* Kotlin App Test
      // print("______________");
      // print("$_authorizationBasicKotlin");
      // print("______________");
      // print("______________");
      // print("$_authorizationBasic");
      // print("______________");
      // print("REQUEST: ${response.request}");

      if ( response.statusCode == 200 ) 
        return AuthorizationModel.fromJson(json.decode(response.body));
      else 
        return Future.error(response.statusCode);
      
    } catch (e) {
      return Future.error(e);
    }
  }
}