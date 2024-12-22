import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/request/saving_request_model.dart';
import '../models/response/error_response_model.dart';
import '../models/response/savings_response_model.dart';
import '../models/response/success_response_model.dart';
import 'auth_local_datasource.dart';

class SavingRemoteDatasource {
  Future<Either<ErrorResponseModel, SavingsResponseModel>> getSavingByStatus({
    required String status,
  }) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse("${Variables.baseUrl}/api/savings/status/$status"),
      headers: {
        "Authorization": "Bearer ${authData.data?.token ?? "-"}",
      },
    );

    if (response.statusCode == 200) {
      return Right(SavingsResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, SuccessResponseModel>> addSaving({
    required SavingRequestModel savingRequestModel,
  }) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final Map<String, String> headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${authData.data?.token ?? "-"}",
    };

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${Variables.baseUrl}/api/savings"),
    );

    request.fields.addAll(savingRequestModel.toJson());

    if (savingRequestModel.image != null) {
      final file = File(savingRequestModel.image!.path);
      if (await file.exists()) {
        request.files.add(
          http.MultipartFile(
            'image',
            file.readAsBytes().asStream(),
            await file.length(),
            filename: savingRequestModel.image!.path.split('/').last,
          ),
        );
      } else {
        throw Exception(
            "File tidak ditemukan di path: ${savingRequestModel.image!.path}");
      }
    } else {
      debugPrint("Tidak ada file untuk diunggah");
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return Right(SuccessResponseModel.fromRawJson(body));
    } else {
      return Left(ErrorResponseModel.fromJson(body));
    }
  }

  Future<Either<ErrorResponseModel, SuccessResponseModel>> updateAmountSaving({
    required int id,
    required int amount,
  }) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/savings/$id/add"),
      body: {
        "amount": "$amount",
      },
      headers: {
        "Authorization": "Bearer ${authData.data?.token ?? "-"}",
      },
    );

    if (response.statusCode == 200) {
      return Right(SuccessResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, SuccessResponseModel>> withdrawSaving({
    required int id,
  }) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/savings/$id/withdraw"),
      headers: {
        "Authorization": "Bearer ${authData.data?.token ?? "-"}",
      },
    );

    if (response.statusCode == 200) {
      return Right(SuccessResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromJson(response.body));
    }
  }
}
