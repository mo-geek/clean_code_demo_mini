import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nawytask/core/error/exceptions.dart';

class AreaModel {
  int? id;
  String? name;

  AreaModel({this.id, this.name});

  AreaModel.fromJson(Map<String, dynamic> json) {
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
