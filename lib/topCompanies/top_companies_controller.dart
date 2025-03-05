import 'dart:io';

import 'package:collarchek/utills/app_key_constent.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/top+companies_model.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/progress.dart';

class TopCompaniesController extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var topCompaniesData=TopCompaniesModel().obs;
  @override
  void onInit() {

    Future.delayed(Duration(milliseconds: 500), ()async {
      getTopCompaniesList();
    });
    super.onInit();
  }

  backButtonClick(){
    Get.offNamed(AppRoutes.bottomNavBar);
  }

  void getTopCompaniesList() async{
    try {
      progressDialog.show();
      TopCompaniesModel topCompaniesModel = await ApiProvider.baseWithToken().topCompanies(jobType: topCompanies);
      if(topCompaniesModel.status==true){
        topCompaniesData.value=topCompaniesModel;
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