part of 'faces_model.dart';

FacesModel _$FaceModelFromJson(Map<String, dynamic> json) {
  return FacesModel(date: json['date']);
}

Map<String, dynamic> _$FaceModelToJson(FacesModel obj) => {"date": obj.date};
