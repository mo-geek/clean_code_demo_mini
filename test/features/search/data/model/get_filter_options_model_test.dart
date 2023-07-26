import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:nawytask/features/search/data/model/filter_option_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  test(
    'should get a valid Model from this json data',
    () async {
      // arrange
      final String jsonData = fixture('get_filter_options_model.json');
      Map<String, dynamic> map = json.decode(jsonData);
      // act
      final FilterOptionsModel areaModel =
          FilterOptionsModel.fromJson(map as Map<String, dynamic>);

      // assert
      expect(areaModel, isA<FilterOptionsModel>());
    },
  );
}
