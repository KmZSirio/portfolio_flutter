import 'package:flutter/material.dart';
import 'package:sirio_portfolio/main/core/theme.dart';


class SpotifyLibraryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.spotifyBlack,
      body: Center(
        child: Text('Your Library'),
     ),
   );
  }
}