import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' show Client;

import '../../core/const.dart';

class AuthorizationApiProvider {
  Client client = Client();

  static String _endpoint = "/authorize";
  static String responseType = "code";
  static String scope = "playlist-read-private playlist-read-collaborative";

  String url = 
      "https://$accountsUrlSpotify$_endpoint" +
      "?client_id=$clientIdSpotify" +
      "&response_type=$responseType" +
      "&redirect_uri=$redirectUri" +
      "&scope=$scope" +
      "&state=$stateSpotify";

  Future<String> fetchAuthCode() async {
    
    try {
      final response = await FlutterWebAuth.authenticate(
        url: url, 
        callbackUrlScheme: callbackScheme
      );

      final error = Uri.parse(response).queryParameters["error"];
      
      if ( error == null ){
        final code = Uri.parse(response).queryParameters["code"];
        return code!;
      } else {
        print("Error al autenticar");
        print(error);
        return error;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}