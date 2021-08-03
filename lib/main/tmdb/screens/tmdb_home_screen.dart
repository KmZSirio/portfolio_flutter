import 'package:flutter/material.dart';
import 'package:portfolio_flutter/main/tmdb/providers/movies_provider.dart';
import 'package:portfolio_flutter/main/tmdb/search/search_delegate.dart';
import 'package:portfolio_flutter/main/tmdb/widgets/tmdb_widgets.dart';
import 'package:provider/provider.dart';


class TmdbHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas en cines"),
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
              onNextPage: () => moviesProvider.getPopular()
            ),
    
          ]
        )
      ),
     );
  }
}