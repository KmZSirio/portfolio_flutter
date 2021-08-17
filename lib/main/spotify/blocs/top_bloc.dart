import 'package:rxdart/rxdart.dart';
import 'package:sirio_portfolio/main/spotify/models/top_artists_response.dart';
import 'package:sirio_portfolio/main/spotify/providers/repository.dart';

class TopBloc {
  final _repository = TopItemsRepository();

  final PublishSubject<TopArtistsResponse>  _topArtistsFetcher = PublishSubject();

  Stream<TopArtistsResponse>  get topArtists => _topArtistsFetcher.stream;

  fetchTopArtists() async {
    try {
      TopArtistsResponse list = await _repository.fetchTopArtists();
      _topArtistsFetcher.sink.add(list);
    } catch (e) {
      _topArtistsFetcher.sink.addError(e);
    }
  }

  disposeTopArtists() => _topArtistsFetcher.close();
}

final TopBloc topBloc = TopBloc();