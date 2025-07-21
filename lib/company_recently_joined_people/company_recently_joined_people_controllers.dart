import 'dart:io';

import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/company_recently_joined_people.dart';
import '../utills/common_widget/progress.dart';

class CompanyRecentlyJoinedPeopleControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var recentlyJoinedData=CompanyPeopleRecentlyJoinedModel().obs;
  var screenNameData="".obs;


  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
    }
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(milliseconds: 500), ()async {
      getRecentlyJoinedPeopleApiCall();
    });
  }

  backButtonClick(context){
    if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar,);
    }
  }

  void getRecentlyJoinedPeopleApiCall()async {
    try {
      progressDialog.show();

      CompanyPeopleRecentlyJoinedModel companyPeopleRecentlyJoinedModel = await ApiProvider.baseWithToken().companyRecentlyJoinedPeople();
      if(companyPeopleRecentlyJoinedModel.status==true){
        recentlyJoinedData.value=companyPeopleRecentlyJoinedModel;

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