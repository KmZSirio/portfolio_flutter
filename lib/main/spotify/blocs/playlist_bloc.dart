import 'package:rxdart/rxdart.dart';
import 'package:sirio_portfolio/main/spotify/models/playlist_list_response.dart';
import 'package:sirio_portfolio/main/spotify/providers/repository.dart';

class PlaylistBloc {
  final _repository = PlaylistRepository();

  final PublishSubject<PlaylistListResponse> _playlistListFetcher = PublishSubject();

  Stream<PlaylistListResponse> get playlistList => _playlistListFetcher.stream;

  fetchPlaylistList() async {
    try {
      PlaylistListResponse list = await _repository.fetchPlaylistList();
      _playlistListFetcher.sink.add(list);
    } catch (e) {
      _playlistListFetcher.sink.addError(e);
    }
  }

  disposePlaylist() => _playlistListFetcher.close();
}

final PlaylistBloc playlistBloc = PlaylistBloc();