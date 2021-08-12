import 'package:flutter/material.dart';
// import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyHomeScreen extends StatelessWidget {
  
  final String clientId = "ea005bd20dba4d47b8bd8bfaade4e630";
  final String redirectUri = "your://com.bustasirio.sirio_portfolio/callback";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Spotify API Tests"),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: TextButton(
            child: Text("connectToSpotifyRemote"),
            onPressed: () async {
              // var result = await SpotifySdk.connectToSpotifyRemote( clientId: clientId, redirectUrl: redirectUri );
              // print( result );
            },
          ),
        ) 
      ),
    );
  }
}