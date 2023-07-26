import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawytask/core/network/network_manager.dart';
import 'package:nawytask/features/search/data/datasource/search_remote_datasource.dart';
import 'package:nawytask/features/search/data/model/filter_option_model.dart';
import '../../../../core/mocks/mock_data.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final MockNetworkManager mockNetworkManager = MockNetworkManager();
  final SearchRemoteDataSourceImpl searchRemoteDataSourceImpl =
      SearchRemoteDataSourceImpl(mockNetworkManager);
  final String jsonData = fixture('get_filter_options_model.json');
  Map<String, dynamic> map = json.decode(jsonData);
  group("getFilterOption", () {
    test(
      'should get remote data when calling remote datasource getFilterOption() Success and returns 200',
      () async {
        //** arrange */
        when(() => mockNetworkManager.request(
            method: RequestMethod.get,
            endPoint: any(named: 'endPoint'))).thenAnswer(
          (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: map,
              statusCode: 200),
        );

        //** act */
        final res = await searchRemoteDataSourceImpl.getFilterOption();
        //** assert */
        expect(res, isA<FilterOptionsModel>());
      },
    );
  });
}
