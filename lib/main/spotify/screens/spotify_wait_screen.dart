import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sirio_portfolio/main/core/theme.dart';
import 'package:sirio_portfolio/main/spotify/blocs/authorization_bloc.dart';

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
          () => Navigator.pushNamedAndRemoveUntil(context, "/spotify_home", (route) => false) );
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
        builder: (context, AsyncSnapshot<String> snapshot) {
          
          if (snapshot.hasData) {
            if (snapshot.data == "access_denied") {
              Navigator.pop(contextBuild);
            } else {
              print(snapshot.data);
              _welcome();
            }
          } else if (snapshot.hasError) {
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
}