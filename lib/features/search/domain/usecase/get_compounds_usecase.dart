import 'package:dartz/dartz.dart';
import 'package:nawytask/core/error/failures.dart';
import 'package:nawytask/core/usecase/usecase.dart';
import 'package:nawytask/features/search/data/model/compound_model.dart';
import 'package:nawytask/features/search/domain/repository/search_repo.dart';

class GetCompoundsUseCase
    implements UseCase<List<CompoundModel>, NoParams> {
  final SearchRepo searchRepo;
  GetCompoundsUseCase({required this.searchRepo});
  @override
  Future<Either<Failure, List<CompoundModel>>> call(NoParams noParams) async {
    final result = await searchRepo.getAllCompound();
    return result;
  }
}
