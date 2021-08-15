import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/const.dart';
import '../models/authorization_model.dart';
import '../models/playlist_list_response.dart';

class PlaylistListApiProvider {
  Client client = Client();

  Future<PlaylistListResponse> fetchPlaylistList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("spotify_access_token")!;
      String tokenType = prefs.getString("spotify_token_type")!;

      String authorizationWithToken = "$tokenType $accessToken";

      final response = await client
        .get( Uri.https( apiUrlSpotify, "/v1/me/playlists" ),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "Authorization": authorizationWithToken,
            });

      if (response.statusCode == 401) {
        String refreshToken = prefs.getString("spotify_refresh_token")!;
        String _authorizationString = "$clientIdSpotify:$clientSecretSpotify";
        var bytes = utf8.encode(_authorizationString);
        var base64Str = base64.encode(bytes);

        String _authorizationBasic = "Basic " + base64Str;

        final postUri = Uri.https( accountsUrlSpotify, "/api/token" );

        final newTokenResponse = await client.post( postUri, 
          body: {
            "grant_type": "authorization_code",
            "refresh_token": refreshToken,
            "redirect_uri": redirectUri
          },
          headers: { "Authorization": _authorizationBasic }
        );

        if (newTokenResponse.statusCode == 200) {
          AuthorizationModel authModel = AuthorizationModel.fromJson(
            json.decode( newTokenResponse.body )
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("spotify_access_token", authModel.accessToken);
          prefs.setString("spotify_token_type", authModel.tokenType);
          prefs.setBool("spotify_logged", true);

          String authorizationWithToken = "${authModel.tokenType} ${authModel.accessToken}";

          final response = await client
            .get( Uri.https( apiUrlSpotify, "/v1/me/playlists" ),
              headers: {"Authorization": authorizationWithToken} );
                    
          return PlaylistListResponse.fromJson(json.decode(response.body));
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("spotify_logged", false);
          return Future.error(response.statusCode);
        }
      } else if (response.statusCode == 200) 
        return PlaylistListResponse.fromJson(json.decode(response.body));
      else 
        return Future.error(response.statusCode);
      
      
    } catch (e) {
      return Future.error(e);
    }
  }

}