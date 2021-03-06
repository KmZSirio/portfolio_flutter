import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirio_portfolio/main/tmdb/providers/movies_provider.dart';
import 'package:sirio_portfolio/main/tmdb/search/search_delegate.dart';
import 'package:sirio_portfolio/main/tmdb/widgets/tmdb_widgets.dart';
import 'package:provider/provider.dart';


class TmdbHomeScreen extends StatelessWidget {
  
  final Random random = new Random();

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text( 
          "Peliculas en cartelera", 
          style: GoogleFonts.raleway( fontWeight: FontWeight.w500 )
        ),
        elevation: 0,
        actions: [
    
          IconButton(
            icon: Icon( Icons.search_outlined ),
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => showSearch( context: context, delegate: MovieSearchDelegate() )
          )
    
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            
            CardSwiper( movies: moviesProvider.onDisplayMovies ),
            SizedBox( height: 30 ),
            MovieSlider( 
              movies: moviesProvider.popularMovies, 
              title: "Populares", 
              randomNumber: random.nextInt(10000),
              onNextPage: () => moviesProvider.getPopular()
            ),
    
          ]
        )
      ),
     );
  }
}