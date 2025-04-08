import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/employee_list_model.dart';
import '../models/employment_list_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class CompanyEmploymentRequestControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var searchController = TextEditingController();
  var designationListData=DesignationListModel().obs;
  var employeeData=EmployeeListModel().obs;
  Rx isSearchActive=false.obs;
  var isEditData=false.obs;
  var isEditIdData="".obs;
  Rx screenNameData="".obs;
  var selectedTabIndex=0.obs;
  var currentCount="".obs;
  var pastCount="".obs;
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
        getEmployeeDataListApiCall();
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
        currentCount.value=employeeData.value.data!.currentCount.toString();
        pastCount.value=employeeData.value.data!.pastCount.toString();
        listTabCounter.clear();
        listTabCounter.add(currentCount.value);
        listTabCounter.add(pastCount.value);
        listTabCounter.add(pastCount.value);
        listTabCounter.add(pastCount.value);
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