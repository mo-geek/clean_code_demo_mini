import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawytask/features/search/data/model/filteroption_model.dart';
import 'package:nawytask/features/search/data/repository/search_repo_Impl.dart';
import '../../../../core/mocks/mock_data.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  //repository implementation
  SearchRepoImpl searchRepoImpl;
  //mocked datasource
  MockSearchRemoteDataSource mockSearchRemoteDataSource;
  //mocked network
  MockNetworkInfo mockNetworkInfo;
  //setup
  mockSearchRemoteDataSource = MockSearchRemoteDataSource();
  mockNetworkInfo = MockNetworkInfo();
  searchRepoImpl = SearchRepoImpl(
      searchRemoteDataSource: mockSearchRemoteDataSource,
      networkInfo: mockNetworkInfo);

  final String jsonData = fixture('get_filter_options_model.json');
  Map<String, dynamic> map = json.decode(jsonData);
  final FilterOptionsModel filterOptionsModel =
      FilterOptionsModel.fromJson(map);

  // setUpAll(() {
  //   registerFallbackValue(FilterOptionsModelFake());
  // });

  group("getFilterOptionsModel", () {
    test(
      'should get FilterOptionsModel when calling getFilterOption from SearchRepoImpl()',
      () async {
        // arrange
        when(
          () => mockSearchRemoteDataSource.getFilterOption(),
        ).thenAnswer((_) async => filterOptionsModel);
        when(
          () => mockNetworkInfo.isConnected,
        ).thenAnswer((_) async => true);
        // act

        final res = awaimo.getFilterOption();

        // assert
        expect(res, equals(Right(filterOptionsModel)));
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockSearchRemoteDataSource.getFilterOption());
      },
    );
  });
}
//
// class FilterOptionsModelFake extends Fake implements FilterOptionsModel {}
