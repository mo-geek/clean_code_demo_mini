import 'dart:convert';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:nawytask/core/error/exceptions.dart';
import 'package:nawytask/core/network/network_manager.dart';
import 'package:nawytask/core/utils/handlers/data_source_handler.dart';
import 'package:nawytask/features/search/data/model/area_model.dart';
import 'package:nawytask/features/search/data/model/compound_model.dart';
import 'package:nawytask/features/search/data/model/filteroption_model.dart';
import 'package:nawytask/features/search/data/model/property_model.dart';

abstract class SearchRemoteDataSource {
  /// Calls the Get { /api/compounds} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CompoundModel>> getAllCompound();

  /// Calls the Get { /api/areas} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<AreaModel>> getAllArea();

  /// Calls the Get { /api/properties/get_filter_options} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<FilterOptionsModel> getFilterOption();

  /// Calls the Post {/api/properties/search} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<PropertyModel> getPropertyBySearch(Map<String, dynamic> data);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final NetworkManager networkManager;
  SearchRemoteDataSourceImpl(
    this.networkManager,
  );

  @override
  Future<List<AreaModel>> getAllArea() async {
    final res = await networkManager.request(
        method: RequestMethod.get, endPoint: "areas");
    final myCall = await DataSourceHandler()(() => Future.value(res));
    try {
      Iterable? l = json.decode(json.encode(myCall));
      List<AreaModel> areas = l != null
          ? List<AreaModel>.from(l.map((model) => AreaModel.fromJson(model)))
          : [];
      return areas;
    } catch (e) {
      debugPrint("The exception is");
      debugPrint(e.toString());
      throw (DataParsingException(e.toString()));
    }
  }

  @override
  Future<List<CompoundModel>> getAllCompound() async {
    final res = await networkManager.request(
        method: RequestMethod.get, endPoint: "compounds");
    final myCall = await DataSourceHandler()(() => Future.value(res));
    try {
      // Deserialize a list of objects from json ...
      Iterable? l = json.decode(json.encode(myCall));
      List<CompoundModel> compounds = l != null
          ? List<CompoundModel>.from(
              l.map((model) => CompoundModel.fromJson(model)))
          : [];
      return compounds;
    } catch (e) {
      debugPrint("The exception is");
      debugPrint(e.toString());
      throw (DataParsingException(e.toString()));
    }
  }

  @override
  Future<FilterOptionsModel> getFilterOption() async {
    final res = await networkManager.request(
        method: RequestMethod.get, endPoint: "properties/get_filter_options");
    final myCall = await DataSourceHandler()(() => Future.value(res));
    try {
      Map<String, dynamic> jsonData = json.decode(json.encode(myCall));
      FilterOptionsModel filterOptions = FilterOptionsModel.fromJson(jsonData);
      return filterOptions;
    } catch (e) {
      debugPrint("The exception is");
      debugPrint(e.toString());
      throw (DataParsingException(e.toString()));
    }
  }

  @override
  Future<PropertyModel> getPropertyBySearch(Map<String, dynamic> data) async {
    debugPrint(data.toString());
    final res = await networkManager.request(
        method: RequestMethod.post, endPoint: "properties/search", data: data);
    //todo: ensure the backend has 201 success code
    if (res.statusCode == 200) {
      return PropertyModel.fromJson(res.data);
    } else {
      debugPrint(res.toString());
      //todo: ensure the backend send error message with [message] key
      throw ServerException(res);
    }
  }
}
