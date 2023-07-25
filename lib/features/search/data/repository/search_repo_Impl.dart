import 'package:dartz/dartz.dart';
import 'package:nawytask/core/error/failures.dart';
import 'package:nawytask/core/network/network_info.dart';
import 'package:nawytask/core/utils/handlers/repo_impl_callhandler.dart';
import 'package:nawytask/features/search/data/datasource/search_remote_datasource.dart';
import 'package:nawytask/features/search/data/model/area_model.dart';
import 'package:nawytask/features/search/data/model/compound_model.dart';
import 'package:nawytask/features/search/data/model/filteroption_model.dart';
import 'package:nawytask/features/search/data/model/property_model.dart';
import 'package:nawytask/features/search/domain/repository/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  SearchRemoteDataSource searchRemoteDataSource;
  final NetworkInfo networkInfo;

  SearchRepoImpl({
    required this.searchRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AreaModel>>> getAllArea() async {
    return await RepoImplCallHandler<List<AreaModel>>(networkInfo)(() async {
      return await searchRemoteDataSource.getAllArea();
    });
  }

  @override
  Future<Either<Failure, List<CompoundModel>>> getAllCompound() async {
    return await RepoImplCallHandler<List<CompoundModel>>(networkInfo)(
        () async {
      return await searchRemoteDataSource.getAllCompound();
    });
  }

  @override
  Future<Either<Failure, FilterOptionsModel>> getFilterOption() async {
    return await RepoImplCallHandler<FilterOptionsModel>(networkInfo)(() async {
      return await searchRemoteDataSource.getFilterOption();
    });
  }

  @override
  Future<Either<Failure, PropertyModel>> getPropertyBySearch(
      Map<String, dynamic> data) async {
    return await RepoImplCallHandler<PropertyModel>(networkInfo)(() async {
      return await searchRemoteDataSource.getPropertyBySearch(data);
    });
  }
}
