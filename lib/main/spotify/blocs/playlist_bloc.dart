import 'package:rxdart/rxdart.dart';
import 'package:sirio_portfolio/main/spotify/models/playlist_items_response.dart';
import 'package:sirio_portfolio/main/spotify/models/playlist_list_response.dart';
import 'package:sirio_portfolio/main/spotify/providers/repository.dart';

class PlaylistBloc {
  final _repository = PlaylistRepository();

  final PublishSubject<PlaylistListResponse>  _playlistListFetcher = PublishSubject();
  final PublishSubject<PlaylistItemsResponse> _playlistItemsFetcher = PublishSubject();

  Stream<PlaylistListResponse>  get playlistList => _playlistListFetcher.stream;
  Stream<PlaylistItemsResponse> get playlistItems => _playlistItemsFetcher.stream;

  fetchPlaylistList() async {
    try {
      PlaylistListResponse list = await _repository.fetchPlaylistList();
      _playlistListFetcher.sink.add(list);
    } catch (e) {
      _playlistListFetcher.sink.addError(e);
    }
  }

  fetchPlaylistItems(String url, String endpoint) async {
    try {
      PlaylistItemsResponse items = await _repository.fetchPlaylistItems(url, endpoint);
      _playlistItemsFetcher.sink.add(items);
    } catch (e) {
      _playlistItemsFetcher.sink.addError(e);
    }
  }

  disposePlaylistList() => _playlistListFetcher.close();

  disposePlaylistItems() => _playlistItemsFetcher.close();
}

final PlaylistBloc playlistBloc = PlaylistBloc();