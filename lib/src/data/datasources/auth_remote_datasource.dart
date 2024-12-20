import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/request/register_request_model.dart';
import '../models/response/error_response_model.dart';
import '../models/response/login_response_model.dart';
import '../models/response/register_response_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  Future<Either<ErrorResponseModel, LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/login"),
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, RegisterResponseModel>> register({
    required RegisterRequestModel bodyRequestRegister,
  }) async {
    // final Map<String, String> headers = {
    //   "Content-Type": "application/json",
    //   "Accept": "application/json",
    // };

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/user/register"),
      // headers: headers,
      body: bodyRequestRegister.toJson(),
    );

    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromJson(response.body));
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/logout"),
      headers: {
        "Authorization": "Bearer ${authData.data?.token ?? "unknown"}",
      },
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
