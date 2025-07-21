import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/city_list_model.dart';
import '../models/edit_education_data_model.dart';
import '../models/education_details_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/state_list_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/image_multipart.dart';
import '../utills/common_widget/progress.dart';

class EducationControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var joiningDateControllers=TextEditingController();
  var employedTillControllers=TextEditingController();
  var educationDataDetails=EducationListModel().obs;
  var stateListData=StateListModel().obs;
  var cityListData=CityListModel().obs;
  var educationData=EditEducationDataModel().obs;
  var selectedCourseTypeData = Rxn<int>();

  Rx selectedInstitutationData="".obs;
  Rx selectedInstitutationIdData="".obs;
  Rx selectedCourseName="".obs;
  Rx selectedCourseIdName="".obs;
  Rx selectedCourseType="".obs;
  Rx selectedJoiningDate="".obs;
  Rx selectedEmployedTill="".obs;
  Rx selectedCountryData="".obs;
  Rx selectedCountryIdData="".obs;
  Rx selectedStateData="".obs;
  Rx selectedStateIdData="".obs;
  Rx selectedCityData="".obs;
  Rx selectedCityIdData="".obs;
  Rx isPurcuing =false.obs;
  Rx isHeigestQuilification =false.obs;
  var portfolioTitle="Select Portfolio".obs;
  var selectedImageFromTHeGallery="".obs;
  var selectedFileName="".obs;

  var screenNameData="".obs;
  var isEditData=false.obs;
  var isEditItemIdData="".obs;


  ///Dropdown data
  var selectedUniverCityDropDown={"id":"0","name":appSelectedUniversity}.obs;
  var selectedCourseDropDown={"id":"0","name":appSelectedCourse}.obs;
  var selectedCountryDropDown={"id":"0","name":appSelectCountry}.obs;
  var selectedStateDropDown={"id":"0","name":appSelectState}.obs;
  var selectedCityDropDown={"id":"0","name":appSelectCity}.obs;


