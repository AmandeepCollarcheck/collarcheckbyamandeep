import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/filter_data_list_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class FilterController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late ProgressDialog progressDialog = ProgressDialog();
  var searchController = TextEditingController();
  var filterDataListModel = FilterDataListModel().obs;
  RxList selectedFilterType=[].obs;
  //RxList selectedFilterTypeItemId=[].obs;
  RxMap<String, List<String>> selectedFilterTypeItemId = <String, List<String>>{}.obs;



  var listTabLabel = [
    appSelectCompany, appSelectIndustry, appSelectDepartment
  ].obs;

  var selectCompanyListOption = <Map<String, List<Map<String, String>>>>[].obs;






  var filterTypeLabel = [
    "Select Company", "Select Industry", "Select Department"
  ].obs;

  var isSelectedFilterOption = <String, RxList<bool>>{}.obs;
  var screenNameData="".obs;
  var selectedTabIndex=0.obs;
  Rx isJobForYou=false.obs;
  var isArgumentedData="".obs;
  var screenTypeData="".obs;

  @override
  void onInit() {
    Map<String, dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      isJobForYou.value=data[isJobForYouData]??false;
      isArgumentedData.value=data[argumentTypeData]??"";
      screenTypeData.value=data[topCompanyScreenType]??"";
    }
    super.onInit();

    // Initializing the TabController here to prevent late initialization error
    tabController = TabController(length: 1, vsync: this);


    // Delay fetching data to simulate async operations
    Future.delayed(Duration(milliseconds: 500), () async {
      await getFilterDataListApi();
    });
  }

  @override
  void onClose() {
    // Dispose TabController to avoid memory leaks
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void clickFilterClose() {
    if(screenNameData.value==recommendedScreen){
      Get.offNamed(AppRoutes.recommendJob);
    }

  }

  // Fetch filter data from API
  getFilterDataListApi() async {
    try {
      progressDialog.show();
      FilterDataListModel filterData = await ApiProvider.baseWithToken().allFilterDataList();

      if (filterData.status == true) {
        filterDataListModel.value = filterData;

        // Proceed to update the UI based on API response
        if (filterDataListModel.value.data != null) {
          filterTypeLabel.clear();
          listTabLabel.clear();
          selectCompanyListOption.clear();
          Map<String, List<Map<String, String>>> filterDataMap = {};

          void processFilterList(String label,List<dynamic>? dataList) {
            if (dataList != null && dataList.isNotEmpty) {
              filterTypeLabel.add(label);
              listTabLabel.add(label);

              var result = dataList.map((data) {
                return {
                  label: [
                    {
                      'id': data.id?.toString() ?? '',
                      'name': data.name?.toString() ?? 'Unknown'
                    }
                  ]
                };
              }).toList();

              selectCompanyListOption.addAll(result);
            }
          }

          processFilterList(appSelectCompany, filterDataListModel.value.data!.companyList);
          processFilterList(appSelectIndustry, filterDataListModel.value.data!.industryList);
          processFilterList(appSelectDepartment, filterDataListModel.value.data!.departmentList);
          processFilterList(appSelectSalary, filterDataListModel.value.data!.salaryList);
          processFilterList(appSelectRole, filterDataListModel.value.data!.roleTypeList);
          processFilterList(appSelectExperience, filterDataListModel.value.data!.jobExperienceList);
          processFilterList(appSelectSkill, filterDataListModel.value.data!.skillList);
          processFilterList(appSelectMode, filterDataListModel.value.data!.jobModeList);
          processFilterList(appSelectDesignation, filterDataListModel.value.data!.designationList);
          processFilterList(appSelectCountry, filterDataListModel.value.data!.countryList);

          // Only reinitialize TabController once we have valid filter data
          tabController.dispose();
          tabController = TabController(length: filterTypeLabel.length, vsync: this);
          tabController.addListener(() {
            selectedTabIndex.value = tabController.index;
          });

          for (var label in filterTypeLabel) {
            isSelectedFilterOption[label] = RxList<bool>.filled(selectCompanyListOption.length, false);
          }
          filterDataListModel.refresh();
        }
      } else {
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

  getApplyFilterData(context,{required List<String> filterType,required Map<String, List<String>> filterTypeId,}){
    if(screenNameData.value==recommendedScreen){
      Get.offNamed(
          AppRoutes.recommendJob,
          arguments: {
            selectedFilterTypeDataKey:filterType,
            selectedFilterTypeId:filterTypeId,
            isFilter:true,
            isJobForYouData:isJobForYou.value
          });
    }else if(screenNameData.value==topCompaniesScreen){
      Get.offNamed(
          AppRoutes.topCompanies,
          arguments: {
            selectedFilterTypeDataKey:filterType,
            selectedFilterTypeId:filterTypeId,
            isFilter:true,
            argumentTypeData:isArgumentedData.value,
            topCompanyScreenType:screenTypeData.value
          });
    }
  }

}

