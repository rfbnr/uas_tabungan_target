import 'dart:convert';

class SavingsResponseModel {
  final String? status;
  final String? message;
  final List<SavingsResultResponseModel>? data;

  SavingsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory SavingsResponseModel.fromRawJson(String str) =>
      SavingsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavingsResponseModel.fromJson(Map<String, dynamic> json) =>
      SavingsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SavingsResultResponseModel>.from(json["data"]!
                .map((x) => SavingsResultResponseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SavingsResultResponseModel {
  final int? id;
  final int? userId;
  final String? name;
  final int? targetAmount;
  final String? savingFrequency;
  final int? nominalPerFrequency;
  final int? currentSavings;
  final int? isWithdrawn;
  final int? remainingAmount;
  final int? remainingDays;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? targetAchievedDate;
  final String? status;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SavingsResultResponseModel({
    this.id,
    this.userId,
    this.name,
    this.targetAmount,
    this.savingFrequency,
    this.nominalPerFrequency,
    this.currentSavings,
    this.isWithdrawn,
    this.remainingAmount,
    this.remainingDays,
    this.startDate,
    this.endDate,
    this.targetAchievedDate,
    this.status,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory SavingsResultResponseModel.fromRawJson(String str) =>
      SavingsResultResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavingsResultResponseModel.fromJson(Map<String, dynamic> json) =>
      SavingsResultResponseModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        targetAmount: json["target_amount"],
        savingFrequency: json["saving_frequency"],
        nominalPerFrequency: json["nominal_per_frequency"],
        currentSavings: json["current_savings"],
        isWithdrawn: json["is_withdrawn"],
        remainingAmount: json["remaining_amount"],
        remainingDays: json["remaining_days"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        targetAchievedDate: json["target_achieved_date"] == null
            ? null
            : DateTime.parse(json["target_achieved_date"]),
        status: json["status"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "target_amount": targetAmount,
        "saving_frequency": savingFrequency,
        "nominal_per_frequency": nominalPerFrequency,
        "current_savings": currentSavings,
        "is_withdrawn": isWithdrawn,
        "remaining_amount": remainingAmount,
        "remaining_days": remainingDays,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "target_achieved_date": targetAchievedDate?.toIso8601String(),
        "status": status,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
