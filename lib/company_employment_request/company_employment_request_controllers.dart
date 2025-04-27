import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/company_all_employment_model.dart';
import '../models/company_employment_request_model.dart';
import '../models/employee_list_model.dart';
import '../models/employment_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class CompanyEmploymentRequestControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var searchController = TextEditingController();
  var designationListData=DesignationListModel().obs;
  var companyEmploymentData=CompanyAllEmploymentModel().obs;
  var companyEmploymentRequestData=CompanyEmploymentRequestModel().obs;
  var employeeData=EmployeeListModel().obs;
  Rx isSearchActive=false.obs;
  var isEditData=false.obs;
  var isEditIdData="".obs;
  Rx screenNameData="".obs;
  var selectedTabIndex=0.obs;
  var pendingRequest="".obs;
  var approvedRequest="".obs;
  var updateRequest="".obs;
  var rejectRequest="".obs;
  var listTabLabel = [
    appPending,appApproved,appUpdates,appRejected
  ].obs;
  var listTabCounter=["0","0","0","0"].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index; // Update reactive variable
    });
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      isEditData.value=data[isEdit]??false;
      isEditIdData.value=data[isEditItemId]??"";
    }

    if(isEditData.value){


    }else{
      Future.delayed(Duration(milliseconds: 500), ()async {
        getDesignationApiCall();
      });
      Future.delayed(Duration(milliseconds: 500), ()async {
        getAllEmploymentApiCall();
      });

      Future.delayed(Duration(milliseconds: 500), ()async {
        getEmploymentRequestApiCall();
      });

    }

    super.onInit();
  }

  backButtonClick(){
    if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }else if(screenNameData.value==companyEmployeesScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
    }else if(screenNameData.value==companyJobsScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"2"});
    }
  }
  openSearchScreen(context){
    Get.offNamed(AppRoutes.search,arguments: {screenName:companyEmployeesScreen});
  }

  void getDesignationApiCall() async{
    try {
      progressDialog.show();
      DesignationListModel designationListModel = await ApiProvider.baseWithToken().designationList();
      if(designationListModel.status==true){
        designationListData.value=designationListModel;

      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }

  ///Employee List api
  getEmployeeDataListApiCall() async{
    try {
      progressDialog.show();
      EmployeeListModel connectionDataListModel = await ApiProvider.baseWithToken().employeeListData();
      if(connectionDataListModel.status==true){
        employeeData.value=connectionDataListModel;

      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }

  void getAllEmploymentApiCall()async {
    try {
      progressDialog.show();
      CompanyAllEmploymentModel companyAllEmploymentModel = await ApiProvider.baseWithToken().companyAllEmployment();
      if(companyAllEmploymentModel.status==true){
        companyEmploymentData.value=companyAllEmploymentModel;
      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }

  void getEmploymentRequestApiCall()async {
    try {
      progressDialog.show();
      CompanyEmploymentRequestModel companyEmploymentRequestModel = await ApiProvider.baseWithToken().companyEmploymentRequest();
      if(companyEmploymentRequestModel.status==true){
        companyEmploymentRequestData.value=companyEmploymentRequestModel;
        pendingRequest.value=companyEmploymentRequestData.value.data!.pendingCount.toString();
        approvedRequest.value=companyEmploymentRequestData.value.data!.approvedCount.toString();
        updateRequest.value=companyEmploymentRequestData.value.data!.updateList.toString();
        rejectRequest.value=companyEmploymentRequestData.value.data!.rejectCount.toString();
        listTabCounter.clear();
        listTabCounter.add(pendingRequest.value);
        listTabCounter.add(approvedRequest.value);
        listTabCounter.add(updateRequest.value);
        listTabCounter.add(rejectRequest.value);
      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }
  acceptEmploymentApiCall(context,{required String id})async{
    try {
      progressDialog.show();
      SaveUserProfileModel acceptEmployment = await ApiProvider.baseWithToken().acceptCompanyEmployment(id: id);
      if(acceptEmployment.status==true){
        Future.delayed(Duration(milliseconds: 500), ()async {
          getEmploymentRequestApiCall();
        });
      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }

  rejectEmploymentApiCall(context,{required String id})async{
    try {
      progressDialog.show();
      SaveUserProfileModel acceptEmployment = await ApiProvider.baseWithToken().rejectCompanyEmployment(id: id);
      if(acceptEmployment.status==true){
        Future.delayed(Duration(milliseconds: 500), ()async {
          getEmploymentRequestApiCall();
        });
      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }
   leftCompanyApiCall(context,{required String id}){

   }
}