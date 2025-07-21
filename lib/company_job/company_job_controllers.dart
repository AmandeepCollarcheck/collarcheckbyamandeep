import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/company_all_details_data.dart';
import '../models/company_job_data_list_model.dart';
import '../models/employee_list_model.dart';
import '../models/employment_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class CompanyJobControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var searchController = TextEditingController();
  var designationListData=CompanyAllDetailsData().obs;
  var jobData=CompanyJobListModel().obs;
  Rx isSearchActive=false.obs;
  var isEditData=false.obs;
  var isEditIdData="".obs;
  Rx screenNameData="".obs;
  var selectedTabIndex=0.obs;
  var openCount="".obs;
  var draftCount="".obs;
  var completedCount="".obs;
  var listTabLabel = [
    appOpen,appDraft,appCompleted
  ].obs;
  var listTabCounter=["0","0","0"].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: 3, vsync: this);
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
      Future.delayed(Duration(milliseconds: 500), ()async {
        getDesignationApiCall();
      });

      // Future.delayed(Duration(milliseconds: 500), ()async {
      //   _editEmploymentHistoryModel();
      // });

    }else{
      Future.delayed(Duration(milliseconds: 500), ()async {
        getDesignationApiCall();
      });
      Future.delayed(Duration(milliseconds: 500), ()async {
        getJobListApiCall();
      });
    }


    // Future.delayed(Duration(milliseconds: 500), ()async {
    //   getEmploymentHistoryApiCall();
    // });
    super.onInit();
  }


  openSearchScreen(context){
    Get.offNamed(AppRoutes.search,arguments: {screenName:companyEmployeesScreen});
  }

  void getDesignationApiCall() async{
    try {
      progressDialog.show();
      CompanyAllDetailsData designationListModel = await ApiProvider.baseWithToken().companyAllData();
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

  ///Job List api
  getJobListApiCall() async{
    try {
      progressDialog.show();
      CompanyJobListModel companyJobListModel = await ApiProvider.baseWithToken().companyJobListData();
      if(companyJobListModel.status==true){
        jobData.value=companyJobListModel;
        openCount.value=jobData.value.data!.publishJobs?.length.toString()??"0";
        draftCount.value=jobData.value.data!.draftJobs?.length.toString()??"0";
        completedCount.value=jobData.value.data!.cancelJobs?.length.toString()??"0";
        listTabCounter.clear();
        listTabCounter.add(openCount.value);
        listTabCounter.add(draftCount.value);
        listTabCounter.add(completedCount.value);
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
  /// Mark as completed
  void markAsCompleteApiCall(context,{required String statusId})async {
    try {

      keyboardDismiss(context);
      progressDialog.show();
      SaveUserProfileModel addEmployment = await ApiProvider.baseWithToken().markAsCompleteApi(statusId: statusId);
      if(addEmployment.status==true){
        if (progressDialog.isShowing()) {
          Get.back();
        }
        Future.delayed(Duration(milliseconds: 500), ()async {
          getJobListApiCall();
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
}