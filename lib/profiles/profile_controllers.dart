import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:collarchek/models/user_profile_model.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart' as dio;
import 'package:get_storage/get_storage.dart';

import '../api_provider/api_provider.dart';
import '../models/all_drop_down_list_model.dart';
import '../models/city_list_model.dart';
import '../models/country_list_model.dart';
import '../models/employee_user_details_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/state_list_model.dart';
import '../models/user_home_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class ProfileControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  Rx isAlternativeEmail=false.obs;
  Rx isAlternativePhone=false.obs;
  Rx isSameAsCheck =false.obs;
  Rx isEmailVerified =false.obs;
  Rx isPhoneVerified =false.obs;
  var userProfileData=EmployeeUserDetails().obs;
  var countryListData=CountryListModel().obs;
  var stateListData=StateListModel().obs;
  var cityListData=CityListModel().obs;
  var allDropDownData=AllDropDownListModel().obs;
  final formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var alternativeEmailController = TextEditingController();
  var alternativePhoneController = TextEditingController();
  var dateOfBirthController = TextEditingController();
  var presentController = TextEditingController();
  var permanentController = TextEditingController();
  var linkedInController = TextEditingController();
  var youtubeController = TextEditingController();
  var instagramController = TextEditingController();
  var facebookController = TextEditingController();
  var tumblrController = TextEditingController();
  var discordController = TextEditingController();
  var twitterController = TextEditingController();
  var zoomController = TextEditingController();
  var snapshotController = TextEditingController();

  var selectedImage = Rx<File?>(null);
  Rx accomodationType=appSelect.obs;
  Rx myCurrentCompany=appSelect.obs;
  Rx currentPosition=appSelect.obs;
  Rx workStatus=appSelect.obs;
  Rx country=appSelect.obs;
  Rx state=appSelect.obs;
  Rx residingCity=appSelect.obs;
  Rx presentAddress=appSelect.obs;
  Rx paremanentAddress=appSelect.obs;




  Rx selectedResumeName="".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllDropDownListApiCall();

    });
    Future.delayed(Duration(milliseconds: 500), ()async {
       await getProfileApiCall();

    });
    Future.delayed(Duration(milliseconds: 500), ()async {
      getCountryListApiCall();

    });

    super.onInit();
  }



  backButtonClick(){
    Get.offNamed(AppRoutes.bottomNavBar);
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


   getProfileApiCall() async{
    try {
      progressDialog.show();
      String firstname =await GetStorage().read(firstName);
      String lastname =await GetStorage().read(lastName);
      final userName=("$firstname-$lastname").replaceAll(" ", "");
      EmployeeUserDetails userProfileModel = await ApiProvider.baseWithToken().employeeUserDetails();
      if(userProfileModel.status==true){
        userProfileData.value=userProfileModel;
        firstNameController.text=userProfileData.value.data?.fname??"";
        lastNameController.text=userProfileData.value.data?.lname??"";
        emailController.text=userProfileData.value.data?.email??"";
        phoneController.text=userProfileData.value.data?.phone??"";
        dateOfBirthController.text=userProfileData.value.data?.dob??"";
        accomodationType.value=userProfileData.value.data?.accomodationName??appSelect;
        myCurrentCompany.value=userProfileData.value.data?.stillWorkingCompanyName??appSelect;
        currentPosition.value=userProfileData.value.data?.currentPosition??appSelect;
        workStatus.value=userProfileData.value.data?.workStatusName??appSelect;
        country.value=userProfileData.value.data?.countryName??appSelect;
        state.value=userProfileData.value.data?.stateName??appSelect;
        residingCity.value=userProfileData.value.data?.city??appSelect;
        isSameAsCheck.value=userProfileData.value.data?.sameAddress??false;
        presentAddress.value=userProfileData.value.data?.presentAddress??appSelect;
        paremanentAddress.value=userProfileData.value.data?.permanentAddress??appSelect;
        linkedInController.text=userProfileData.value.data?.linkdin??"";
        youtubeController.text=userProfileData.value.data?.youtube??"";
        instagramController.text=userProfileData.value.data?.instagram??"";
        facebookController.text=userProfileData.value.data?.facebook??"";
        tumblrController.text=userProfileData.value.data?.tumblr??"";
        discordController.text=userProfileData.value.data?.discord??"";
        twitterController.text=userProfileData.value.data?.twitter??"";
        zoomController.text=userProfileData.value.data?.zoom??"";
        snapshotController.text=userProfileData.value.data?.snapchat??"";
        selectedResumeName.value=userProfileData.value.data?.resumeName??"";
        ///Set Data in DropDown
        if(userProfileData.value.data?.currentCompany!=null){
          allDropDownData.value.data?.companyList?[0]=CompanyList(id:userProfileData.value.data?.currentCompany??"",company: userProfileData.value.data?.stillWorkingCompanyName??"" );
        }
        if(userProfileData.value.data?.accomodationName!=null){
          allDropDownData.value.data?.accomodationList?[0]=AccomodationListElement(id:userProfileData.value.data?.accomodation??"",name: userProfileData.value.data?.accomodationName??"" );
        }
        if(userProfileData.value.data?.currentPosition!=null){
          allDropDownData.value.data?.accomodationList?[0]=AccomodationListElement(id:userProfileData.value.data?.stillWorkingPosition??"",name: userProfileData.value.data?.stillWorkingPositionName??"" );
        }
        if(userProfileData.value.data?.workStatus!=null){
          allDropDownData.value.data?.accomodationList?[0]=AccomodationListElement(id:userProfileData.value.data?.workStatus??"",name: userProfileData.value.data?.workStatusName??"" );
        }
        if(userProfileData.value.data?.country!=null){
          countryListData.value.data?[0]=CountryDatum(id:userProfileData.value.data?.country??"",name: userProfileData.value.data?.countryName??"" );
        }
        if(userProfileData.value.data?.state!=null){
          stateListData.value.data?[0]=StateDatum(id:userProfileData.value.data?.state??"",name: userProfileData.value.data?.stateName??"" );
        }
        if(userProfileData.value.data?.city!=null){
          cityListData.value.data?[0]=CityDatum(id:userProfileData.value.data?.city??"",name: userProfileData.value.data?.cityName??"" );
        }
      //  allDropDownData.value.data?.companyList?[0].id=userProfileData.value.data?.currentCompany??"";
        //allDropDownData.value.data?.companyList?[0].company=userProfileData.value.data?.stillWorkingCompanyName??"";
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

  ///Country List
  void getCountryListApiCall() async{
    try {
      progressDialog.show();
      CountryListModel countryListModel = await ApiProvider.base().countryList();
      if(countryListModel.status==true){
        countryListData.value.data?.clear();
        countryListData.value=countryListModel;
        if(countryListData.value.data!=null&&countryListData.value.data!.isNotEmpty){
          progressDialog.dismissLoader();
          getStateListApiCall(countryName: countryListData.value.data?[0].id??"");
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

  void getStateListApiCall({required String countryName}) async{
    try {
      progressDialog.show();
      StateListModel stateListModel = await ApiProvider.base().stateList(countryName: countryName);
      if(stateListModel.status==true){
        stateListData.value.data?.clear();
        stateListData.value=stateListModel;
        if(stateListData.value.data!=null&&stateListData.value.data!.isNotEmpty){
          progressDialog.dismissLoader();
          getCityListApiCall(stateName: stateListData.value.data?[0].id??"");
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

  void getAllDropDownListApiCall() async{
    try {
      progressDialog.show();
      AllDropDownListModel allDropDownListModel = await ApiProvider.base().allDropDownListData();
      if(allDropDownListModel.status==true){
        allDropDownData.value=allDropDownListModel;
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



  void saveUserProfile(context) async{
    try {
      keyboardDismiss(context);
      progressDialog.show();
      var params={
        "fname":firstNameController.text??'',
        "lname":lastNameController.text??'',
        "work_status":workStatus.value??"",
        "email":emailController.text??"",
        "alternative_email":alternativeEmailController.text??"",
        "phone":phoneController.text??'',
        "alternative_phone":alternativePhoneController.text??"",
        "city":residingCity.value??'',
        "display_type":"",
        "current_position":currentPosition.value??'',
        "current_company":myCurrentCompany.value??'',
        "linkdin":linkedInController.text??'',
        "youtube":youtubeController.text??'',
        "instagram":instagramController.text??'',
        "facebook":facebookController.text??'',
        "tumblr":tumblrController.text??'',
        "discord":discordController.text??"",
        "twitter":twitterController.text??'',
        "zoom":zoomController.text??'',
        "snapchat":snapshotController.text??'',
        "profile_description":"",
        "accomodation":accomodationType.value??'',
        "present_address":presentController.text??'',
        "same_address" : isSameAsCheck.value,
        "permanent_address":permanentController.text??"",
        "country":country.value??'',
        "dob":dateOfBirthController.text??'',
        "state":state.value??'',
        "profile":selectedImage.value?.path??"",
        "resume":selectedResumeName.value??""
      };
      SaveUserProfileModel saveUserProfileModel = await ApiProvider.baseWithToken().saveUserProfile(params);
      if(saveUserProfileModel.status==true){
        getProfileApiCall();
        showToast("Data Saved Successfully");
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



  isPermanaentAddressSameAsPresentAddress(){
    if(presentController.text.isNotEmpty&&isSameAsCheck.value){
      permanentController.text=presentController.text;
    }else{
      permanentController.clear();
    }
  }


  verifyEmailIdApiCall()async{
    try {
      progressDialog.show();
      var params={
        "email":emailController.text??""
      };
      SaveUserProfileModel emailVerify = await ApiProvider.baseWithToken().verifyEmail(params);
      if(emailVerify.status==true){
        showToast(emailVerify.messages??'');
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Close dialog
        }
        Get.offNamed(AppRoutes.otp,arguments: {'mobile_number':emailController.text??"",'isEmailVerification':true,});
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