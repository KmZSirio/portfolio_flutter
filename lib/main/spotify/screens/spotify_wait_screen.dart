import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirio_portfolio/main/core/theme.dart';
import 'package:sirio_portfolio/main/spotify/blocs/authorization_bloc.dart';
import 'package:sirio_portfolio/main/spotify/models/authorization_model.dart';

class SpotifyWaitScreen extends StatefulWidget {
  @override
  _SpotifyWaitScreenState createState() => _SpotifyWaitScreenState();
}

class _SpotifyWaitScreenState extends State<SpotifyWaitScreen> {

  Timer? _redirectTimer;

  @override
  void dispose() {
    super.dispose();
    if ( _redirectTimer != null )
      _redirectTimer!.cancel();
  }

  @override
  Widget build(BuildContext contextBuild) {
    authorizationBloc.fetchAuthorizationCode();

    _welcome() {

      // authorizationBloc.disposeToken();
      Timer( Duration( microseconds: 1 ),
          () => Navigator.pushNamedAndRemoveUntil(context, "/spotify_home", ModalRoute.withName('/home')) );
      return Center( child: CircularProgressIndicator( color: AppColors.spotifyGreen ) );
    }

    _backToLogin(){
      _redirectTimer = Timer( Duration( seconds: 4 ),
          () => Navigator.pop(contextBuild, "/spotify_login") );
    }

    return Scaffold(
      backgroundColor: AppColors.spotifyBlack,
      body: StreamBuilder(
        stream: authorizationBloc.authorizationCode,
        builder: (context, AsyncSnapshot<String> snapshotCode) {
          
          if (snapshotCode.hasData) {
            if (snapshotCode.data == "access_denied") {
              Navigator.pop(contextBuild);
            } else {
              print(snapshotCode.data);
              authorizationBloc.fetchAuthorizationToken(snapshotCode.data!);

              return StreamBuilder(
                stream: authorizationBloc.authorizationToken,
                builder: (context, AsyncSnapshot<AuthorizationModel> snapshotToken) {

                  if (snapshotToken.hasData) {

                    print("FINAL DATA");
                    print('access_token: ${snapshotToken.data!.accessToken}');
                    print("token_type: ${snapshotToken.data!.tokenType}");
                    print("expires_in: ${snapshotToken.data!.expiresIn}");
                    print("refresh_token: ${snapshotToken.data!.refreshToken}");
                    print("scope: ${snapshotToken.data!.scope}");
                    addTokenToSP(snapshotToken);

                    return _welcome();
                  } else if (snapshotToken.hasError) {
                    _backToLogin();
                    return Container( 
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric( horizontal: 20 ),
                      child: Text( "There has been an error, you will be redirected to log in page.", style: TextStyle(color: Colors.white, fontSize: 20) )
                    );
                  }

                  return Center( child: CircularProgressIndicator( color: AppColors.spotifyGreen ) );
                },
              );
            }
          } else if (snapshotCode.hasError) {
            _backToLogin();
            return Container( 
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Text( "There has been an error, you will be redirected to log in page.", style: TextStyle(color: Colors.white, fontSize: 20) )
            );
          }
          
          return Center( child: CircularProgressIndicator( color: AppColors.spotifyGreen ) );
        },
      ),
    );
  }

  addTokenToSP( AsyncSnapshot<AuthorizationModel> snapshot ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("spotify_access_token", snapshot.data!.accessToken);
    prefs.setString("spotify_token_type", snapshot.data!.tokenType);
    prefs.setString("spotify_refresh_token", snapshot.data!.refreshToken);
    prefs.setBool("spotify_logged", true);
  }
}