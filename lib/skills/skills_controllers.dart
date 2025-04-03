import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/all_skills_list_model.dart';
import '../models/employment_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/progress.dart';

class SkillControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var designationListData=DesignationListModel().obs;
  var allSkillsData=AllSkillsListModel().obs;
  var addSkillsModelData=SaveUserProfileModel().obs;
  Rx ratingValue=0.0.obs;
  Rx skillsId="".obs;
  var screenNameData="".obs;


  @override
  void onInit() {
    final Map<String, dynamic> data = Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
    }
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllSkills();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDesignationApiCall();
    });
    // Future.delayed(Duration(milliseconds: 500), ()async {
    //   getEmploymentHistoryApiCall();
    // });
    super.onInit();
  }


  backButtonClick(context){
    if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }else if(screenNameData.value==profileDetails){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
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

  addSkillsApiCall(context)async{
    keyboardDismiss(context);

    try {
      progressDialog.show();
      var formData = dio.FormData.fromMap({
        "skill":skillsId??"0",
        "rating":ratingValue??0.0
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().addSkills(formData);
      if(addSkillsData.status==true){
        addSkillsModelData.value=addSkillsData;
        progressDialog.dismissLoader();
        getAllSkills();

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



  void getAllSkills() async{
    try {
      progressDialog.show();
      AllSkillsListModel allSkillsListModel = await ApiProvider.baseWithToken().allSkillData();
      if(allSkillsListModel.status==true){
        allSkillsData.value=allSkillsListModel;

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


  deleteSkills(context,{required String skillId})async{
    keyboardDismiss(context);
    try {
      progressDialog.show();
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().deleteSkills(skillId);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        getAllSkills();

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