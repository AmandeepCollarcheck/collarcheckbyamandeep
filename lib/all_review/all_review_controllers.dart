import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/company_all_review_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/progress.dart';

class AllReviewControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var companyAllReviewData=CompanyAllReviewModel().obs;
  var screenNameData="".obs;

  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){

      screenNameData.value=data[screenName]??"";
    }
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllReviewApiCall();
    });
  }



  backButtonClick(context){
    if(screenNameData.value==companyEmployeesScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
    }else if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }
  }




  void getAllReviewApiCall() async{
    try {
      progressDialog.show();
      CompanyAllReviewModel companyAllReviewModel = await ApiProvider.baseWithToken().companyAllReview();
      if(companyAllReviewModel.status==true){
        companyAllReviewData.value=companyAllReviewModel;

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