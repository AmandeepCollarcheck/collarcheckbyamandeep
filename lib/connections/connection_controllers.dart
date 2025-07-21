import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/connection_data_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class ConnectionControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  var searchController = TextEditingController();

  late ProgressDialog progressDialog=ProgressDialog() ;
  var connectionData=ConnectionDataListModel().obs;
  var userId="".obs;
  Rx isSearchActive=false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration(milliseconds: 500), ()async {
      userId.value=await readStorageData(key: id);
      getConnectionDataListApiCall();
    });
  }
  var listTabLabel = [
    appFollowersText,appFollowing
  ].obs;

  void getConnectionDataListApiCall() async{
    try {
      progressDialog.show();
      ConnectionDataListModel connectionDataListModel = await ApiProvider.baseWithToken().connectionListData();
      if(connectionDataListModel.status==true){
        connectionData.value=connectionDataListModel;
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

  //Follow api
  followBackApiCall(context,{required String companyId,required String userId})async{
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
  }
  openSearchScreen(context){
    Get.offNamed(AppRoutes.search,arguments: {screenName:connections});
  }


}