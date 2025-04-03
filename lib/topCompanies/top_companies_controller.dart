import 'dart:io';

import 'package:collarchek/utills/app_key_constent.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/save_user_profile_model.dart';
import '../models/top+companies_model.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class TopCompaniesController extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var topCompaniesData=TopCompaniesModel().obs;
  var argumentType="".obs;
  ///Filtered Data
  var isFilterData=false.obs;
  RxList selectedFilterTypeData=[].obs;
  var screenHeaderName="".obs;
  RxMap<String, List<String>> selectedFilterTypeDataId = <String, List<String>>{}.obs;
  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      argumentType.value=data[argumentTypeData]??topCompanies;
      isFilterData.value=data[isFilter]??false;
      if(argumentType.value==topCompanies){
        screenHeaderName.value=appTopCompanies;
      }else{
        screenHeaderName.value=appCandidatesList;
      }
    }

    ///Filter applied
    if(isFilterData.value) {

      selectedFilterTypeData.assignAll(data[selectedFilterTypeDataKey]);
      selectedFilterTypeDataId.assignAll(data[selectedFilterTypeId]);
      Future.delayed(Duration(milliseconds: 500), () async {
        applyFilterDataApiCall();
      });
    }else{
      Future.delayed(Duration(milliseconds: 500), ()async {
        getTopCompaniesList();
      });
    }

    super.onInit();
  }

  backButtonClick(){
    Get.offNamed(AppRoutes.bottomNavBar);
  }

  void getTopCompaniesList() async{
    try {
      progressDialog.show();
      TopCompaniesModel topCompaniesModel = await ApiProvider.baseWithToken().topCompanies(jobType: argumentType.value);
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




  ///Follow api
  companyFollowApiCall(context,{required String companyId,required String userId})async{
    try {
      progressDialog.show();
      var formData = dio.FormData.fromMap({
        "follower_id":userId??"",
        "int-id":companyId??"0",
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().followCompany(formData);
      if(addSkillsData.status==true){
        //Get.offNamed(AppRoutes.bottomNavBar);s
        Future.delayed(Duration(milliseconds: 500), ()async {
          getTopCompaniesList();
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


  void shortDataList({required int value}) {
    var jobList = topCompaniesData.value.data?.userList;

    if (jobList == null || jobList.isEmpty) return; // Ensure list is not null or empty

    if (value == 1) {
      // Sort by Most Relevant (if needed)
    } else if (value == 2) {
      jobList.sort((a, b) =>
          (double.tryParse(b.salary ?? '0') ?? 0.0)
              .compareTo(double.tryParse(a.salary ?? '0') ?? 0.0)
      );
    } else if (value == 3) {
      jobList.sort((a, b) =>
          (double.tryParse(a.salary ?? '0') ?? 0.0)
              .compareTo(double.tryParse(b.salary ?? '0') ?? 0.0)
      );
    } else {
      jobList.sort((a, b) {
        DateTime dateA = parseDate(a.createDate);
        DateTime dateB = parseDate(b.createDate);
        return dateB.compareTo(dateA); // Newest first
      });
    }

    /// 🔄 Convert to List to trigger UI update
    topCompaniesData.value.data?.userList = jobList.toList();

    /// 🔄 Refresh GetX observable
    topCompaniesData.refresh();
  }

  /// ✅ Date Parsing Helper Function
  DateTime parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return DateTime(2000);
    try {
      return DateTime.parse(dateString); // Format: "2025-03-10 17:03:29"
    } catch (e) {
      return DateTime(2000); // Default fallback date
    }
  }



  clickFilterButton({required String screenType}){
    Get.offNamed(
        AppRoutes.allFilter,arguments: {
      screenName:topCompaniesScreen,
      argumentTypeData:argumentType.value,
      topCompanyScreenType:screenType
    });
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
      TopCompaniesModel recommendedJobForYouModel = await ApiProvider.baseWithToken().filteredTopCompanies(
        jobType: argumentType.value,
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
        topCompaniesData.value=recommendedJobForYouModel;
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