import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawytask/core/usecase/usecase.dart';
import 'package:nawytask/features/search/data/model/filter_option_model.dart';
import 'package:nawytask/features/search/domain/usecase/get_filter_options_usecase.dart';

import '../../../core/mocks/mock_data.dart';

void main() {
  //use case
  GetFilterOptionsUseCase usecase;
  //mocked repo
  MockSearchRemoteRepo mockSearchRemoteRepo;
  final filterOptionModel = FilterOptionsModel();
  test(
    'should get filterOptions model when call the usecase ',
    () async {
      mockSearchRemoteRepo = MockSearchRemoteRepo();
      usecase = GetFilterOptionsUseCase(searchRepo: mockSearchRemoteRepo);
      // arrange
      when(() => mockSearchRemoteRepo.getFilterOption())
          .thenAnswer((_) async => Right(filterOptionModel));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, Right(filterOptionModel));
      verify((() => mockSearchRemoteRepo.getFilterOption()));
      verifyNoMoreInteractions(mockSearchRemoteRepo);
    },
  );
}
