import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/main/data/persistent_storage_repository.dart';

class L10nCubit extends Cubit<int> {
  L10nCubit( this._persistentStorageRepository ) : super(0);
  final PersistentStorageRepository _persistentStorageRepository;

  int _language = 0;
  int get language => _language;

  Future<void> init() async {
    _language = await _persistentStorageRepository.whichLanguage();
    emit( _language );
  }

  Future<void> updateLanguage ( language ) async {
    _language = language;
    await _persistentStorageRepository.updateLanguage(language);
    emit( _language );
  }
}