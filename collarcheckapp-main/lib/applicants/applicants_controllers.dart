import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_provider/api_provider.dart';
import '../models/all_application_list_model.dart';
import '../models/employee_list_model.dart';
import '../models/employment_list_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/progress.dart';

class ApplicantsControllers extends GetxController{
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var searchController = TextEditingController();
  var designationListData=DesignationListModel().obs;
  var employeeData=EmployeeListModel().obs;
  var allApplicationData=AllApplicationListModel().obs;

  var screenNameData="".obs;
  var jobProfileNameData="".obs;
  var isApplicationData=false.obs;
  var headerTitleName="".obs;
  var jobIdData="".obs;
  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      jobProfileNameData.value=data[jobProfileName]??"";
      jobIdData.value=data[jobId]??"";
      isApplicationData.value=data[isAppApplication]??false;
      screenNameData.value=data[screenName]??"";
    }
    if(isApplicationData.value){
      headerTitleName.value=appAllApplications;
    }else{
      headerTitleName.value="$appApplicationFor ${jobProfileNameData.value}";
    }
    // TODO: implement onInit
    super.onInit();
    if(isApplicationData.value){
      Future.delayed(Duration(milliseconds: 500), ()async {
        getAllApplicationListApiCall();
      });
    }else{
      Future.delayed(Duration(milliseconds: 500), ()async {
        getAllApplicationBasedOnIdListApiCall();
      });
    }

  }


  backButtonClick(){

    if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }else if(screenNameData.value==companyJobsScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"2"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }
  }



   getAllApplicationListApiCall() async{
     try {
       progressDialog.show();
       AllApplicationListModel allApplicationListModel = await ApiProvider.baseWithToken().companyAllApplications();
       if(allApplicationListModel.status==true){
         allApplicationData.value=allApplicationListModel;
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

  void getAllApplicationBasedOnIdListApiCall() async{
    try {
      progressDialog.show();
      AllApplicationListModel allApplicationListModel = await ApiProvider.baseWithToken().companyAllApplicationsBasedOnId(jobId: jobIdData.value);
      if(allApplicationListModel.status==true){
        allApplicationData.value=allApplicationListModel;
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