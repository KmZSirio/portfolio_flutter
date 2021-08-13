import 'package:rxdart/rxdart.dart';
import 'package:sirio_portfolio/main/spotify/providers/repository.dart';

class AuthorizationBloc {
  final _repository = RepositoryAuthorization();

  
  final PublishSubject<String> _authorizationCodeFetcher = PublishSubject();

  Stream<String> get authorizationCode => _authorizationCodeFetcher.stream;

  fetchAuthorizationCode() async {
    try {
      String code = await _repository.fetchAuthorizationCode();
      _authorizationCodeFetcher.sink.add(code);
    } catch (e) {
      _authorizationCodeFetcher.sink.addError(e);
    }
    
  }

  disposeCode() {
    _authorizationCodeFetcher.close();
  }


}

final AuthorizationBloc authorizationBloc = AuthorizationBloc();