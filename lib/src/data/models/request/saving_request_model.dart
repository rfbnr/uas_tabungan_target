import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class SavingRequestModel {
  final String name;
  final int targetAmount;
  final String savingFrequency;
  final int nominalPerFrequency;
  final String startDate;
  final String endDate;
  final XFile? image;

  SavingRequestModel({
    required this.name,
    required this.targetAmount,
    required this.savingFrequency,
    required this.nominalPerFrequency,
    required this.startDate,
    required this.endDate,
    this.image,
  });

  factory SavingRequestModel.fromRawJson(String str) =>
      SavingRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavingRequestModel.fromJson(Map<String, dynamic> json) =>
      SavingRequestModel(
        name: json["name"],
        targetAmount: json["target_amount"],
        savingFrequency: json["saving_frequency"],
        nominalPerFrequency: json["nominal_per_frequency"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        image: json["image"],
      );

  Map<String, String> toJson() => {
        "name": name,
        "target_amount": targetAmount.toString(),
        "saving_frequency": savingFrequency,
        "nominal_per_frequency": nominalPerFrequency.toString(),
        "start_date": startDate,
        "end_date": endDate,
      };
}
