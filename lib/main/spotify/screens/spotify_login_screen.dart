import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirio_portfolio/main/core/theme.dart';

class SpotifyLoginScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    final TextStyle _text = TextStyle( color: Colors.white, fontSize: 39, fontWeight: FontWeight.w900 );
    final TextStyle _greenButton = TextStyle( color: AppColors.spotifyBlack, fontSize: 17, fontWeight: FontWeight.w900 );
    final TextStyle _blackButton = TextStyle( color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900 );

    final BoxDecoration _buttonsDeco = BoxDecoration(
      color: AppColors.trans,
      borderRadius: BorderRadius.all( Radius.circular(50) ),
      border: Border.all(
        color: Colors.white.withOpacity(0.5)
      )
    );

    return Scaffold(
      backgroundColor: AppColors.spotifyBlack,
      body: Container(
        child: Stack(
          children: [
            
            _backgroundImage(size),
            _gradient(size),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: size.height * 0.7,
                padding: const EdgeInsets.symmetric( horizontal: 35, vertical: 15 ),
                child: _column(size, _text, _greenButton, _buttonsDeco, _blackButton),
              ),
            )

          ]
        ),
      ) 
    );
  }

  Column _column(Size size, TextStyle _text, TextStyle _greenButton, BoxDecoration _buttonsDeco, TextStyle _blackButton) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Image(
          width: size.width * 0.12,
          image: AssetImage("assets/spotify/icon_white.png")
        ),

        Text( "Millions of songs.", style: _text ),
        Text( "Free on Spotify.", style: _text ),

        SizedBox( height: 40 ),

        GestureDetector(
          child: Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.spotifyGreen,
              borderRadius: BorderRadius.all( Radius.circular(50) )
            ),
            child: Text( "Sign up free", style: _greenButton )
          ),
          onTap: () {},
        ),

        _transButtons(
          deco: _buttonsDeco, style: _blackButton, 
          icon: FontAwesomeIcons.mobileAlt, text: "Continue with phone number", onTap: () {}
        ),
        _transButtons(
          deco: _buttonsDeco, style: _blackButton, 
          icon: FontAwesomeIcons.google, text: "Continue with Google", onTap: () {}
        ),
        _transButtons(
          deco: _buttonsDeco, style: _blackButton, 
          icon: FontAwesomeIcons.facebook, text: "Continue with Facebook", onTap: () {}
        ),

        GestureDetector(
          child: Container(
            width: 80,
            height: 50,
            alignment: Alignment.center,
            child: Text( "Log in", style: _blackButton )
          ),
          onTap: () {},
        ),

      ]
    );
  }

  GestureDetector _transButtons({
      required BoxDecoration deco, required TextStyle style, required IconData icon, 
      required String text, required Function() onTap }) {

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 18 ),
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: deco,
        child: Stack(
          children: [
            Align(
              child: Icon( icon, size: 20 ), 
              alignment: Alignment.centerLeft,
            ),
            Align(
              child: Text( text, style: style ), 
              alignment: Alignment.center,
            )
          ]
        )
      ),
      onTap: onTap,
    );
  }

  Container _gradient(Size size) {
    return Container(
      margin: EdgeInsets.only( top: size.height * 0.40 ),
      height: size.height * 0.15,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.spotifyBlack,
          ],
          stops: [
            0.0,
            1.0
          ])
      ),
          );
  }

  Container _backgroundImage(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/spotify/login_background.jpg"),
            fit: BoxFit.fitHeight,
        )
      ),
      child: Container(
        decoration: BoxDecoration( color: AppColors.spotifyBlack.withOpacity( 0.1 ) ),
      )
    );
  }
}