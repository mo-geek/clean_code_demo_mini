import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:nawytask/core/network/network_info.dart';
import 'package:nawytask/core/network/network_manager.dart';
import 'package:nawytask/features/search/data/datasource/search_remote_datasource.dart';
import 'package:nawytask/features/search/data/repository/search_repo_Impl.dart';
import 'package:nawytask/features/search/domain/repository/search_repo.dart';
import 'package:nawytask/features/search/domain/usecase/get_areas_usecase.dart';
import 'package:nawytask/features/search/domain/usecase/get_compounds_usecase.dart';
import 'package:nawytask/features/search/domain/usecase/get_filter_options_usecase.dart';
import 'package:nawytask/features/search/domain/usecase/search_property_usecase.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //!  ----------- Features -----------

  //* data sources
  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(getIt()),
  );
  // //* repo
  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepoImpl(networkInfo: getIt(), searchRemoteDataSource: getIt()),
  );
  // //* use cases
  getIt.registerLazySingleton<GetAreasUseCase>(
      () => GetAreasUseCase(searchRepo: getIt()));
  getIt.registerLazySingleton<GetCompoundsUseCase>(
      () => GetCompoundsUseCase(searchRepo: getIt()));
  getIt.registerLazySingleton<GetFilterOptionsUseCase>(
      () => GetFilterOptionsUseCase(searchRepo: getIt()));
  getIt.registerLazySingleton<SearchPropertyUseCase>(
      () => SearchPropertyUseCase(searchRepo: getIt()));
  //
  // //! ----------- Core -----------
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
  getIt.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
}
