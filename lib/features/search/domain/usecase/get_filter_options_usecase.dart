import 'package:dartz/dartz.dart';
import 'package:nawytask/core/error/failures.dart';
import 'package:nawytask/core/usecase/usecase.dart';
import 'package:nawytask/features/search/data/model/filteroption_model.dart';
import 'package:nawytask/features/search/domain/repository/search_repo.dart';

class GetFilterOptionsUseCase implements UseCase<FilterOptionsModel, NoParams> {
  final SearchRepo searchRepo;
  GetFilterOptionsUseCase({required this.searchRepo});
  @override
  Future<Either<Failure, FilterOptionsModel>> call(NoParams noParams) async {
    final result = await searchRepo.getFilterOption();
    return result;
  }
}
