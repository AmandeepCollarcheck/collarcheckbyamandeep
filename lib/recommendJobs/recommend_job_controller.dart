import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/recommended_job_for_you_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/progress.dart';

class RecommendJobController extends GetxController{
  final RxBool isExpanded = false.obs;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var userRecommendedJobForYou=RecommendedJobForYouModel().obs;
  Rx isJobForYou=false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    final Map<String, dynamic> data = Get.arguments;
    isJobForYou.value=data['isJobForYou'];
    Future.delayed(Duration(milliseconds: 500), ()async {
      getRecommendedApiData();
    });
    super.onInit();
  }

  backButtonClick(){
    Get.offNamed(AppRoutes.bottomNavBar);
  }


  openShortItemFilter(context){
    shortedDataFilter(
      context,
      menuItem: [{'id':1,'name':"item1"},{'id':2,'name':"item2"},{'id':3,'name':"item3"},{'id':4,'name':"item4"}],
      onVoidCallBack: (Map<String, dynamic> value ) {
        ///Data received
      },
    );
  }

  clickFilterButton(){
    Get.offNamed(AppRoutes.allFilter);
  }

  openJobDetails({required String jobTitle}){
    Get.offNamed(AppRoutes.jobDetails,arguments: {'jobTitle':jobTitle});
  }

   getRecommendedApiData() async{
     try {
       progressDialog.show();
       RecommendedJobForYouModel recommendedJobForYouModel = await ApiProvider.baseWithToken().allJobs(jobType: isJobForYou.value?jobForYou:recommended);
       if(recommendedJobForYouModel.status==true){
         userRecommendedJobForYou.value=recommendedJobForYouModel;
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