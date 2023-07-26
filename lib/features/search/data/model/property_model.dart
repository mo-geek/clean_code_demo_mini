class PropertyModel {
  int? totalCompounds;
  int? totalProperties;
  List<PropertyInfo>? values;

  PropertyModel({this.totalCompounds, this.totalProperties, this.values});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    totalCompounds = json['total_compounds'];
    totalProperties = json['total_properties'];
    if (json['values'] != null) {
      values = <PropertyInfo>[];
      json['values'].forEach((v) {
        values!.add(PropertyInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['total_compounds'] = totalCompounds;
    data['total_properties'] = totalProperties;
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropertyInfo {
  int? id;
  String? name;
  PropertyType? propertyType;
  PropertyType? compound;
  PropertyType? area;
  String? image;
  int? minUnitArea;
  int? maxUnitArea;
  int? minPrice;
  int? maxPrice;
  String? currency;
  int? maxInstallmentYears;
  int? minInstallments;
  int? numberOfBathrooms;
  int? numberOfBedrooms;

  PropertyInfo(
      {this.id,
      this.name,
      this.propertyType,
      this.compound,
      this.area,
      this.image,
      this.minUnitArea,
      this.maxUnitArea,
      this.minPrice,
      this.maxPrice,
      this.currency,
      this.maxInstallmentYears,
      this.minInstallments,
      this.numberOfBathrooms,
      this.numberOfBedrooms});

  PropertyInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    propertyType = json['property_type'] != null
        ? PropertyType.fromJson(json['property_type'])
        : null;
    compound = json['compound'] != null
        ? PropertyType.fromJson(json['compound'])
        : null;
    area = json['area'] != null ? PropertyType.fromJson(json['area']) : null;
    image = json['image'];
    minUnitArea = json['min_unit_area'];
    maxUnitArea = json['max_unit_area'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    currency = json['currency'];
    maxInstallmentYears = json['max_installment_years'];
    minInstallments = json['min_installments'];
    numberOfBathrooms = json['number_of_bathrooms'];
    numberOfBedrooms = json['number_of_bedrooms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (propertyType != null) {
      data['property_type'] = propertyType!.toJson();
    }
    if (compound != null) {
      data['compound'] = compound!.toJson();
    }
    if (area != null) {
      data['area'] = area!.toJson();
    }
    data['image'] = image;
    data['min_unit_area'] = minUnitArea;
    data['max_unit_area'] = maxUnitArea;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['currency'] = currency;
    data['max_installment_years'] = maxInstallmentYears;
    data['min_installments'] = minInstallments;
    data['number_of_bathrooms'] = numberOfBathrooms;
    data['number_of_bedrooms'] = numberOfBedrooms;
    return data;
  }
}

class PropertyType {
  int? id;
  String? name;

  PropertyType({this.id, this.name});

  PropertyType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
