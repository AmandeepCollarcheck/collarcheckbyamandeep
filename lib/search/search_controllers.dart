import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/save_user_profile_model.dart';
import '../models/search_data_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/progress.dart';
import 'local_search/search_service.dart';

class SearchControllers extends GetxController{
  final RxBool isExpanded = false.obs;
  late ProgressDialog progressDialog=ProgressDialog() ;
  final Debouncer debouncer = Debouncer();
  var searchDataList=SearchDataListModel().obs;
  var searchController =TextEditingController();
  final SearchService searchService = SearchService();
  var  searchTypeKey="".obs;
  var screenNameData="".obs;

  @override
  void onInit() {
    // TODO: implement onInit
     Map<String,dynamic> data=Get.arguments??{};
     if(data.isNotEmpty){
       screenNameData.value=data[screenName]??"";
     }
    super.onInit();
  }

  backButtonClick(){
    if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }else if(screenNameData.value==connections){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
    }else if(screenNameData.value==jobs){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"2"});
    }else if(screenNameData.value==messages){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"3"});
    }else if(screenNameData.value==profileDetails){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }else if(screenNameData.value==companyEmployeesScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }

  }

  clickFilterButton(){
    Get.offNamed(AppRoutes.allFilter);
  }



  openJobDetails({required String jobTitle}){
    Get.offNamed(AppRoutes.jobDetails,arguments: {'jobTitle':jobTitle,screenName:searchScreen});
  }

  openJobPages(context){
    Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"2"});
  }

  openCompanyPages(context,{required String argumentType}){
    Get.offNamed(AppRoutes.topCompanies,arguments: {argumentTypeData:argumentType});
  }



  globalSearchApiCall(context,{required String searchKeyWord})async{
     searchTypeKey.value=await readStorageData(key: searchJype);
    const duration = Duration(milliseconds: 500);
    debouncer.debounce(
      duration: duration,
      onDebounce: () async {
        try {
          keyboardDismiss(context);
          progressDialog.show();
          SearchDataListModel searchDataListModel = await ApiProvider.baseWithToken().globalSearch(searchKeyword: searchKeyWord, searchType: searchTypeKey.value,);
          if(searchDataListModel.status==true){
            searchDataList.value=searchDataListModel;
            // if (searchController.text.isNotEmpty) {
            //   searchService.addSearchQuery(searchController.text.trim());
            //   searchController.clear();
            // }
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
      },
    );
  }

  openEmployeeProfileScreen(context,{required String employeeSlug}){
    Get.offNamed(AppRoutes.otherIndividualProfilePage,arguments: {slugId:employeeSlug,screenName:searchScreen,isEmployeeProfile:true});
  }

  

  ///Follow api
  companyFollowApiCall(context,{required String userId,required String searchKeyWord})async{
    try {
      progressDialog.show();
      var formData = dio.FormData.fromMap({
        "follower_id":userId??"",
        // "int-id":companyId??"0",
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().followCompany(formData);
      if(addSkillsData.status==true){
        //Get.offNamed(AppRoutes.bottomNavBar);s
        Future.delayed(Duration(milliseconds: 500), ()async {
          globalSearchApiCall(context,searchKeyWord: searchKeyWord);
        });

      }else{
        showToast(addSkillsData.messages??"");
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