@override
  void onInit() {
  final Map<String, dynamic> data = Get.arguments??{};
  if(data.isNotEmpty){
    screenNameData.value=data[screenName]??"";
    isEditData.value=data[isEdit]??false;
    isEditItemIdData.value=data[isEditItemId]??"";
  }
  Future.delayed(Duration(milliseconds: 500), ()async {
    await getDesignationApiCall();
  });
  if(isEditData.value){
    Future.delayed(Duration(milliseconds: 500), ()async {
      getEducationDataListApiCall();

    });
  }


    super.onInit();
  }

  backButtonClick(context){
  if(screenNameData.value==dashboard){
    Get.offNamed(AppRoutes.bottomNavBar);
  }else if(screenNameData.value==profileDetails){
    Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
  }
  }


   getDesignationApiCall() async{
    try {
      progressDialog.show();
      EducationListModel designationListModel = await ApiProvider.baseWithToken().educationDetails();
      if(designationListModel.status==true){
        educationDataDetails.value=designationListModel;

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





   getStateListApiCall({required String countryName}) async{
    try {
      if(isEditData.value==false){
        progressDialog.show();
      }
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

   getCityListApiCall({required String stateName}) async{
    try {
      if(isEditData.value==false){
        progressDialog.show();
      }

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


  addEducationValidation(context){
    if(selectedInstitutationData.value==null||selectedInstitutationData.value==""){
      showToast("$appPleaseSelect $appUniversityName");
    }else if(selectedCourseName.value==null||selectedCourseName.value==""){
      showToast("$appPleaseSelect $appCourseName");
    }else if(selectedJoiningDate.value==null||selectedJoiningDate.value==""){
      showToast(appPleaseSelectJoiningDate);
    }else if(selectedEmployedTill==null&&isPurcuing.value==false){
      showToast("$appPleaseSelect $appEndDate");
    }else if(selectedCountryData.value==null||selectedCountryData.value==""){
      showToast("$appPleaseSelect $appCountry");
    }else if(selectedStateData.value==null||selectedStateData.value==""){
      showToast("$appPleaseSelect $appState");
    }else if(selectedCityData.value==null||selectedCityData.value==""){
      showToast("$appPleaseSelect $appResidingCity");
    }else{
      addEducationDetailsApiCall(context);
    }

  }

  addEducationDetailsApiCall(context)async{

    try {
      keyboardDismiss(context);
      progressDialog.show();
      var documentFile = await convertFileToMultipart(selectedImageFromTHeGallery.value ?? "");
      var formData = dio.FormData.fromMap({
        "university":selectedInstitutationIdData.value??'',
        "course":selectedCourseIdName.value??'',
        "course_type":selectedCourseTypeData.value??"",
        "starting_date":selectedJoiningDate.value??'',
        "ending_date":isPurcuing.value?"":selectedEmployedTill.value??'',
        "ishighest":isHeigestQuilification.value,
        "ongoing":isPurcuing.value??"",
        "country":selectedCountryIdData.value??"",
        "state":selectedStateIdData.value??'',
        "city":selectedCityIdData.value??"",
        "document":documentFile??"",


      });
      SaveUserProfileModel addEducation = await ApiProvider.baseWithToken().addEducation(formData);
      print("Datat commemmeme>>>>>>1111");
      if(addEducation.status==true){
        progressDialog.dismissLoader();
        // showToast(addEmployment.messages??"");
        if(screenNameData.value==profileDetails){
          Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
        }else{
          Get.offNamed(AppRoutes.bottomNavBar);
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

  void getEducationDataListApiCall() async{
    try {
      progressDialog.show();
      EditEducationDataModel allDropDownListModel = await ApiProvider.baseWithToken().editEducationData(id: isEditItemIdData.value);
      if(allDropDownListModel.status==true){
        educationData.value=allDropDownListModel;
        var itemData=educationData.value.data;

        if(isEditData.value){
          if(itemData?.university!=null){
            var universityNameId=getDataBasedByIdName(model: educationDataDetails.value, name: itemData?.university.toString() ?? "0",);
            await Future.delayed(Duration(microseconds: 50));
            ///For University
            selectedUniverCityDropDown.value={
              "id": universityNameId.toString() ?? "0",
              "name": itemData?.university ?? appSelectedUniversity
            };
            selectedInstitutationIdData.value=universityNameId.toString()??itemData?.id;
          }


          ///Select Course
          if( itemData?.course!=null){
            var courseNameId=getCourseDataBasedByIdName(model: educationDataDetails.value, name: itemData?.course.toString() ?? "0",);

            await Future.delayed(Duration(microseconds: 50));
            selectedCourseDropDown.value={
              "id": courseNameId.toString() ?? "0",
              "name": itemData?.course ?? appSelectedCourse
            };
            selectedCourseIdName.value=courseNameId.toString();
          }


          ///Course type
          selectedCourseTypeData.value=int.tryParse(itemData!.courseType.toString())??1;
          ///joining Date and End Date
          joiningDateControllers.text=itemData?.startingDate??"";
          employedTillControllers.text=itemData?.endingDate??"";
          selectedJoiningDate.value=itemData?.startingDate??"";
          selectedEmployedTill.value=itemData?.endingDate??"";
          ///Pursuing and highest Qualification
          isPurcuing.value=itemData?.ongoing??false;
          isHeigestQuilification.value=itemData?.ishighest??false;
          ///Country
          var countryName=getCountryNameById(model: educationDataDetails.value, id: itemData?.country ?? "0",);
          selectedCountryDropDown.value={
            "id": itemData?.country ?? "0",
            "name": countryName ?? appSelectCountry
          };

          selectedCountryIdData.value=itemData?.country;
          await getStateListApiCall(countryName: itemData!.country.toString() );
          ///State
          selectedStateDropDown.value={
            "id": itemData?.state ?? "0",
            "name": itemData?.state ?? appSelectState
          };
          selectedStateIdData.value=itemData?.state;
          await getCityListApiCall(stateName: itemData?.state??"");
          ///City
          selectedCityDropDown.value={
            "id": itemData?.city ?? "0",
            "name": itemData?.city ?? appSelectCity
          };
          selectedCityIdData.value=itemData?.city;


          ///Document
          if(itemData.document!.isNotEmpty){
            selectedImageFromTHeGallery.value=itemData?.document?[0];
          }


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


  editEducationApiCall(context)async{
    try {
      progressDialog.show();
      var documentFile = await convertFileToMultipart(selectedImageFromTHeGallery.value ?? "");
      var formData = dio.FormData.fromMap({
        "university":selectedInstitutationIdData.value??'',
        "course":selectedCourseIdName.value??'',
        "course_type":selectedCourseTypeData.value??"",
        "starting_date":selectedJoiningDate.value??'',
        "ending_date":selectedEmployedTill.value??'',
        "ishighest":isHeigestQuilification.value,
        "ongoing":isPurcuing.value??"",
        "country":selectedCountryIdData.value??"",
        "state":selectedStateIdData.value??'',
        "city":selectedCityIdData.value??"",
        "document":documentFile??"",


      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().updateEducation(formData, id: isEditItemIdData.value);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
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


  String getCountryNameById({required EducationListModel model, required String id}) {
    return model.data?.countryList
        ?.firstWhere((country) => country.id == id, orElse: () => CountryList(name: "Not Found"))
        .name ??
        "Not Found";
  }


  String getDataBasedByIdName({
    required EducationListModel model,
    required String name,
  }) {

    final matchedItem = model.data?.institutionList?.firstWhere(
          (element) => (element.name?.trim().toLowerCase() == name.trim().toLowerCase()),
      orElse: () => CourseListElement(name: "Not Found", id: "Not Found"),
    );

    return matchedItem?.id ?? "Not Found";
  }

  String getCourseDataBasedByIdName({
    required EducationListModel model,
    required String name,
  }) {


    final matchedItem = model.data?.courseList?.firstWhere(
          (element) => (element.name?.trim().toLowerCase() == name.trim().toLowerCase()),
      orElse: () => CourseListElement(name: "Not Found", id: "Not Found"),
    );

    return matchedItem?.id ?? "Not Found";
  }


}