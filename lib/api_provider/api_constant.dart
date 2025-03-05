import 'dart:io';

import 'package:dio/dio.dart';

String tag = 'api_provider';
final baseUrlForLogin = 'https://api.collarcheck.com/wapi/';
final baseUrlForOtherAPi = 'https://api.collarcheck.com/mapi/';
final basePlaceUrl = 'https://maps.googleapis.com/maps/api/';

final String strSendOtp = 'login/sendOtp';
final String strVerifyOtp = 'login/verifyOtp';
final String strIndividualSignUp = 'employee/register';
final String strCompanySignUp = 'company/register';
final String strUserHome = 'user/home';
final String strLogout = 'logout';
final String strAllJobs = 'user/all-job';
final String strTopCompanies = '/general/globalSearch';
final String strUserProfile = '/auth/user-profile';
final String strJobDetail = '/job-detail';
final String strEmployeeUserDetails = '/employee/user-detail';
final String strCountryList = '/general/countryList';
final String strStateList = '/general/state';
final String strCityList = '/general/city';
final String strDashboardDataList = '/dashboard/dataList';
final String strSaveProfile = '/employee/edit-user';
final String strVerifyEmail = '/user/sendEmailOtp';
final String strVerifyEmailOtp = '/user/verifyEmailOtp';







handleException(error,stacktrace,DioError dioError){
  if (dioError.response!.statusCode == 401) {
    throwIfNoSuccess("unauthorized");
  } else if (dioError.response!.statusCode == 500) {
    if (dioError.response!.data == null) {
      throwIfNoSuccess("server_error");
    } else {
      throwIfNoSuccess(dioError.response!.data['message']);
    }
  } else {
    if (dioError.response!.data == null) {
      throwIfNoSuccess("something_went_wrong");
    } else {
      throwIfNoSuccess(dioError.response!.data['message']);
    }
  }
}

void throwIfNoSuccess(String response) {
  throw HttpException(response);
}