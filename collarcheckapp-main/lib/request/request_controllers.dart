import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/follow_request_data_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class RequestControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var followDataList=FollowRequestDataModel().obs;
  var screenNameData="".obs;
  var tabIndex=0.obs;
  @override
  void onInit() {
    super.onInit();
     Map<String,dynamic> data=Get.arguments??{};
     if(data.isNotEmpty){
       screenNameData.value=data[screenName]??"";
       tabIndex.value=data[tabSelectionIndexValue]??0;
     }
    tabController = TabController(length: 2, vsync: this);
     _tabController();
    Future.delayed(Duration(milliseconds: 500), ()async {
      getFollowRequestDataListApiCall();
    });
  }
  var listTabLabel = [
    appFollowRequest,appSalaryRequest
  ].obs;


  backButtonClick(context){
    if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }
  }

  void getFollowRequestDataListApiCall()async {
    try {
      progressDialog.show();
      FollowRequestDataModel followRequestDataModel = await ApiProvider.baseWithToken().followRequestListData();
      if(followRequestDataModel.status==true){
        followDataList.value=followRequestDataModel;

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

  acceptFollowRequest(context,{required String id})async{
    try {
      progressDialog.show();

      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().acceptFollowRequest( id: id??"");
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        showToast(addSkillsData.messages??"");
        Future.delayed(Duration(milliseconds: 500), ()async {
          getFollowRequestDataListApiCall();
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
  }

  rejectFollowRequest(context,{required String id})async{
    try {
      progressDialog.show();

      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().rejectFollowRequest( id: id??"");
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        showToast(addSkillsData.messages??"");
        Future.delayed(Duration(milliseconds: 500), ()async {
          getFollowRequestDataListApiCall();
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
  }

   _tabController() {
    tabController.index=tabIndex.value;
    update();
   }


}