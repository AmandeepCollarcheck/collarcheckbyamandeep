import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_provider/api_provider.dart';
import '../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../models/all_language_list_model.dart';
import '../models/all_skills_list_model.dart';
import '../models/certificates_data_list_model.dart';
import '../models/education_details_model.dart';
import '../models/education_list_model.dart';
import '../models/employment_history_list_model.dart';
import '../models/language_list_model.dart';
import '../models/portifolio_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class  ProfileDetailsControllers extends GetxController with GetTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final scrollControllerForTabSelection = ScrollController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  var userProfileData=UserProfileModel().obs;
  var searchController =TextEditingController();
  Rx isSearchActive=false.obs;
  var selectedIndex=0.obs;
  late final TabController tabController;
  var employmentHistoryData=EmploymentHistoryListModel().obs;
  var educationListData=EducationListDataModel().obs;
  var portfolioData=PortfolioListModel().obs;
  var allSkillsData=AllSkillsListModel().obs;
  var allCertificatesData=CertificateListDataModel().obs;
  var languageDate=LanguageListModel().obs;
  var experienceHeights = <double>[].obs;
  var isExpendedSkills=false.obs;
  var screenNameData="".obs;
  var slugDataId="".obs;
  var isEmployeeProfileDate=false.obs;
  var userIdData="".obs;


  final sectionKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),

  ];



  var listTabLabel = [
    appHome, appEmploymentHistory, appPortfolio,appEducation
  ].obs;

  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
     if(data.isNotEmpty){
       screenNameData.value=data[screenName]??"";
       slugDataId.value=data[slugId]??"";
       isEmployeeProfileDate.value=data[isEmployeeProfile]??false;
     }
    tabController = TabController(length: 4, vsync: this);
    scrollControllerForTabSelection.addListener(_onScroll);
    // TODO: implement onInit
    //IndividualUserProfileModel
    Future.delayed(Duration(milliseconds: 500), ()async {
      userIdData.value=await readStorageData(key: id);
      getProfileApiCall();
    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getEmplymentHistoryCall();

    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getPortfolioDataListApiCall();

    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getEducationListApiCall();

    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getLanguageListApiCall();

    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getSkillsListApiCall();

    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getCertificatesListApiCall();

    });
    super.onInit();
  }



  backButtonClick(){
    if(screenNameData.value==searchScreen){
      Get.offNamed(AppRoutes.search);
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }

  }



  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      200 + random.nextInt(56),
      200 + random.nextInt(56),
      200 + random.nextInt(56),
    );
  }

  void getProfileApiCall() async{
    try {
      progressDialog.show();
      String slugData =await GetStorage().read(slug);


      UserProfileModel userProfileModel = await ApiProvider.baseWithToken().userProfile(userName: slugDataId.value.isNotEmpty?slugDataId.value:slugData);
      if(userProfileModel.status==true){
        userProfileData.value=userProfileModel;
        var profileData=userProfileData.value.data?.employementHistoryNew??[];
        await writeStorageData(key: profileDesignationData, value: profileData[0].lists?[0].designation.toString()??"");
        await writeStorageData(key: profileImage, value: userProfileData.value.data?.profile??"");

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

  void updateHeight(int index, double height) {
    if (experienceHeights.length > index) {
      experienceHeights[index] = height;
    } else {
      experienceHeights.add(height);
    }
    experienceHeights.refresh(); // Refresh to update UI
  }



  void getEmplymentHistoryCall() async{
    try {
      progressDialog.show();
      EmploymentHistoryListModel allDropDownListModel = await ApiProvider.baseWithToken().allEmploymentHistoryList();
      if(allDropDownListModel.status==true){
        employmentHistoryData.value=allDropDownListModel;
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

  void getPortfolioDataListApiCall() async{
    try {
      progressDialog.show();
      PortfolioListModel allDropDownListModel = await ApiProvider.baseWithToken().allPortifolioData();
      if(allDropDownListModel.status==true){
        portfolioData.value=allDropDownListModel;
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

  void getEducationListApiCall() async{
    try {
      progressDialog.show();
      EducationListDataModel allDropDownListModel = await ApiProvider.baseWithToken().allEducationData();
      if(allDropDownListModel.status==true){
        educationListData.value=allDropDownListModel;
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

  void getLanguageListApiCall() async{
    try {
      progressDialog.show();
      LanguageListModel allDropDownListModel = await ApiProvider.baseWithToken().allLanguageDetails();
      if(allDropDownListModel.status==true){
        languageDate.value=allDropDownListModel;
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

  void getSkillsListApiCall() async{
    try {
      progressDialog.show();
      AllSkillsListModel allSkillsListModel = await ApiProvider.baseWithToken().allSkillData();
      if(allSkillsListModel.status==true){
        allSkillsData.value=allSkillsListModel;

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

  void getCertificatesListApiCall() async{
    try {
      progressDialog.show();
      CertificateListDataModel allSkillsListModel = await ApiProvider.baseWithToken().allCertificatesDataList();
      if(allSkillsListModel.status==true){
        allCertificatesData.value=allSkillsListModel;

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

  deleteCertificates(context,{required String certificatesId})async{
    try {
      progressDialog.show();
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().deleteCertificates(certificatesId);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        getCertificatesListApiCall();

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
          getProfileApiCall();
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

  ///Open Message screen
  openMessageScreen(context){
    final BottomNavBarController controller = Get.find<BottomNavBarController>();
    controller.bottomNavCurrentIndex.value=3;
  }


  void _onScroll() {
    for (int i = 0; i < sectionKeys.length; i++) {
      final keyContext = sectionKeys[i].currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero, ancestor: null).dy;

        if (position > 0 && position < 200) { // 200 means "near top"
          if (selectedIndex.value != i) {
            selectedIndex.value = i;
          }


          print("shhjshdfhshkdf");
          print(position);
          break;
        }
      }
    }
  }


  @override
  void onClose() {
    scrollController.dispose();
    scrollControllerForTabSelection.dispose();
    super.onClose();
  }
  void scrollToSection(int index) {
    final context = sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }



}