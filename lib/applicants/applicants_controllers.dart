import 'dart:io';

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
  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      jobProfileNameData.value=data[jobProfileName]??"";
      isApplicationData.value=data[isAppApplication]??false;
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
        getEmployeeDataListApiCall();
      });
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
}