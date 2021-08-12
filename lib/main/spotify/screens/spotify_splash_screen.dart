import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirio_portfolio/main/core/theme.dart';

class SpotifySplashScreen extends StatefulWidget {
  @override
  _SpotifySplashScreenState createState() => _SpotifySplashScreenState();
}

class _SpotifySplashScreenState extends State<SpotifySplashScreen> {


  @override
  void initState() { 
    super.initState();
    sharedPreferences();
  }

  void sharedPreferences() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? spotifyLogged = prefs.getBool("spotify_logged");
    print("Spotify Logged: $spotifyLogged");

    if ( spotifyLogged == true )
      Timer( Duration( milliseconds: 1500 ), () => Navigator.pushReplacementNamed(context, "/spotify_home") );
    else 
      Timer( Duration( milliseconds: 1500 ), () => Navigator.pushReplacementNamed(context, "/spotify_login") );
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: AppColors.spotifyBlack,
        child: Image(
          height: size.height / 5,
          image: ExactAssetImage( "assets/spotify/icon_green.png" ),
        ),
      ),
    );
  }
}