import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sirio_portfolio/main/helpers/debouncer.dart';
import 'package:sirio_portfolio/main/tmdb/models/tmdb_models.dart';

class MoviesProvider extends ChangeNotifier {

  // TODO Debouncer para populares!!

  String _baseUrl  = "api.themoviedb.org";
  String _apiKey   = "db4d552faaf3edb57d6b03f0afe1e549";
  String _language = "es-ES";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies   = [];

  Map<int, List<Cast>> moviesCast = {};
  Map<int, List<Movie>> similarMovies = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration( milliseconds: 400 )
  );

  // ignore: close_sinks
  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider() {
    getNowPlaying();
    getPopular();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    final url = Uri.https( _baseUrl, endpoint, {
      "api_key": _apiKey,
      "language": _language,
      "page": "$page"
    });

    final response = await http.get(url);
    return response.body;
  }

  getNowPlaying() async {
    final jsonData = await _getJsonData( "/3/movie/now_playing" );
    final nowPlayingResponse = NowPlayingResponse.fromJson( jsonData );

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopular() async {
    _popularPage++;

    final jsonData = await _getJsonData( "/3/movie/popular", _popularPage );
    final popularResponse = PopularResponse.fromJson( jsonData );

    popularMovies = [ ...popularMovies, ...popularResponse.results ];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if ( moviesCast.containsKey( movieId ) ) return moviesCast[movieId]!;

    final jsonData = await _getJsonData( "/3/movie/$movieId/credits" );
    final creditsResponse = CreditsResponse.fromJson( jsonData );

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie( String query ) async {
    final url = Uri.https( _baseUrl, "/3/search/movie", {
      "api_key": _apiKey,
      "language": _language,
      "query": query,
    });

    final response = await http.get(url);
    final searchMovieResponse = SearchMovieResponse.fromJson( response.body );

    return searchMovieResponse.results;
  }

  void getSuggestionsByQuery( String searchTerm ) {
    debouncer.value = "";
    debouncer.onValue = ( value ) async {

      final results = await searchMovie( value );
      _suggestionStreamController.add( results );
    };

    final timer = Timer.periodic( Duration( milliseconds: 300 ), ( _ ) {
      debouncer.value = searchTerm;
    });

    Future.delayed( Duration( milliseconds: 301 ) ).then(( _ ) => timer.cancel());
  }

  Future<List<Movie>> getSimilar( int movieId ) async {

    if ( similarMovies.containsKey( movieId ) ) return similarMovies[movieId]!;

    final jsonData = await _getJsonData( "/3/movie/$movieId/similar" );
    final similarResponse = PopularResponse.fromJson( jsonData );

    similarMovies[movieId] = similarResponse.results;
    return similarResponse.results;
  }
}