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

  var isFilterData=false.obs;
  RxList selectedFilterTypeData=[].obs;
  RxMap<String, List<String>> selectedFilterTypeDataId = <String, List<String>>{}.obs;


  @override
  void onInit() {
    // TODO: implement onInit
     Map<String,dynamic> data=Get.arguments??{};
     if(data.isNotEmpty){
       screenNameData.value=data[screenName]??"";
       isFilterData.value=data[isFilter]??false;
       if(isFilterData.value){
         selectedFilterTypeData.assignAll(data[selectedFilterTypeDataKey]);
         selectedFilterTypeDataId.assignAll(data[selectedFilterTypeId]);
         Future.delayed(Duration(milliseconds: 500), ()async {
           applyFilterDataApiCall();
         });

       }
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
    Get.offNamed(AppRoutes.allFilter,arguments: {screenName:searchScreen});
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
    const duration = Duration(milliseconds: 50);
    debouncer.debounce(
      duration: duration,
      onDebounce: () async {
        try {
          //keyboardDismiss(context);
          //progressDialog.show();
          SearchDataListModel searchDataListModel = await ApiProvider.baseWithToken().globalSearch(searchKeyword: searchKeyWord, searchType: searchTypeKey.value,);
          if(searchDataListModel.status==true){
            searchDataList.value=searchDataListModel;
            keyboardDismiss(context);
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
        Future.delayed(Duration(milliseconds: 50), ()async {
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

  ///Filtered Api call
  void applyFilterDataApiCall() async{
    Map<String, dynamic> dynamicFilters = {};

    for (String filter in selectedFilterTypeData) {
      if (selectedFilterTypeDataId.containsKey(filter)) {
        // Convert list to comma-separated string (e.g., "4,19")
        dynamicFilters[filter.toLowerCase()] = selectedFilterTypeDataId[filter]!.join(',');
      }
    }


    try {
      progressDialog.show();
      SearchDataListModel recommendedJobForYouModel = await ApiProvider.baseWithToken().filteredSearchData(
        company: dynamicFilters.containsKey("company") ? int.tryParse(dynamicFilters["company"]!.split(',')[0]) : null,
        industry: dynamicFilters.containsKey("industry") ? int.tryParse(dynamicFilters["industry"]!.split(',')[0]) : null,
        department: dynamicFilters.containsKey("department") ? int.tryParse(dynamicFilters["department"]!.split(',')[0]) : null,
        city: dynamicFilters.containsKey("city") ? int.tryParse(dynamicFilters["city"]!.split(',')[0]) : null,
        state: dynamicFilters.containsKey("state") ? int.tryParse(dynamicFilters["state"]!.split(',')[0]) : null,
        country: dynamicFilters.containsKey("country") ? int.tryParse(dynamicFilters["country"]!.split(',')[0]) : null,
        skill: dynamicFilters.containsKey("skill") ? int.tryParse(dynamicFilters["skill"]!.split(',')[0]) : null,
        designation: dynamicFilters.containsKey("designation") ? int.tryParse(dynamicFilters["designation"]!.split(',')[0]) : null,
        experience: dynamicFilters.containsKey("experience") ? int.tryParse(dynamicFilters["experience"]!.split(',')[0]) : null,
        jobMode: dynamicFilters.containsKey("mode") ? int.tryParse(dynamicFilters["mode"]!.split(',')[0]) : null,
        roleType: dynamicFilters.containsKey("role") ? int.tryParse(dynamicFilters["role"]!.split(',')[0]) : null,
        salary: dynamicFilters.containsKey("salary") ? int.tryParse(dynamicFilters["salary"]!.split(',')[0]) : null,
        urgent: dynamicFilters.containsKey("urgent") ? int.tryParse(dynamicFilters["urgent"]!.split(',')[0]) : null,
        vacancy: dynamicFilters.containsKey("vacancy") ? int.tryParse(dynamicFilters["vacancy"]!.split(',')[0]) : null,
        postedDate: dynamicFilters.containsKey("posted_date") ? int.tryParse(dynamicFilters["posted_date"]!.split(',')[0]) : null,

      );
      if(recommendedJobForYouModel.status==true){
        searchDataList.value=recommendedJobForYouModel;
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