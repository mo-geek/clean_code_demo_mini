import 'package:dartz/dartz.dart';
import 'package:nawytask/core/error/failures.dart';
import 'package:nawytask/core/usecase/usecase.dart';
import 'package:nawytask/features/search/data/model/property_model.dart';
import 'package:nawytask/features/search/data/model/search_result_model.dart';
import 'package:nawytask/features/search/domain/repository/search_repo.dart';

class SearchPropertyUseCase
    implements UseCase<PropertyModel, SearchPropertyUseCaseParams> {
  final SearchRepo searchRepo;

  SearchPropertyUseCase({required this.searchRepo});

  Future<Either<Failure, PropertyModel>> call(
      SearchPropertyUseCaseParams params) async {
    return await searchRepo
        .getPropertyBySearch(params.searchResultModel.toJson());
  }
}

class SearchPropertyUseCaseParams {
  SearchResultModel searchResultModel;
  SearchPropertyUseCaseParams({required this.searchResultModel});
}
