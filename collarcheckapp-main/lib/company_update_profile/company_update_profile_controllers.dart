import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_image_widget.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:dio/dio.dart' as dio;
import '../../api_provider/api_provider.dart';
import '../../models/city_list_model.dart';
import '../../models/company_all_details_data.dart';
import '../../models/company_user_details_model.dart';
import '../../models/employee_user_details_model.dart';
import '../../models/save_user_profile_model.dart';
import '../../models/state_list_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/add_new_job_model_sheet.dart';
import '../utills/common_widget/image_multipart.dart';


class  CompanyUpdateProfileControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var companyAllDetails=CompanyAllDetailsData().obs;
  final formKey = GlobalKey<FormState>();
  var stateListData=StateListModel().obs;
  var cityListData=CityListModel().obs;
  var nameOfCompanyController = TextEditingController();
  var websiteController = TextEditingController();
  var officeLocationController = TextEditingController();
  var linkedInController = TextEditingController();
  var youtubeController = TextEditingController();
  var instagramController = TextEditingController();
  var facebookController = TextEditingController();
  var twitterController = TextEditingController();
  var aboutCompanyController = TextEditingController();
  var contactPersonController = TextEditingController();
  var emailController = TextEditingController();
  var alternativeEmailController = TextEditingController();
  var phoneController = TextEditingController();
  var alternativePhoneController = TextEditingController();
  var listTabLabel = [
    appBasic, appAddress, appSocialAccounts
  ].obs;
  var selectedContactPersonDropDown={"id":"0","name": appSelectContactPerson}.obs;
  var selectedIndustryTypeDropDown={"id":"0","name": appSelectIndustryType}.obs;
  var selectedInCorporationYearDropDown={"id":"0","name": appSelectIncorporateYear}.obs;
  var selectedEstimatedTurnOverDropDown={"id":"0","name": appSelectIncorporateYear}.obs;
  var selectedEmployeesRangeDropDown={"id":"0","name": appSelectIncorporateYear}.obs;
  var selectedCountry={'id':"0","name":appSelectCountry}.obs;
  var selectedState={'id':"0","name":appSelectState}.obs;
  var selectedCity={'id':"0","name":appSelectCity}.obs;

  var isEmailVerified=false.obs;
  var isPhoneVerified=false.obs;
  Rx isAlternativeEmail=false.obs;
  Rx isAlternativePhone=false.obs;
  var profileImageData="".obs;
  var selectedImage = Rx<File?>(null);
  var ccId="".obs;
  var isVerified=false.obs;
  var emailVerified="".obs;
  var phoneVerified="".obs;

  ///Scrolle
  final ScrollController scrollController = ScrollController();

  final List<GlobalKey> sectionKeys = List.generate(3, (_) => GlobalKey());
  final List<double> sectionOffsets = [];
  final selectedIndex = 0.obs;

  bool isTabClicked = false;
  BuildContext? scrollViewContext;

  double lastOffset = 0.0;
  Timer? debounceTimer;
  @override
  void onInit() {
    // TODO: implement onInit

    scrollController.addListener(handleScroll);
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDesignationApiCall();
    });
    super.onInit();
  }

  void getDesignationApiCall() async{
    try {
      progressDialog.show();
      CompanyAllDetailsData designationListModel = await ApiProvider.baseWithToken().companyAllData();
      if(designationListModel.status==true){
        companyAllDetails.value=designationListModel;

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

  @override
  void onReady() {
    super.onReady();
    // Update offsets after the initial frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateSectionOffsets();
    });
  }


  void handleScroll() {
    print("as,ndj,,jasjajsdaj");

    // If a tab was clicked or sectionOffsets is empty, do nothing
    if (isTabClicked || sectionOffsets.isEmpty) return;

    // Cancel the previous debounce timer to avoid multiple executions
    debounceTimer?.cancel();

    // Set up the debounce timer
    debounceTimer = Timer(const Duration(milliseconds: 200), () {
      final scrollOffset = scrollController.offset;
      bool shouldUpdate = false;

      // Loop through section offsets and update the tab based on scroll position
      for (int i = sectionOffsets.length - 1; i >= 0; i--) {
        if (scrollOffset + 50 >= sectionOffsets[i]) {
          if (selectedIndex.value != i) {
            selectedIndex.value = i;
            shouldUpdate = true;
          }
          break;
        }
      }

      // Print when the selected index is updated
      if (shouldUpdate) {
        print(">>>>>>>>>>>>>>>>>>>>>>>....");
        print(selectedIndex.value);
      }
    });
  }


  void updateSectionOffsets() {
    sectionOffsets.clear();
    for (var key in sectionKeys) {
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        sectionOffsets.add(position.dy);
      }
    }
  }



  void scrollToSection(int index) {
    isTabClicked = true;
    final ctx = sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_) {
        Future.delayed(const Duration(milliseconds: 200), () {
          isTabClicked = false;
        });
      });
    } else {
      isTabClicked = false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    debounceTimer?.cancel();
    super.dispose();
  }
  void validateAllTextFiled(context) {
    keyboardDismiss(context);
    if(nameOfCompanyController.text==null||nameOfCompanyController.text.isEmpty){
      showToast(appPleaseNameOfCompany);
    }else if(emailController.text==null||emailController.text.isEmpty){
      showToast(appPleaseEnterValidName);
    }else if(phoneController.text==null||phoneController.text.isEmpty){
      showToast(appPleaseEnterValidPhone);
    }else if(contactPersonController.text==null||contactPersonController.text.isEmpty){
      showToast(appPleaseEnterContactPersonName);
    }else if(isInvalidSelection(selectedIndustryTypeDropDown.value, appSelectIndustryType)){
      showToast(appSelectIndustryType);
    }else{
      _updateProfileDetails(context);
    }
  }

  void _updateProfileDetails(context) async{
    try{
      progressDialog.show();
      var selectedImageFile = await convertFileToMultipart(selectedImage.value?.path??"");
      var formData = dio.FormData.fromMap({
        "company_name": nameOfCompanyController.text??"",
        "contact_person": contactPersonController.text??"",
        "email": emailController.text??"",
        "phone": phoneController.text??"",
        "slug": null,
        "incorporate_date": selectedInCorporationYearDropDown.value['name'],
        "turnover": selectedEstimatedTurnOverDropDown.value['name'],
        "linkdin": linkedInController.text??"",
        "youtube": youtubeController.text??"",
        "instagram": instagramController.text??"",
        "facebook": facebookController.text??"",
        "twitter": twitterController.text??"",
        "present_address": officeLocationController.text??"",
        "profile_description": aboutCompanyController.text??"",
        "website": websiteController.text??"",
        "country": selectedCountry.value['id'],
        "state": selectedState.value['id'],
        "city": selectedCity.value['id'],
        "industry": selectedIndustryTypeDropDown.value['id'],
        "profile": selectedImageFile,
        "type":1
      });
      SaveUserProfileModel saveUserProfileModel = await ApiProvider.baseWithToken().companyUpdateProfile(formData);
      if(saveUserProfileModel.status==true){
        progressDialog.dismissLoader();
        Navigator.pop(context);
      }else{
        showToast(saveUserProfileModel.messages??"");
      }
      progressDialog.dismissLoader();
    }on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }
  ///State list Api
  void getStateListApiCall({required String countryName}) async{
    try {
      progressDialog.show();
      StateListModel stateListModel = await ApiProvider.base().stateList(countryName: countryName);
      if(stateListModel.status==true){
        stateListData.value.data?.clear();
        stateListData.value=stateListModel;
        if(stateListData.value.data!=null&&stateListData.value.data!.isNotEmpty){
          progressDialog.dismissLoader();
        }
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
  ///City list api
  void getCityListApiCall({required String stateName}) async{
    try {
      progressDialog.show();
      CityListModel cityListModel = await ApiProvider.base().cityList(stateName: stateName);
      if(cityListModel.status==true){
        cityListData.value.data?.clear();
        cityListData.value=cityListModel;
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