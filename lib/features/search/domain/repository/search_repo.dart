import 'package:dartz/dartz.dart';
import 'package:nawytask/core/error/failures.dart';
import 'package:nawytask/features/search/data/model/area_model.dart';
import 'package:nawytask/features/search/data/model/compound_model.dart';
import 'package:nawytask/features/search/data/model/filter_option_model.dart';
import 'package:nawytask/features/search/data/model/property_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<CompoundModel>>> getAllCompound();

  Future<Either<Failure, List<AreaModel>>> getAllArea();

  Future<Either<Failure, FilterOptionsModel>> getFilterOption();

  Future<Either<Failure, PropertyModel>> getPropertyBySearch(
      Map<String, dynamic> data);
}
