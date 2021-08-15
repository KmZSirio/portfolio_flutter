import 'package:rxdart/rxdart.dart';
import 'package:sirio_portfolio/main/spotify/models/authorization_model.dart';
import 'package:sirio_portfolio/main/spotify/providers/repository.dart';

class AuthorizationBloc {
  final _repository = AuthorizationRepository();
  
  final PublishSubject<String> _authorizationCodeFetcher = PublishSubject();
  final PublishSubject<AuthorizationModel> _authorizationTokenFetcher = PublishSubject();

  Stream<String> get authorizationCode => _authorizationCodeFetcher.stream;
  Stream<AuthorizationModel> get authorizationToken => _authorizationTokenFetcher.stream;

  fetchAuthorizationCode() async {
    try {
      String code = await _repository.fetchAuthorizationCode();
      _authorizationCodeFetcher.sink.add(code);
    } catch (e) {
      _authorizationCodeFetcher.sink.addError(e);
    } 
  }

  fetchAuthorizationToken(String code) async {
    try {
      AuthorizationModel authorizationModel = await _repository.fetchAuthorizationToken(code);
      _authorizationTokenFetcher.sink.add(authorizationModel);
    } catch (e) {
      _authorizationTokenFetcher.sink.addError(e);
    }
  }

  disposeCode() => _authorizationCodeFetcher.close();

  disposeToken() => _authorizationTokenFetcher.close();
}

final AuthorizationBloc authorizationBloc = AuthorizationBloc();