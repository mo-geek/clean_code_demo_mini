class FilterOptionsModel {
  int? minBedrooms;
  int? maxBedrooms;
  List<int>? priceList;

  FilterOptionsModel({this.minBedrooms, this.maxBedrooms, this.priceList});

  factory FilterOptionsModel.fromJson(Map<String, dynamic> json) {
    return FilterOptionsModel(
      minBedrooms: json['min_bedrooms'],
      maxBedrooms: json['max_bedrooms'],
      priceList:
          List<int>.from(json['price_list'].map((price) => price as int)),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['min_bedrooms'] = minBedrooms;
    data['max_bedrooms'] = maxBedrooms;
    data['price_list'] = priceList;
    return data;
  }
}
