
import 'dart:convert';

import 'package:collarchek/models/company_signUp_model.dart';
import 'package:collarchek/models/individual_signup_model.dart';
import 'package:collarchek/models/user_profile_model.dart';
import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;

import '../models/all_drop_down_list_model.dart';
import '../models/city_list_model.dart';
import '../models/country_list_model.dart';
import '../models/employee_user_details_model.dart';
import '../models/job_details_model.dart';
import '../models/logout_model.dart';
import '../models/recommended_job_for_you_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/send_otp_model.dart';
import '../models/state_list_model.dart';
import '../models/top+companies_model.dart';
import '../models/user_home_model.dart';
import '../models/verify_otp_model.dart';
import 'api_constant.dart';
import 'dio_logger.dart';

class ApiProvider{

  Dio _dio = Dio();

  DioException? _dioError;

  ApiProvider.base() {
    DioLogger.initialize();
    BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrlForLogin;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      options.headers = {'Content-Type': 'application/json'};
      DioLogger.onSend(tag, options);
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError error, handler) {
      _dioError = error;
      DioLogger.onError(tag, error);
      return handler.next(error);
    }));
  }

  ApiProvider.baseWithToken() {
    DioLogger.initialize();
    BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrlForOtherAPi;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      String accessToken =  GetStorage().read(deviceAccessToken);
      options.headers = {'Content-Type': 'application/json'};
      options.headers = {'Authorization': accessToken};
      DioLogger.onSend(tag, options);
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError error, handler) {
      _dioError = error;
      DioLogger.onError(tag, error);
      return handler.next(error);
    }));
  }

  ApiProvider.baseWithMultipart() {
    DioLogger.initialize();
    BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrlForOtherAPi;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      String accessToken =  readStorageData(key: deviceAccessToken);
      options.headers = {'Content-Type': 'multipart/form-data'};
      options.headers = {'token': accessToken};
      DioLogger.onSend(tag, options);
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError error, handler) {
      _dioError = error;
      DioLogger.onError(tag, error);
      return handler.next(error);
    }));
  }

  ApiProvider.baseWithPlace() {
    DioLogger.initialize();
    BaseOptions dioOptions = BaseOptions()..baseUrl = baseUrlForOtherAPi;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      options.headers = {'Content-Type': 'application/json'};
      DioLogger.onSend(tag, options);
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      DioLogger.onSuccess(tag, response);
      return handler.next(response);
    }, onError: (DioError error, handler) {
      _dioError = error;
      DioLogger.onError(tag, error);
      return handler.next(error);
    }));
  }

  Future sendOtp(params) async {
    try {
      Response response = await _dio.post(strSendOtp, data: params );
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return SendOtp.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future verifyOtp(FormData params) async {
    try {
      Response response = await _dio.post(strVerifyOtp, data: params );
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return VerifyOtp.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future individualSignUp(params) async {
    try {
      Response response = await _dio.post(strIndividualSignUp, data: params );
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return IndividualSignupModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future companySignUp(params) async {
    try {
      Response response = await _dio.post(strCompanySignUp, data: params );
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanySignup.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future userDashboard() async {
    try {
      Response response = await _dio.get(strUserHome);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }

      return UserHomeModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }




  Future logout() async {
    try {
      Response response = await _dio.get(strLogout);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }

      return LogoutModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future allJobs({required String jobType}) async {
    try {
      Response response = await _dio.get("$strAllJobs?type=$jobType&limit=$limit&offset=$offset");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return RecommendedJobForYouModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future topCompanies({required String jobType}) async {
    try {
      Response response = await _dio.get("$strTopCompanies?type=$jobType&limit=$limit&offset=$offset");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return TopCompaniesModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future userProfile({required String userName}) async {
    try {
      Response response = await _dio.get("$strUserProfile/$userName");
      print("ksjlfhsdhfshfhskjdf");
      print(response.data);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return UserProfileModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future jobDetails({required String jobName}) async {
    try {
      Response response = await _dio.get("$strJobDetail/$jobName");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return JobDetailsModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future employeeUserDetails() async {
    try {
      Response response = await _dio.get(strEmployeeUserDetails);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EmployeeUserDetails.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future countryList() async {
    try {
      Response response = await _dio.get(strCountryList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CountryListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future stateList({required String countryName}) async {
    try {
      Response response = await _dio.get('$strStateList?state=$countryName');
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return StateListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future cityList({required String stateName}) async {
    try {
      Response response = await _dio.get('$strCityList?state=$stateName');
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CityListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future allDropDownListData() async {
    try {
      Response response = await _dio.get(strDashboardDataList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return AllDropDownListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future saveUserProfile(params) async {
    try {
      Response response = await _dio.post(strSaveProfile,data: params);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return SaveUserProfileModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future verifyEmail(params) async {
    try {
      Response response = await _dio.post(strVerifyEmail,data: params);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return SaveUserProfileModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future verifyEmailOTP(params) async {
    try {
      Response response = await _dio.post(strVerifyEmailOtp,data: params);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return SaveUserProfileModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
}