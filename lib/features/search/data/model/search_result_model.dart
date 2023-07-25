class SearchResultModel {
  int? minPrice;
  int? maxPrice;
  String? compoundId;
  String? areaId;
  int? minNumberOfBedrooms;
  int? maxNumberOfBedrooms;

  SearchResultModel(
      {this.minPrice,
      this.maxPrice,
      this.compoundId,
      this.areaId,
      this.minNumberOfBedrooms,
      this.maxNumberOfBedrooms});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    compoundId = json['compound_id'];
    areaId = json['area_id'];
    minNumberOfBedrooms = json['min_number_of_bedrooms'];
    maxNumberOfBedrooms = json['max_number_of_bedrooms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['compound_id'] = compoundId;
    data['area_id'] = areaId;
    data['min_number_of_bedrooms'] = minNumberOfBedrooms;
    data['max_number_of_bedrooms'] = maxNumberOfBedrooms;
    return data;
  }
}
