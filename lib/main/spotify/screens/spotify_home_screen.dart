import 'package:flutter/material.dart';

class SpotifyHomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Spotify API Home"),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
        ) 
      ),
    );
  }
}