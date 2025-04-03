import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/edit_certificates_model.dart';
import '../models/education_details_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/image_multipart.dart';
import '../utills/common_widget/progress.dart';

class CertificatesControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var joiningDateControllers=TextEditingController();
  var employedTillControllers=TextEditingController();
  var educationDataDetails=EducationListModel().obs;
  var educationEditDataDetails=EditCertificateModel().obs;
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

  var screenNameData="".obs;
  var isEditData=false.obs;
  var isEditItemIdData="".obs;



  /// Dropdown
  var selectedUniversityDropDown={"id":"0","name": appSelectedUniversity}.obs;
  var selectedCourseDropDown={"id":"0","name": appSelectedCourse}.obs;



  @override
  void onInit() {
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      isEditData.value=data[isEdit]??false;
      isEditItemIdData.value=data[isEditItemId]??"";

    }
    if(isEditData.value){
      Future.delayed(Duration(milliseconds: 500), ()async {
        _getCertificateDetailsBasedOnId();
      });
     
    }
    Future.delayed(Duration(milliseconds: 500), ()async {
      getDesignationApiCall();
    });

    super.onInit();
  }






  backButton(context){
    if(screenNameData.value==profileDetails){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }else if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }
  }


  void getDesignationApiCall() async{
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








  addEducationValidation(context){
    if(selectedInstitutationData.value==null||selectedInstitutationData.value==""){
      showToast("$appPleaseSelect $appUniversityName");
    }else if(selectedCourseName.value==null||selectedCourseName.value==""){
      showToast("$appPleaseSelect $appCourseName");
    }else if(selectedJoiningDate.value==null||selectedJoiningDate.value==""){
      showToast(appPleaseSelectJoiningDate);
    }else if(selectedEmployedTill==null&&isPurcuing.value==false){
      showToast("$appPleaseSelect $appEndDate");
    }else{
      if(isEditData.value){
        updateCertificatesDetailsApiCall(context);
      }else{
        addCertificatesDetailsApiCall(context);
      }

    }

  }

  addCertificatesDetailsApiCall(context)async{
    try {
      keyboardDismiss(context);
      progressDialog.show();
      var documentFile = await convertFileToMultipart(selectedImageFromTHeGallery.value ?? "");
      var formData = dio.FormData.fromMap({
        "university":selectedInstitutationIdData.value??'',
        "course":selectedCourseIdName.value??'',
        "course_type":selectedCourseTypeData.value??"",
        "starting_date":convertStringDateTime(date: selectedJoiningDate.value??''),
        "ending_date":convertStringDateTime(date:selectedEmployedTill.value??''),
        "ongoing":isPurcuing.value??"",
        "document[0]":documentFile??""//convertFileToMultipart(selectedImageFromTHeGallery.value??"")//convertFileToMultipart(selectedImageFromTHeGallery.value??""),


      });
      SaveUserProfileModel addEducation = await ApiProvider.baseWithToken().addCertificates(formData);
      if(addEducation.status==true){
        progressDialog.dismissLoader();
        if(screenNameData.value==profileDetails){
          Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
        }else if(screenNameData.value==dashboard){
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

  void _getCertificateDetailsBasedOnId()async {
    try {
      progressDialog.show();
      EditCertificateModel certificateModel = await ApiProvider.baseWithToken().certificateEdit(id: isEditItemIdData.value);
      if(certificateModel.status==true){
        educationEditDataDetails.value=certificateModel;
        var data=educationEditDataDetails.value.data;
        ///School/university
        selectedUniversityDropDown.value={
          "id":data?.universityId??"0",
          "name":data?.university??appSelectedUniversity
        };
        selectedInstitutationIdData.value=data?.universityId??"";
        selectedInstitutationData.value=data?.university??appSelectedUniversity;
        ///Course
        selectedCourseDropDown.value={
          "id":data?.courseId??"0",
          "name":data?.course??appSelectedCourse
        };
        selectedCourseIdName.value=data?.courseId??"";
        selectedCourseName.value=data?.course??appSelectedCourse;
        update();
        ///Joining date and end date
        joiningDateControllers.text=data?.startDate??appPleaseSelectJoiningDate;
        selectedJoiningDate.value=data?.startDate??appPleaseSelectJoiningDate;
        employedTillControllers.text=data?.endDate??appPleaseSelectEmpluedDate;
        selectedEmployedTill.value=data?.endDate??appPleaseSelectEmpluedDate;
        ///Ongoing
        isPurcuing.value=data?.ongoing??false;
        ///Certificate Pdf
        if(data!.document!.isNotEmpty){
          selectedImageFromTHeGallery.value=data?.document?[0]??"";
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

  void updateCertificatesDetailsApiCall(context) async{
    try {
      keyboardDismiss(context);
      progressDialog.show();
      var documentFile = await convertFileToMultipart(selectedImageFromTHeGallery.value ?? "");
      var formData = dio.FormData.fromMap({
        "university":selectedInstitutationIdData.value??'',
        "course":selectedCourseIdName.value??'',
        "course_type":selectedCourseTypeData.value??"",
        "starting_date":convertStringDateTime(date: selectedJoiningDate.value??''),
        "ending_date":convertStringDateTime(date:selectedEmployedTill.value??''),
        "ongoing":isPurcuing.value??"",
        "document[0]":documentFile??""//convertFileToMultipart(selectedImageFromTHeGallery.value??"")//convertFileToMultipart(selectedImageFromTHeGallery.value??""),


      });
      SaveUserProfileModel addEducation = await ApiProvider.baseWithToken().updateCertificates(formData,isEditItemIdData.value);
      if(addEducation.status==true){
        progressDialog.dismissLoader();
        if(screenNameData.value==profileDetails){
          Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
        }else if(screenNameData.value==dashboard){
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
}