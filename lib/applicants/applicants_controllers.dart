import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
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

  var screenNameData="".obs;
  var jobProfileNameData="".obs;
  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      jobProfileNameData.value=data[jobProfileName]??"";
    }
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(milliseconds: 500), ()async {
      getEmployeeDataListApiCall();
    });
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
}