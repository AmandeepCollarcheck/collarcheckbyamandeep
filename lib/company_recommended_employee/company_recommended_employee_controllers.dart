import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/company_recommended_employee_model.dart';
import '../models/dashboard_statics_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/progress.dart';

class CompanyRecommendedEmployeeControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var recommendedEmployeeData= CompanyRecommendedEmployeeModel().obs;
  var screenNameData="".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
    }
    super.onInit();
    Future.delayed(Duration(milliseconds: 500), ()async {
      getRecommendedEmployeeApiCall();
    });
  }
  backButtonClick(){
    if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }

  }

  void getRecommendedEmployeeApiCall() async{
    try {
      progressDialog.show();

      CompanyRecommendedEmployeeModel companyRecommendedEmployeeModel = await ApiProvider.baseWithToken().companyRecommendedEmployment();
      if(companyRecommendedEmployeeModel.status==true){
        recommendedEmployeeData.value=companyRecommendedEmployeeModel;

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