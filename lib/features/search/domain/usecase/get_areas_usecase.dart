import 'package:dartz/dartz.dart';
import 'package:nawytask/core/error/failures.dart';
import 'package:nawytask/core/usecase/usecase.dart';
import 'package:nawytask/features/search/data/model/area_model.dart';
import 'package:nawytask/features/search/domain/repository/search_repo.dart';

class GetAreasUseCase
    implements UseCase<List<AreaModel>, NoParams> {
  final SearchRepo searchRepo;
  GetAreasUseCase({required this.searchRepo});
  @override
  Future<Either<Failure, List<AreaModel>>> call(NoParams noParams) async {
    final result = await searchRepo.getAllArea();
    return result;
  }
}
