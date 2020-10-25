import 'dart:convert';

part 'faces_model.g.dart';

class FacesModel {
  final String date;

  FacesModel({this.date});

  factory FacesModel.fromJson(Map<String, dynamic> json) =>
      _$FaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaceModelToJson(this);
}
