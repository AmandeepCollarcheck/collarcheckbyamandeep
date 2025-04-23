import 'dart:io';

import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api_provider/api_provider.dart';
import '../../models/company_all_review_model.dart';
import '../../models/company_user_specific_review_model.dart';
import '../../utills/app_key_constent.dart';
import '../../utills/app_route.dart';
import '../../utills/common_widget/progress.dart';

class UserSpecificReviewControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var companyAllReviewData=CompanyUserSpecificReviewModel().obs;
  var screenNameData="".obs;
  var userName="".obs;
  var selectedTabIndex=0.obs;
  var userIdData="0".obs;
  var listTabCounter=["0","0","0"].obs;
  var listTabLabel = [
    appReviews,appPendingReviews,appApprovedReviews
  ].obs;

  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      userName.value=data[jobProfileName]??"";
      userIdData.value=data[userId]??"0";
    }
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllReviewApiCall();
    });
  }
  void onTabSelected(int index) {
    selectedTabIndex.value = index;
  }


  backButtonClick(context){
    if(screenNameData.value==companyAllReviewScreen){
      Get.offNamed(AppRoutes.companyAllReview);
    }
  }




  void getAllReviewApiCall() async{
    try {
      progressDialog.show();
      CompanyUserSpecificReviewModel companyAllReviewModel = await ApiProvider.baseWithToken().companyUserSpecificAllReview(userIdData.value);
      if(companyAllReviewModel.status==true){
        companyAllReviewData.value=companyAllReviewModel;
        var allReviews=companyAllReviewData.value.data!.allcount.toString();
        var pendingReviews=companyAllReviewData.value.data!.pendingCount.toString();
        var approvedReviews=companyAllReviewData.value.data!.activeCount.toString();
        listTabCounter.clear();
        listTabCounter.add(allReviews);
        listTabCounter.add(pendingReviews);
        listTabCounter.add(approvedReviews);

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