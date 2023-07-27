import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nawytask/core/error/error_object.dart';
import 'package:nawytask/core/usecase/usecase.dart';
import 'package:nawytask/core/utils/get_it_injection.dart';
import 'package:nawytask/features/search/data/model/area_model.dart';
import 'package:nawytask/features/search/data/model/compound_model.dart';
import 'package:nawytask/features/search/data/model/filter_option_model.dart';
import 'package:nawytask/features/search/data/model/property_model.dart';
import 'package:nawytask/features/search/data/model/search_result_model.dart';
import 'package:nawytask/features/search/domain/usecase/get_areas_usecase.dart';
import 'package:nawytask/features/search/domain/usecase/get_compounds_usecase.dart';
import 'package:nawytask/features/search/domain/usecase/get_filter_options_usecase.dart';
import 'package:nawytask/features/search/domain/usecase/search_property_usecase.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  bool loadingFlag = false;
  String _searchText = '';
  TextEditingController searchController = TextEditingController();

  late SearchResultModel _searchResultModel;

  List<AreaModel> _areasList = [];
  List<CompoundModel> _compoundsList = [];
  PropertyModel? propertyModel;
  late FilterOptionsModel _filterOptions;
  AreaModel? _selectedAreaModel;
  CompoundModel? _selectedCompoundModel;

  int? divisionPrice;
  double minPrice = 0.0;
  double maxPrice = 2.0;
  double? selectedMinPrice;
  double? selectedMaxPrice;
  RangeValues selectedPriceRange = const RangeValues(0.2, 0.8);

  int? divisionBedRooms;
  double minBedRooms = 0.0;
  double maxBedRooms = 2.0;
  double? selectedMinRooms;
  double? selectedMaxRooms;
  RangeValues selectedBedRoomsRange = const RangeValues(0.2, 0.8);

  Future<void> init() async {
    debugPrint('from SearchViewModel init');
    await getAreasList();
    await getCompoundsList();
    await getFilterOptions();
    updatePriceSlider();
    updateRoomSlider();
  }

  void loadingToggle() {
    loadingFlag = !loadingFlag;
    notifyListeners();
  }

  Future<void> showResults() async {
    loadingToggle();
    _searchText = searchController.text.toString();
    await searchProperty();
    loadingFlag = false;
    loadingToggle();
  }

  void setPriceRange(RangeValues v) {
    selectedMinPrice = v.start;
    selectedMaxPrice = v.end;
    selectedPriceRange = v;
    notifyListeners();
  }

  void setRoomRange(RangeValues v) {
    selectedMinRooms = v.start;
    selectedMaxRooms = v.end;
    selectedBedRoomsRange = v;
    notifyListeners();
  }

  Future<void> getAreasList() async {
    debugPrint("from getGetAreasList");
    final res = await getIt<GetAreasUseCase>()(NoParams());
    res.fold((e) {
      debugPrint(e.cause.toString());
      Logger().e(ErrorObject.mapFailureToErrorObject(failure: e).message);
    }, (response) {
      Logger().i(response.toString());
      _areasList = response;
    });
    notifyListeners();
  }

  Future<void> getCompoundsList() async {
    debugPrint("from getCompoundsList");
    final res = await getIt<GetCompoundsUseCase>()(NoParams());
    res.fold((e) {
      debugPrint(e.cause.toString());
      Logger().e(ErrorObject.mapFailureToErrorObject(failure: e).message);
    }, (response) {
      Logger().i(response.toString());
      _compoundsList = response;
    });
    notifyListeners();
  }

  Future<void> getFilterOptions() async {
    debugPrint("from getGetFilterOptions");
    final res = await getIt<GetFilterOptionsUseCase>()(NoParams());
    res.fold((e) {
      debugPrint(e.cause.toString());
      Logger().e(ErrorObject.mapFailureToErrorObject(failure: e).message);
    }, (response) {
      Logger().i(response.toString());
      _filterOptions = response;
    });
    notifyListeners();
  }

  Future<void> searchProperty() async {
    debugPrint("from searchProperty");
    searchForArea();
    searchForCompound();
    updateSearchResultModel();
    final res = await getIt<SearchPropertyUseCase>()(
      SearchPropertyUseCaseParams(searchResultModel: _searchResultModel),
    );
    res.fold((e) {
      debugPrint(e.cause.toString());
      Logger().e(ErrorObject.mapFailureToErrorObject(failure: e).message);
    }, (response) {
      Logger().i(response.toString());
      debugPrint(response.toString());
      debugPrint(
          response.values?.length.toString() ?? "Empty Property List!!!");
      propertyModel = response;
    });
  }

  void searchForArea() {
    debugPrint('form searchForArea');
    String text = _searchText;
    if (text.contains(',')) {
      text = skipAndTrimAfterComma(text);
    }
    _selectedAreaModel = _areasList.firstWhere(
        (item) =>
            item.name?.toLowerCase().contains(text.toLowerCase()) ?? false,
        orElse: () => AreaModel(name: '', id: null));
    debugPrint(_selectedAreaModel?.id.toString());
    debugPrint(_selectedAreaModel?.name.toString());
  }

  void searchForCompound() {
    debugPrint('from searchForCompound');
    String text = _searchText;
    if (text.contains(',')) {
      text = skipAndTrimBeforeComma(text);
    }
    _selectedCompoundModel = _compoundsList.firstWhere(
        (item) =>
            item.name?.toLowerCase().contains(text.toLowerCase()) ?? false,
        orElse: () => CompoundModel(name: '', id: null));
    debugPrint(_selectedCompoundModel?.id.toString());
    debugPrint(_selectedCompoundModel?.name.toString());
  }

  void updatePriceSlider() {
    List? list = _filterOptions.priceList;
    minPrice = list?.first.toDouble();
    maxPrice = list?.last.toDouble();
    int start = (maxPrice - minPrice) ~/ 2.0;
    double end = maxPrice;
    selectedPriceRange = RangeValues(start.toDouble(), end);
    divisionPrice = list?.length != null && list?.isNotEmpty == true
        ? list!.length - 1
        : null;
    notifyListeners();
  }

  void updateRoomSlider() {
    minBedRooms = _filterOptions.minBedrooms?.toDouble() ?? minBedRooms;
    maxBedRooms = _filterOptions.maxBedrooms?.toDouble() ?? maxBedRooms;
    int start = (maxBedRooms - minBedRooms) ~/ 2.0;
    double end = maxBedRooms;
    selectedBedRoomsRange = RangeValues(start.toDouble(), end);
    divisionBedRooms = (maxBedRooms / minBedRooms).round();
    notifyListeners();
  }

  void updateSearchResultModel() {
    _searchResultModel = SearchResultModel(
      areaId: _selectedAreaModel?.id.toString() ?? '',
      compoundId: _selectedCompoundModel?.id.toString() ?? '',
      maxNumberOfBedrooms: selectedMaxRooms?.toInt() ?? 0,
      minNumberOfBedrooms: selectedMinRooms?.toInt() ?? 0,
      maxPrice: selectedMaxPrice?.toInt() ?? maxPrice.toInt(),
      minPrice: selectedMinPrice?.toInt() ?? minPrice.toInt(),
    );
  }

  String skipAndTrimBeforeComma(String text) {
    List<String> parts = text.split(',');
    if (parts.length > 1) {
      return parts[1].trim();
    } else {
      return text.trim();
    }
  }

  String skipAndTrimAfterComma(String text) {
    List<String> parts = text.split(',');
    if (parts.length > 1) {
      return parts[0].trim();
    } else {
      return text.trim();
    }
  }
}
