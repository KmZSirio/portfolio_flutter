import 'dart:async';

import 'package:sirio_portfolio/main/spotify/models/authorization_model.dart';
import 'package:sirio_portfolio/main/spotify/models/playlist_items_response.dart';
import 'package:sirio_portfolio/main/spotify/models/playlist_list_response.dart';
import 'package:sirio_portfolio/main/spotify/models/top_artists_response.dart';
import 'package:sirio_portfolio/main/spotify/providers/playlist_items_api_provider.dart';
import 'package:sirio_portfolio/main/spotify/providers/playlist_list_api_provider.dart';
import 'package:sirio_portfolio/main/spotify/providers/top_tracks_artists_api_provider.dart';

import 'authorization_api_provider.dart';
import 'authorization_token_api_provider.dart';

class AuthorizationRepository {
  final authorizationCodeApiProvider  = AuthorizationApiProvider();
  final authorizationTokenApiProvider = AuthorizationTokenApiProvider();
  Future<String> fetchAuthorizationCode() => authorizationCodeApiProvider.fetchAuthCode();
  Future<AuthorizationModel> fetchAuthorizationToken(String code) => authorizationTokenApiProvider.fetchToken(code);
}

class PlaylistRepository {
  final playlistListApiProvider  = PlaylistListApiProvider();
  final playlistItemsApiProvider = PlaylistItemsApiProvider();
  Future<PlaylistListResponse> fetchPlaylistList() => playlistListApiProvider.fetchPlaylistList();
  Future<PlaylistItemsResponse> fetchPlaylistItems(String url, String endpoint) => playlistItemsApiProvider.fetchPlaylistItems(url, endpoint);
}

class TopItemsRepository {
  final topTracksArtistsApiProvider = TopTracksArtistsApiProvider();
  Future<TopArtistsResponse> fetchTopArtists() => topTracksArtistsApiProvider.fetchTopArtists();
}