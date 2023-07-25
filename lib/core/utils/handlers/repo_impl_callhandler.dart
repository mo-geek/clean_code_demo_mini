import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:nawytask/core/error/exceptions.dart';
import 'package:nawytask/core/error/failures.dart';
import 'package:nawytask/core/network/network_info.dart';

class RepoImplCallHandler<T> {
  final NetworkInfo networkInfo;
  RepoImplCallHandler(this.networkInfo);

  Future<Either<Failure, T>> call(Future<T> Function() datasourceCall) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await datasourceCall());
      } on DataParsingException catch (e) {
        log(e.cause, name: "on DataParsingException");
        return Left(DataParsingFailure(e.cause));
      } on ServerException catch (e) {
        Logger().e(e);
        return Left(ServerFailure(e.toString()));
      } on DioError catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        Logger().e(e);
        return Left(AmbiguousFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
