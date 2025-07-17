import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../api_provider/api_provider.dart';
import '../models/all_language_list_data_model.dart';
import '../models/all_language_list_model.dart';
import '../models/all_skills_list_model.dart';
import '../models/employment_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/progress.dart';

class LanguageControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var designationListData=DesignationListModel().obs;
  var allLanguageData=AlLanguageListModel().obs;
  var addSkillsModelData=SaveUserProfileModel().obs;
  var allLanguageDataList=AllLanguageListDataModel().obs;
  Rx ratingVerbalValue=0.0.obs;
  Rx ratingWrittenValue=0.0.obs;
  Rx languageId="".obs;
  Rx screenNameData="".obs;


  @override
  void onInit() {

    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
    }

    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllLanguage();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDesignationApiCall();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllLanguageDataListApiCall();
    });
    // Future.delayed(Duration(milliseconds: 500), ()async {
    //   getEmploymentHistoryApiCall();
    // });
    super.onInit();
  }

  backButtonClick(context){
    if(screenNameData.value==profileDetails){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }else if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }

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

  addLanguageApiCall(context)async{
    keyboardDismiss(context);

    try {
      progressDialog.show();
      var formData = dio.FormData.fromMap({
        "language":languageId??"0",
        "verbal":ratingVerbalValue??0.0,
        "written":ratingWrittenValue??0.0
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().addLanguage(formData);
      if(addSkillsData.status==true){
        addSkillsModelData.value=addSkillsData;
        progressDialog.dismissLoader();
        getAllLanguage();

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



  void getAllLanguage() async{
    try {
      progressDialog.show();
      AlLanguageListModel allSkillsListModel = await ApiProvider.baseWithToken().allLanguageData();
      if(allSkillsListModel.status==true){
        allLanguageData.value=allSkillsListModel;

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


  deleteLanguage(context,{required String skillId})async{
    keyboardDismiss(context);
    try {
      progressDialog.show();
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().deleteLanguage(skillId);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        getAllLanguage();

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

  void getAllLanguageDataListApiCall() async{
    try {
      progressDialog.show();
      AllLanguageListDataModel allSkillsListModel = await ApiProvider.baseWithToken().allLanguageDataList();
      if(allSkillsListModel.status==true){
        allLanguageDataList.value=allSkillsListModel;

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