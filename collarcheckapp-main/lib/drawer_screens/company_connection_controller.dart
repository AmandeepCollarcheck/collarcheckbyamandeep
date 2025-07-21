import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/company_all_employment_model.dart';
import '../models/company_connection_model/comany_connection_model.dart';
import '../models/employee_list_model.dart';
import '../models/employment_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class CompanyConnectionControllers extends GetxController with GetTickerProviderStateMixin{
  var companyEmploymentData=CompanyAllEmploymentModel().obs;
 var connectionData= ConnectionListModel().obs;
  var listTabLabel = [
    appFollowersText,appFollowing
  ].obs;

   late final TabController tabController;

 var followerList = <FollowerList>[].obs;
 var followingList = <FollowingList>[].obs;
  late ProgressDialog progressDialog=ProgressDialog() ;
 var userId="".obs;
 var searchController = TextEditingController();
 Rx isSearchActive=false.obs;
 var designationListData=DesignationListModel().obs;
 var employeeData=EmployeeListModel().obs;
 var currentCount="".obs;
 var pastCount="".obs;
 var listTabCounter=["0","0"].obs;


  @override
  void onInit() {
    // TODO: implement onInit

    tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration(milliseconds: 500), ()async {

      userId.value=await readStorageData(key: id);
      getConnectionDataListApiCall();

    });



    super.onInit();
  }


 openSearchScreen(context){
   Get.offNamed(AppRoutes.search,arguments: {screenName:companyEmployeesScreen});
 }


 void getConnectionDataListApiCall() async{
    try {
      progressDialog.show();

      ConnectionListModel connectionDataListModel = await ApiProvider.baseWithToken().drawerCompanyconnectionListData();
      if(connectionDataListModel.status==true){




        followerList.assignAll(connectionDataListModel.data!.followerList ?? []);
        followingList.assignAll(connectionDataListModel.data!.followingList ?? []);
print("$followerList follower list data");
print("$followingList followingList list data");
        await writeStorageData(key: searchJype, value: "employees");

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

 ///Employee List api for em saerching
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

/* followBackApiCall(context,{required String companyId,required String userId})async{
   try {
     progressDialog.show();
     var formData = dio.FormData.fromMap({
       "follower_id":userId??"",
       // "int-id":companyId??"0",
     });
     SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().followCompany(formData);
     if(addSkillsData.status==true){
       //Get.offNamed(AppRoutes.bottomNavBar);s
       Future.delayed(Duration(milliseconds: 500), ()async {
         getConnectionDataListApiCall();
       });

     }else{
       showToast(addSkillsData.messages??"");
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

 rejectFollowRequest(context,{required String id})async{
   try {
     progressDialog.show();

     SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().rejectFollowRequest( id: id??"");
     if(addSkillsData.status==true){
       progressDialog.dismissLoader();
       showToast(addSkillsData.messages??"");
       Future.delayed(Duration(milliseconds: 500), ()async {
         getConnectionDataListApiCall();
       });
       // Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
     }else{
       showToast(addSkillsData.messages??"");
     }
     progressDialog.dismissLoader();
   } on HttpException catch (exception) {
     progressDialog.dismissLoader();
     showToast(exception.message);
   } catch (exception) {
     progressDialog.dismissLoader();
     showToast(exception.toString());
   }
 }*/


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

}