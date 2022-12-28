import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirio_portfolio/main/data/persistent_storage_repository.dart';

class BarWeightCubit extends Cubit<bool> {
  BarWeightCubit( this._persistentStorageRepository ) : super(false);
  final PersistentStorageRepository _persistentStorageRepository;

  bool _bar35lbs = false;
  bool get bar35lbs => _bar35lbs;

  Future<void> init() async {
    _bar35lbs = await _persistentStorageRepository.is35lbs();
    emit(bar35lbs);
  }

  Future<void> updateBarWeight( bar35lbs ) async {
    _bar35lbs = bar35lbs;
    await _persistentStorageRepository.updateBarWeight(bar35lbs);
    emit(_bar35lbs);
  }
}