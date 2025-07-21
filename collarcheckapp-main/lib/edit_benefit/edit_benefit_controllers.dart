import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/benefit_data_list_model.dart';
import '../models/company_benefit_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class EditBeneFitControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var benefitData=BenefitDataListModel().obs;
  var companyBenefitData=CompanyBenefitListModel().obs;
  var screenNameData="".obs;
  Rx benefitId="".obs;

  var selectedBenefitsData={"id":"0","name":appSelectBenefits}.obs;


  @override
  void onInit() {
    final Map<String, dynamic> data = Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
    }
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getBenefitData();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getCompanyBenefitData();
    });

    super.onInit();
  }
  backButtonClick(context){
    if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }else if(screenNameData.value==companyProfileScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }else if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }

  }
  void getBenefitData() async{
    try {
      progressDialog.show();
      BenefitDataListModel benefitDataListModel = await ApiProvider.baseWithToken().allBenefitData();
      if(benefitDataListModel.status==true){
        benefitData.value=benefitDataListModel;

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


  addBenefitsApiCall(context)async{
    keyboardDismiss(context);
    try {
      progressDialog.show();
      var formData = dio.FormData.fromMap({
        "benefit_id":benefitId??"0",
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().addBenefits(formData);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        getCompanyBenefitData();

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

  void getCompanyBenefitData() async{
    try {
      progressDialog.show();
      CompanyBenefitListModel benefitDataListModel = await ApiProvider.baseWithToken().benefitData();
      if(benefitDataListModel.status==true){
        companyBenefitData.value=benefitDataListModel;

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


  deleteBenefit(context,{required String skillId})async{
    keyboardDismiss(context);
    try {
      progressDialog.show();
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().deleteBenefits(skillId);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
      Future.delayed(Duration(milliseconds: 500), ()async {
        getCompanyBenefitData();
      });

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