
import 'dart:convert';

import 'package:collarchek/models/company_signUp_model.dart';
import 'package:collarchek/models/individual_signup_model.dart';
import 'package:collarchek/models/user_profile_model.dart';
import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;

import '../models/all_drop_down_list_model.dart';
import '../models/all_language_list_data_model.dart';
import '../models/all_language_list_model.dart';
import '../models/all_message_data_list_model.dart';
import '../models/all_skills_list_model.dart';
import '../models/applied_job_data_model.dart';
import '../models/benefit_data_list_model.dart';
import '../models/certificates_data_list_model.dart';
import '../models/city_list_model.dart';
import '../models/company_all_details_data.dart';
import '../models/company_all_employment_model.dart';
import '../models/company_all_review_model.dart';
import '../models/company_benefit_model.dart';
import '../models/company_job_data_list_model.dart';
import '../models/company_profile_details_model.dart';
import '../models/company_user_details_model.dart';
import '../models/company_user_specific_review_model.dart';
import '../models/connection_data_list_model.dart';
import '../models/country_list_model.dart';
import '../models/dashboard_statics_model.dart';
import '../models/edit_certificates_model.dart';
import '../models/edit_education_data_model.dart';
import '../models/edit_employment_history_model.dart';
import '../models/edit_portfolio_data_model.dart';
import '../models/education_details_model.dart';
import '../models/education_list_model.dart';
import '../models/employee_list_model.dart';
import '../models/employee_user_details_model.dart';
import '../models/employeement_history_model.dart';
import '../models/employment_history_list_model.dart';
import '../models/employment_list_model.dart';
import '../models/filter_data_list_model.dart';
import '../models/follow_request_data_model.dart';
import '../models/job_details_model.dart';
import '../models/language_list_model.dart';
import '../models/logout_model.dart';
import '../models/notification_model.dart';
import '../models/portifolio_list_model.dart';
import '../models/recommended_job_for_you_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/search_data_model.dart';
import '../models/send_otp_model.dart';
import '../models/social_login_model.dart';
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
      Response response = await _dio.get('$strStateList?country=$countryName');
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
  Future saveUserProfile(FormData params) async {
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



  Future employmentHistory() async {
    try {
      Response response = await _dio.get(strEmployeeMantHistory);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EmploymentHistoryModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future designationList() async {
    try {
      Response response = await _dio.get(strDesignationList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return DesignationListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }



  Future addEmployment(FormData params) async {
    try {

      Response response = await _dio.post(strAddEmployment,data: params);
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
  Future updateEmployment(FormData params,String id) async {
    try {
      Response response = await _dio.post("$strAddEmployment/$id",data: params);
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


  Future addSkills(params) async {
    try {
      Response response = await _dio.post(strEmployeeAddSkills, data: params );
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


  Future allSkillData() async {
    try {
      Response response = await _dio.get(strAllSkills);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return AllSkillsListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future deleteSkills(params) async {
    try {
      Response response = await _dio.delete("$strDeleteSkills/$params", );
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

  Future allLanguageData() async {
    try {
      Response response = await _dio.get(strAllLanguage);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return AlLanguageListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future addLanguage(params) async {
    try {
      Response response = await _dio.post(strAddLanguage, data: params );
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

  Future deleteLanguage(params) async {
    try {
      Response response = await _dio.delete("$strDeleteLanguage/$params", );
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

  Future addPortfolio(params) async {
    try {
      Response response = await _dio.post(strAddPortfolio, data: params );
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

  Future educationDetails() async {
    try {
      Response response = await _dio.get(strEducationDetails);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EducationListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future addEducation(FormData params) async {
    try {
      Response response = await _dio.post(strAddEducation,data: params);
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

  Future addCertificates(FormData params) async {
    try {
      Response response = await _dio.post(strEmployeeAddCertificates,data: params);
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
  Future updateCertificates(FormData params,String id) async {
    try {
      Response response = await _dio.post("$strEmployeeAddCertificates/$id",data: params);
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
  Future addReview(params) async {
    try {
      Response response = await _dio.post(strAddReview, data: params );
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


  Future appliedJobs() async {
    try {
      Response response = await _dio.get("$strAppliedJobs?limit=$limit&offset=$offset");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return AppliedJobDataModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future allEmploymentHistoryList() async {
    try {
      Response response = await _dio.get(strEmployeeHistorylist);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EmploymentHistoryListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future allPortifolioData() async {
    try {
      Response response = await _dio.get(strPortfolioList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return PortfolioListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future EdirPortifolioData({required String id}) async {
    try {
      Response response = await _dio.get("$strEditPortfolioData/$id");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EditPortfolioDataModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future updatePortfolio(params,{required String id}) async {
    try {
      Response response = await _dio.post("$strUpdatePortfolioData/$id", data: params );
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

  Future allEducationData() async {
    try {
      Response response = await _dio.get(strAllEducation);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EducationListDataModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future editEducationData({required String id}) async {
    try {
      Response response = await _dio.get("$strEditEducation/$id");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EditEducationDataModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future allLanguageDetails() async {
    try {
      Response response = await _dio.get(strALlLanguage);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return LanguageListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future allLanguageDataList() async {
    try {
      Response response = await _dio.get(strALlLanguageDataList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return AllLanguageListDataModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future allCertificatesDataList() async {
    try {
      Response response = await _dio.get(strALlCertificatesList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CertificateListDataModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future deleteCertificates(params) async {
    try {
      Response response = await _dio.delete("$strDeleteCertificates/$params", );
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

  Future applyJob(params) async {
    try {
      Response response = await _dio.post(strEmployeeApplyJob, data: params );
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


  Future followCompany(FormData params) async {
    try {
      Response response = await _dio.post(strFollowCompany, data: params );
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      print(jsonData);
      return SaveUserProfileModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future updateEducation(params,{required String id}) async {
    try {
      Response response = await _dio.post("$strEditEducationData/$id", data: params );
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


  Future allFilterDataList() async {
    try {
      Response response = await _dio.get(strFilterDataList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return FilterDataListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future allMessageListData() async {
    try {
      Response response = await _dio.get(strAllMessageList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return AllMessageDataListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future sendMessage(FormData params) async {
    try {
      Response response = await _dio.post(strSendMessage, data: params );
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

  Future followRequestListData() async {
    try {
      Response response = await _dio.get(strFollowRequest);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return FollowRequestDataModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future acceptFollowRequest({required String id}) async {
    try {
      Response response = await _dio.put("$strFollowAccept/$id", );
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

  Future connectionListData() async {
    try {
      Response response = await _dio.get(strConnectionList);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return ConnectionDataListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }



  Future globalSearch({required String searchKeyword,required String searchType}) async {
    try {
      Response response = await _dio.get("$strGlobalSearch?$keyword=$searchKeyword");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }

      return SearchDataListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future notificationData() async {
    try {
      Response response = await _dio.get(strNotificationData);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }

      return NotificationListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }



  Future filteredAllJobs({
    required String jobType,
    int limit = limit,
    int offset = offset,
    int? department,
    int? city,
    int? state,
    int? country,
    int? skill,
    String? keyword,
    int? company,
    int? designation,
    int? experience,
    int? jobMode,
    int? roleType,
    int? industry,
    int? salary,
    int? urgent,
    int? vacancy,
    int? postedDate,
  }) async {

    try {
      Map<String, dynamic> queryParams = {
        'limit': limit.toString(),
        'offset': offset.toString(),
        'type': jobType.toString(),
        if (department != null) 'department': department.toString(),
        if (city != null) 'city': city.toString(),
        if (state != null) 'state': state.toString(),
        if (country != null) 'country': country.toString(),
        if (skill != null) 'skill': skill.toString(),
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword.toString(),
        if (company != null) 'company': company.toString(),
        if (designation != null) 'designation': designation.toString(),
        if (experience != null) 'experience': experience.toString(),
        if (jobMode != null) 'job_mode': jobMode.toString(),
        if (roleType != null) 'role_type': roleType.toString(),
        if (industry != null) 'industry': industry.toString(),
        if (salary != null) 'salary': salary.toString(),
        if (urgent != null) 'urgent': urgent.toString(),
        if (vacancy != null) 'vacancy': vacancy.toString(),
        if (postedDate != null) 'posted_date': postedDate.toString(),
      };
      queryParams.removeWhere((key, value) => value == null);
      String queryString = Uri(queryParameters: queryParams).query;
      Response response = await _dio.get("$strAllJobs?$queryString");
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


  Future filteredTopCompanies({
    required String jobType,
    int limit = limit,
    int offset = offset,
    int? department,
    int? city,
    int? state,
    int? country,
    int? skill,
    String? keyword,
    int? company,
    int? designation,
    int? experience,
    int? jobMode,
    int? roleType,
    int? industry,
    int? salary,
    int? urgent,
    int? vacancy,
    int? postedDate,
  }) async {

    try {
      Map<String, dynamic> queryParams = {
        'limit': limit.toString(),
        'offset': offset.toString(),
        'type': jobType.toString(),
        if (department != null) 'department': department.toString(),
        if (city != null) 'city': city.toString(),
        if (state != null) 'state': state.toString(),
        if (country != null) 'country': country.toString(),
        if (skill != null) 'skill': skill.toString(),
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword.toString(),
        if (company != null) 'company': company.toString(),
        if (designation != null) 'designation': designation.toString(),
        if (experience != null) 'experience': experience.toString(),
        if (jobMode != null) 'job_mode': jobMode.toString(),
        if (roleType != null) 'role_type': roleType.toString(),
        if (industry != null) 'industry': industry.toString(),
        if (salary != null) 'salary': salary.toString(),
        if (urgent != null) 'urgent': urgent.toString(),
        if (vacancy != null) 'vacancy': vacancy.toString(),
        if (postedDate != null) 'posted_date': postedDate.toString(),
      };
      queryParams.removeWhere((key, value) => value == null);
      String queryString = Uri(queryParameters: queryParams).query;
      Response response = await _dio.get("$strTopCompanies?$queryString");
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


  Future rejectFollowRequest({required String id}) async {
    try {
      Response response = await _dio.delete("$strFollowReject/$id", );
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


  Future socialLoginApi(FormData params) async {
    try {
      Response response = await _dio.post(strSocailLogin,data: params);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return SocailLoginModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future certificateEdit({required String id}) async {
    try {
      Response response = await _dio.get("$strEditCertificate/$id",);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EditCertificateModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future employmentHistoryEditList({required String id}) async {
    try {
      Response response = await _dio.get("$strEditEmployment/$id");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EditEmploymentHistoryModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  ///Company Side Apis
  Future addCompanyEmployment(FormData params) async {
    try {

      print("njhhhj>>");
      print(params.fields);

      Response response = await _dio.post(strCompanyAddEmployment,data: params);
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
  Future addJob(params) async {
    try {
      print(params);
      Response response = await _dio.post(strCompanyAddJob,data: params);
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

  Future employeeListData() async {
    try {
      Response response = await _dio.get(strCompanyAllEmployee);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return EmployeeListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future companyJobListData() async {
    try {
      Response response = await _dio.get(strCompanyJobData);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanyJobListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }



  Future companyAllData() async {
    try {
      Response response = await _dio.get(strCompanyAllData);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanyAllDetailsData.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future companyUserDetails() async {
    try {
      Response response = await _dio.get(strCompanyUserDetails);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }

      return CompanyUserDetailsModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future companyDashboardStatics() async {
    try {
      Response response = await _dio.get(strCompanyStaticsDetails);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }

      return DashboardStaticsDetailsModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future companyUpdateProfile(FormData params) async {
    try {
      print(">>>>>>>>>>>>>>>>>>>>>>");
      print(params.fields);
      Response response = await _dio.post(strCompanyProfileUpdate,data: params);
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
  Future companyProfile({required String userName}) async {
    try {
      Response response = await _dio.get("$strCompanyProfile/$userName");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanyProfileDetailsModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future addBenefits(params) async {
    try {
      Response response = await _dio.post(strAddBenefits, data: params );
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

  Future allBenefitData() async {
    try {
      Response response = await _dio.get(strGetBenefits);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return BenefitDataListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

  Future benefitData() async {
    try {
      Response response = await _dio.get(strCompanyBenefits);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanyBenefitListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }


  Future deleteBenefits(params) async {
    try {
      Response response = await _dio.delete("$strCompanyDeleteBenefits/$params", );
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

  Future companyGalleryData() async {
    try {
      Response response = await _dio.get(strCompanyGallery);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanyBenefitListModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future addGalleryImage(FormData params) async {
    try {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(params.fields);
      Response response = await _dio.post(strAddGallery, data: params );
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

  Future deleteGalleryImage(params) async {
    try {
      Response response = await _dio.delete("$strDeleteGalleryImage/$params", );
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
  Future companyAllReview() async {
    try {
      Response response = await _dio.get(strCompanyAllReview);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanyAllReviewModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future companyUserSpecificAllReview(userId) async {
    try {
      Response response = await _dio.get("$strCompanyUserAllReview?user_id=$userId");
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanyUserSpecificReviewModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  Future companyAllEmployment() async {
    try {
      Response response = await _dio.get(strCompanyAllEmployment);
      Map<String, dynamic> jsonData;
      if (response.data is String) {
        jsonData = jsonDecode(response.data);
      } else {
        jsonData = response.data;
      }
      return CompanyAllEmploymentModel.fromJson(jsonData);
    }catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }










}