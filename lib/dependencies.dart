import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/main/data/prod/persistent_storage_impl.dart';

import 'main/data/persistent_storage_repository.dart';

List<RepositoryProvider> buildRepositories() {
  return [

    RepositoryProvider<PersistentStorageRepository>( create: (_) => PersistentStorageImpl() ),

  ];
}