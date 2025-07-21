import 'dart:io';

import 'package:collarchek/utills/common_widget/image_multipart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/all_skills_list_model.dart';
import '../models/employment_list_model.dart';
import '../models/get_specific_review_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class ReviewControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var addSkillsModelData=SaveUserProfileModel().obs;
  var descriptionController =TextEditingController();
  var reviewData=GetSpecificReviewModel().obs;
  var linkController =TextEditingController();
  Rx ratingValue=0.0.obs;
  Rx skillsId="0".obs;
  var portfolioTitle="Select Portfolio".obs;
  var selectedImageFromTHeGallery="".obs;
  var selectedImageFileName="".obs;
  Rx screenNameData="".obs;
  Rx experienceIdData="".obs;
  var isEditData=false.obs;
  var reviewIdData="".obs;
  var jobProfileNameData="".obs;

  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      experienceIdData.value=data[experienceId]??"0";
      isEditData.value=data[isEdit]??false;
      reviewIdData.value=data[reviewId]??"";
      jobProfileNameData.value=data[jobProfileName]??"";
    }
    if(isEditData.value){
      _getRatingApi();
    }
    // TODO: implement onInit
    super.onInit();
  }


  backButtonClick(context){
    if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }else if(screenNameData.value==profileDetails){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }else if(screenNameData.value==companyEmployeesScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
    }else if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }else if(screenNameData.value==companyUserSpecificReviewScreen){
      Get.offNamed(AppRoutes.userSpecificReview,arguments: {jobProfileName:jobProfileNameData.value??"",screenName:companyAllReviewScreen,});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }

  }



  addReviewValidation(context){
    if ((skillsId.value == "0" || skillsId.value.isEmpty) && ratingValue.value == 0.0) {
      showToast(appPleaseSelecteValidSkills);
    } else if (descriptionController.text.isEmpty) {
      showToast(appGiveReview);
    } else {
      if(isEditData.value){
        updateReview(context);
      }else{
        addReviewApiCall(context);
      }

    }

  }



  addReviewApiCall(context)async{
    keyboardDismiss(context);
    try {
      progressDialog.show();
      var uploadedData=await convertFileToMultipart(selectedImageFromTHeGallery.value??"");
      var formData = dio.FormData.fromMap({
        "experience":experienceIdData??0,
        "rating":ratingValue??"0",
        "review":descriptionController.text??"",
        "link":linkController.text??"",
        "document[0]":uploadedData??""
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().addReview(formData);
      if(addSkillsData.status==true){
        //addSkillsModelData.value=addSkillsData;
        progressDialog.dismissLoader();
        if(screenNameData.value==companyEmployeesScreen){
          Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
        }else{
          Get.offNamed(AppRoutes.bottomNavBar);
        }


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

  void _getRatingApi()async {
    try {
      progressDialog.show();
      GetSpecificReviewModel getSpecificReviewModel = await ApiProvider.baseWithToken().getReview(id: reviewIdData.value??'');
      if(getSpecificReviewModel.status==true){
        reviewData.value=getSpecificReviewModel;
        ratingValue.value=double.parse(reviewData.value.data!.rating.toString()??"0");
        descriptionController.text=reviewData.value.data?.review??"";
        linkController.text=reviewData.value.data?.link??"";
        experienceIdData.value=reviewData.value.data?.experienceId??"0";
        if(reviewData.value.data!.doc!.isNotEmpty){
          selectedImageFromTHeGallery.value=reviewData.value.data!.doc![0];
        }

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

  void updateReview(context) async{
    keyboardDismiss(context);
    try {
      progressDialog.show();
      var uploadedData=await convertFileToMultipart(selectedImageFromTHeGallery.value??"");
      var formData = dio.FormData.fromMap({
        "experience":experienceIdData??0,
        "rating":ratingValue??"0",
        "review":descriptionController.text??"",
        "link":linkController.text??"",
        "document[0]":uploadedData??""
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().updateReview(id: reviewIdData.value);
      if(addSkillsData.status==true){
        //addSkillsModelData.value=addSkillsData;
        progressDialog.dismissLoader();
        if(screenNameData.value==companyEmployeesScreen){
          Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
        }else if(screenNameData.value==companyUserSpecificReviewScreen){
          Get.offNamed(AppRoutes.userSpecificReview);
        }else{
          Get.offNamed(AppRoutes.bottomNavBar);
        }


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