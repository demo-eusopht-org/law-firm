import 'package:json_annotation/json_annotation.dart';

part 'new_lawyer_model.g.dart';

@JsonSerializable()
class NewLawyerModel {
  String? message;
  int? status;

  NewLawyerModel({
    this.message,
    this.status,
  });
  factory NewLawyerModel.fromJson(Map<String, dynamic> json) =>
      _$NewLawyerModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewLawyerModelToJson(this);
}
