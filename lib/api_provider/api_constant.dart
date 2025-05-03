import 'dart:io';

import 'package:dio/dio.dart';

import '../utills/common_widget/progress.dart';

String tag = 'api_provider';
//final baseUrlForLogin = 'https://api.collarcheck.com/wapi/';
final baseUrlForLogin = 'https://admin.collarcheck.com/mapi/';
//final baseUrlForOtherAPi = 'https://api.collarcheck.com/mapi/';
final baseUrlForOtherAPi = 'https://admin.collarcheck.com/mapi/';
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
final String strEmployeeMantHistory = '/employee/allEmployementNew';
final String strDesignationList = '/dashboard/employmentList';
final String strAddEmployment = '/employee/add-employement';
final String strEmployeeAddSkills = '/employee/add-skill';
final String strAllSkills = '/employee/all-skill';
final String strDeleteSkills = '/employee/delete-skill';
final String strAddLanguage = '/employee/add_language';
final String strAllLanguage = '/employee/allLanguage';
final String strDeleteLanguage = '/employee/language';
final String strAddPortfolio = '/employee/add-portfolio';
final String strEducationDetails = '/general/educationDataList';
final String strAddEducation = '/employee/add-education';
final String strEmployeeAddCertificates = '/employee/add-certificate';
final String strAddReview = '/company/add-review';
final String strAppliedJobs = '/employee/appliedjob';
final String strEmployeeHistorylist = '/employee/allEmployementNew';
final String strPortfolioList = '/employee/all-portfolio';
final String strEditPortfolioData = '/employee/portfolio-detail';
final String strUpdatePortfolioData = '/employee/add-portfolio';
final String strAllEducation = '/employee/all-education';
final String strEditEducation = '/employee/education-detail';
final String strALlLanguage = '/employee/allLanguage';
final String strALlLanguageDataList = '/general/languageList';
final String strALlCertificatesList = '/employee/all-certificate';
final String strDeleteCertificates = '/employee/delete-certificate';
final String strEmployeeApplyJob = '/employee/apply-job';
final String strFollowCompany = '/general/follow';
final String strEditEducationData = '/employee/add-education';
final String strFilterDataList = '/dashboard/jobFilterDataList';
final String strAllMessageList = '/general/all-message';
final String strSendMessage = '/general/send-message';
final String strFollowRequest = '/company/followRequestList';
final String strFollowAccept = '/general/acceptfollow';
final String strFollowReject = '/general/rejectfollow';
final String strConnectionList = '/general/followDataList';
final String strGlobalSearch = '/general/globalSearch';
final String strNotificationData = '/general/all-notification';
final String strSocailLogin = '/login/googlelogin';
final String strEditCertificate = '/employee/certificate-detail';
final String strEditEmployment = '/employee/employement-detail';

///Company Side APis

final String strCompanyAddEmployment = '/company/addEmployee';
final String strCompanyAllEmployee = '/company/all-connection';
final String strCompanyAllData = '/dashboard/jobDataList';
final String strCompanyAddJob = '/company/add-job';
final String strCompanyJobData = '/company/all-job';
final String strCompanyUserDetails = '/company/user-detail';
final String strCompanyStaticsDetails = '/company/dashboard';
final String strCompanyProfileUpdate = '/company/edit-user';
final String strCompanyProfile = '/auth/company-profile';
final String strAddBenefits = '/company/addBenafit';
final String strGetBenefits = '/general/benefitList';
final String strCompanyBenefits = '/company/benefit';
final String strCompanyGallery= '/company/gallery';
final String strCompanyDeleteBenefits = '/company/deleteBenafit';
final String strAddGallery = '/company/addGallery';
final String strDeleteGalleryImage = '/company/deleteGallery';
final String strCompanyAllReview = '/company/reviewUniqueUsers';
final String strCompanyUserAllReview = '/company/all-review';
final String strCompanyAllEmployment = '/company/all-employement';
final String strCompanyAcceptEmployment = '/company/update-employement';
final String strCompanyRejectEmployment = '/company/rejectEmployement';
final String strCompanyAllApplications = '/company/allapplication';
final String strCompanyJobStatus = '/company/cancel-job';
final String strCompanyEmploymentRequest = '/company/employement-request';
final String strCompanyEmployee = '/recommend-employee';
final String strCompanyRecentlyJoinedPeople = '/recent-joined-employee';
final String strCompanyViewReview = '/company/view-review';
final String strCompanyUpdateReview = '/company/add-review';






handleException(error,stacktrace,DioError dioError){
  if (dioError.response!.statusCode == 401) {
    Future.delayed(Duration.zero, () {
      openLoginPageWhenTokenUnauthorize();
    });
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