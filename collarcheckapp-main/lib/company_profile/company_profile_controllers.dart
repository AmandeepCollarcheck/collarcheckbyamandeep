import 'dart:io';

import 'package:collarchek/api_provider/api_constant.dart';
import 'package:collarchek/models/comapny_size_model.dart';
import 'package:collarchek/models/turn_over_list_model.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../models/company_all_details_data.dart';
import '../models/company_profile_details_model.dart';
import '../models/company_user_details_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class CompanyProfileControllers extends GetxController with GetTickerProviderStateMixin{
  late ProgressDialog progressDialog=ProgressDialog() ;


  final scrollController = ScrollController();
  var companyProfileData=CompanyProfileDetailsModel().obs;
  var designationListData=CompanyAllDetailsData().obs;
  var companyUserDetails=CompanyUserDetailsModel().obs;

  var turnOverModelDetailsList = <TurnOverListData>[].obs;
  var companySizeModelDetailsList = <CompanySizeList>[].obs;

  var selectedIndex=0.obs;
  var isExpanded=false.obs;
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey jobOpeningKey = GlobalKey();
  final GlobalKey galleryKey = GlobalKey();
  final GlobalKey companyKey = GlobalKey();
  final GlobalKey similerProfile = GlobalKey();
  final GlobalKey benifits = GlobalKey();
  var slugDataId="".obs;
  var screenNameData="".obs;
  var isEmployeeProfileDate=false.obs;
  var userIdData="".obs;

  var listTabLabel = [
    appAbout, appJobOpening, appGallery,appPerksAndBenefits
  ].obs;

  // var selectedturnover={'id':"0","name":strCompanyturnover}.obs;



  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      slugDataId.value=data[slugId]??"";
      isEmployeeProfileDate.value=data[isEmployeeProfile]??false;

    }
    scrollController.addListener(_onScroll);
    Future.delayed(Duration(milliseconds: 500), ()async {
      getCompanyProfileApiCall();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDesignationApiCall();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDashboardApiData();
    });

    Future.delayed(Duration(milliseconds: 500), ()async {
      getTurnOverDataAPI();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getCompanySizeDataAPI();
    });

    super.onInit();
  }
  ///turn over list Api
  void getTurnOverDataAPI() async {
    try {
      progressDialog.show();

      TurnOverListModel turnoverListModel = await ApiProvider.base().getTurnOverData();

      // ✅ Just check the list and assign to observable list
      if (turnoverListModel.turnOverListData != null &&
          turnoverListModel.turnOverListData!.isNotEmpty) {

        // Assign directly to your observable list
        // turnOverModelDetailsList.value = turnoverListModel.turnOverListData!;

        turnOverModelDetailsList.addAll(turnoverListModel.turnOverListData!);
        turnOverModelDetailsList.refresh();

      } else {
        showToast("noDataFound");
      }
    } on HttpException catch (exception) {
      showToast(exception.message);
    } catch (exception) {
      showToast(exception.toString());
    } finally {
      progressDialog.dismissLoader();
    }
  }
  void getCompanySizeDataAPI() async {
    try {
      progressDialog.show();

      ComanySizeModel companySizeDataList = await ApiProvider.base().getCompanySizeData();

      // ✅ Just check the list and assign to observable list
      if (companySizeDataList.companySizeList != null &&
          companySizeDataList.companySizeList!.isNotEmpty) {

        // Assign directly to your observable list
        // turnOverModelDetailsList.value = turnoverListModel.turnOverListData!;

        companySizeModelDetailsList.addAll(companySizeDataList.companySizeList!);
        companySizeModelDetailsList.refresh();

      } else {
        showToast("noDataFound");
      }
    } on HttpException catch (exception) {
      showToast(exception.message);
    } catch (exception) {
      showToast(exception.toString());
    } finally {
      progressDialog.dismissLoader();
    }
  }
  void _onScroll() {
    final contextMap = {
      0: homeKey.currentContext,
      1: jobOpeningKey.currentContext,
      2: galleryKey.currentContext,
    };

    for (int index = 0; index < contextMap.length; index++) {
      final context = contextMap[index];
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero);

        if (offset.dy <= 100 && offset.dy >= -box.size.height / 2) {
          // Change tab when the section is near the top
          if (selectedIndex.value != index) {
            selectedIndex.value = index;
          }
          break;
        }
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
  void scrollToSection(int index) {
    final context = [homeKey, jobOpeningKey, galleryKey][index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void getCompanyProfileApiCall() async{
    try {
      progressDialog.show();
      String slugData =await GetStorage().read(slug);
      CompanyProfileDetailsModel companyProfileDetailsModel = await ApiProvider.baseWithToken().companyProfile(userName: slugDataId.value.isNotEmpty?slugDataId.value:slugData);
      if(companyProfileDetailsModel.status==true){
        companyProfileData.value=companyProfileDetailsModel;
        // var profileData=companyProfileData.value.data?.employementHistoryNew??[];
        // await writeStorageData(key: profileDesignationData, value: profileData[0].lists?[0].designation.toString()??"");
        // await writeStorageData(key: profileImage, value: companyProfileData.value.data?.profile??"");

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
        // "int-id":companyId??"0",
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().followCompany(formData);
      if(addSkillsData.status==true){
        //Get.offNamed(AppRoutes.bottomNavBar);s
        Future.delayed(Duration(milliseconds: 500), ()async {
          getCompanyProfileApiCall();
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

  openJobsList(context){
    final BottomNavBarController controller = Get.find<BottomNavBarController>();
    controller.bottomNavCurrentIndex.value=2;
    //Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"2",screenName:companyProfileScreen});
  }

  void getDesignationApiCall() async{
    try {
      progressDialog.show();
      CompanyAllDetailsData designationListModel = await ApiProvider.baseWithToken().companyAllData();
      if(designationListModel.status==true){
        designationListData.value=designationListModel;

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

  getDashboardApiData() async {
    try {
      progressDialog.show();
      CompanyUserDetailsModel companyUserDetailsModel = await ApiProvider.baseWithToken().companyUserDetails();
      if(companyUserDetailsModel.status==true){
        companyUserDetails.value=companyUserDetailsModel;
        await writeStorageData(key: profileImage, value: companyUserDetails.value.data?.profile.toString()??"");
        await writeStorageData(key: progressPercentage, value: companyUserDetails.value.data?.profilePercentage.toString()??"0");
        await writeStorageData(key: searchJype, value: "jobs");


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