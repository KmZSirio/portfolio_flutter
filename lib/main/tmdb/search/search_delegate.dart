import 'package:flutter/material.dart';
import 'package:sirio_portfolio/main/tmdb/models/movie.dart';
import 'package:sirio_portfolio/main/tmdb/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  // TODO Empty search suggestions show nothing!
  // TODO Save getSuggestions widget to show it later on buildResults!

  @override
  String get searchFieldLabel => "Search movie";

  @override
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
  );

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        onPressed: () => query = "", 
        icon: Icon( Icons.clear ),
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      onPressed: () {
        close( context, null );
      }, 
      icon: Icon( Icons.arrow_back ),
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return Text( "buildResults" );
  }

  Widget _emptyContainer( BuildContext context ){
    return Container(
      child: Center(
        child: Icon( Icons.movie_creation_outlined, color: Theme.of(context).primaryColor, size: 130 ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if ( query.isEmpty ) return _emptyContainer( context );

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery( query );

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: ( _, AsyncSnapshot<List<Movie>> snapshot ) {

        if ( !snapshot.hasData ) return _emptyContainer( context );

        final movies = snapshot.data!;

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: ( _, int index ) => _MovieItem( movies[index] )
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem( this.movie );

  @override
  Widget build(BuildContext context) {

    movie.heroId = "search-${ movie.id }";

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage( "assets/no-image.jpg" ),
          image: NetworkImage( movie.fullPosterImg ),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text( movie.title, style: TextStyle( color: Theme.of(context).buttonColor ) ),
      subtitle: Text( movie.originalTitle, style: TextStyle( color: Theme.of(context).buttonColor ) ),
      onTap: ( ) => Navigator.pushNamed( context, "/tmdb_details", arguments: movie ),
    );
  }
}