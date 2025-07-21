import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/edit_employment_history_model.dart';
import '../models/employeement_history_model.dart';
import '../models/employment_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/image_multipart.dart';
import '../utills/common_widget/progress.dart';

class EmploymentHistoryControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var employmentHistoryData=EmploymentHistoryModel().obs;
  var designationListData=DesignationListModel().obs;
  var designationEditData=EditEmploymentHistoryModel().obs;
  var designationController=TextEditingController();
  var companyController=TextEditingController();
  var departmentController=TextEditingController();
  var joiningDateControllers=TextEditingController();
  var employedTillControllers=TextEditingController();
  var rolesAndResponsibilityControllers=TextEditingController();

  var ctcAmount=TextEditingController();
  var skills=[].obs;
  var selectedEmployeeType = Rxn<int>();
  var selectedSkillsData = [].obs;
  Rx selectedResumeName="".obs;
  Rx selectedDesignation="".obs;
  Rx selectedCompany="".obs;
  Rx selectedDepartment="".obs;
  Rx selectedJoiningDate="".obs;
  Rx selectedEmployedTill="".obs;
  Rx selectedSkills="".obs;
  Rx selectedCTC="".obs;
  Rx selectedType="".obs;

  Rx isStillWorkingHere =false.obs;
  var isEditData=false.obs;
  var isEditIdData="".obs;

  ///Salary
  var salaryType=[{'id':"1","name":appCTC},{'id':"2","name":appInHand},].obs;
  var salaryBracts=[{'id':"1","name":appAnnually},{'id':"2","name":appPerMonth},].obs;

 Rx screenNameData="".obs;
 var isProfileEditData=false.obs;


 /// Dropdown
  var selectedDesignationDropDown={"id":"0","name": appSelectDesignation}.obs;
  var selectedCompanyDropDown={"id":"0","name": appSelectCompany}.obs;
  var selectedDepartmentDropDown={"id":"0","name": appSelectDepartment}.obs;
  var selectedSkillsDropDown={"id":"0","name": appSelectSkill}.obs;
  var selectedCTCDropDown={"id":"0","name": appSelectCTC}.obs;
  var selectedCTCTypeDropDown={"id":"0","name": appSelectCTCType}.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      isEditData.value=data[isEdit]??false;
      isEditIdData.value=data[isEditItemId]??"";
      isProfileEditData.value=data[isProfileEdit]??false;
    }

    if(isEditData.value){
      Future.delayed(Duration(milliseconds: 500), ()async {
        getDesignationApiCall();
      });

      Future.delayed(Duration(milliseconds: 500), ()async {
        _editEmploymentHistoryModel();
      });
      
    }else{
      Future.delayed(Duration(milliseconds: 500), ()async {
        getDesignationApiCall();
      });
    }


    // Future.delayed(Duration(milliseconds: 500), ()async {
    //   getEmploymentHistoryApiCall();
    // });
    super.onInit();
  }


  backButtonClick(context){
    if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }else if(screenNameData.value==profileDetails){
      if(isProfileEditData.value){
        Get.back();
      }else{
        Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
      }

    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }

  }


  void getEmploymentHistoryApiCall() async{
    try {
      progressDialog.show();
      EmploymentHistoryModel employmentHistoryModel = await ApiProvider.baseWithToken().employmentHistory();
      if(employmentHistoryModel.status==true){
        employmentHistoryData.value=employmentHistoryModel;

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

  void getDesignationApiCall() async{
    try {
      progressDialog.show();
      DesignationListModel designationListModel = await ApiProvider.baseWithToken().designationList();
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



  addEmploymentValidation(context){
    if(selectedDesignation.value==null||selectedDesignation.value==""){
      showToast(appPleaseSelectDesignation);
    }else if(selectedCompany.value==null||selectedCompany.value==""){
      showToast(appPleaseSelectCompany);
    }else if(selectedDepartment.value==null||selectedDepartment.value==""){
      showToast(appPleaseSelectDepartment);
    }else if(selectedJoiningDate.value==null||selectedJoiningDate.value==""){
      showToast(appPleaseSelectJoiningDate);
    }else if(selectedEmployedTill==null&&isStillWorkingHere.value==false){
      showToast(appPleaseSelectEmpluedDate);
    }else if(selectedSkills.value==null||selectedSkills.value==""){
      showToast(appPleaseSelectSkill);
    }else if(selectedType.value==null||selectedType.value==""){
      showToast(appPleaseSelectCTC);
    }else if(ctcAmount.text==null||ctcAmount.text.isEmpty){
      showToast(appPleaseSelectCTCAmount);
    }else if(selectedType.value==null||selectedType.value==""){
      showToast(appPleaseSelectCTCType);
    }else if(selectedResumeName.value==null||selectedResumeName.value==""){
      showToast(appPleaseSelectResume);
    }else{
      if(isEditData.value){
        updateEmploymentApiCall(context);
      }else{
        addEmploymentApiCall(context);
      }

    }
  }

  addEmploymentApiCall(context)async{
    try {
      keyboardDismiss(context);
      progressDialog.show();
      var documentFile = await convertFileToMultipart(selectedResumeName.value??'');
      var formData = dio.FormData.fromMap({
        "designation":selectedDesignation.value??'',
        "company":selectedCompany.value??'',
        "department":selectedDepartment.value??"",
        "joining_date":selectedJoiningDate.value??'',
        "worked_till_date":selectedEmployedTill.value??'',
        "employment_type":selectedEmployeeType.value,
        "description":rolesAndResponsibilityControllers.text??"",
        "document[0]":documentFile??'',
        "salary_mode":selectedCTC.value??"",
        "salary_inhand":ctcAmount.value.text??"",
        "still_working":isStillWorkingHere.value?1:0
      });

      for (int i = 0; i < selectedSkillsData.length; i++) {
        formData.fields.add(MapEntry("skill[$i]", selectedSkillsData[i].toString()));
      }
      SaveUserProfileModel addEmployment = await ApiProvider.baseWithToken().addEmployment(formData);
      if(addEmployment.status==true){
        if (progressDialog.isShowing()) {
          Get.back();
        }
        if(screenNameData.value==dashboard){
          Get.offNamed(AppRoutes.bottomNavBar);
        }else if(screenNameData.value==profileDetails){
          if(isProfileEditData.value){
            Get.back();
          }else{
            Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
          }
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

  void _editEmploymentHistoryModel() async{
    try {
      progressDialog.show();
      EditEmploymentHistoryModel employmentHistoryModel = await ApiProvider.baseWithToken().employmentHistoryEditList(id: isEditIdData.value);
      if(employmentHistoryModel.status==true){
        designationEditData.value=employmentHistoryModel;
        var filledData=designationEditData.value.data;
        
        ///Designation
         selectedDesignationDropDown.value={
           "id":filledData?.designationId??"0",
           "name": filledData?.designation??appSelectDesignation
         };
        selectedDesignation.value=filledData?.designation??"";
         ///Company
         selectedCompanyDropDown.value={
           "id":filledData?.companyId??"0",
           "name": filledData?.company??appSelectCompany
         };
        selectedCompany.value=filledData?.company??"";
         ///Department
         selectedDepartmentDropDown.value={
           "id":filledData?.departmentId??"0",
           "name": filledData?.department??appSelectDepartment
         };
        selectedDepartment.value=filledData?.department??"";
         ///Skills
         selectedSkillsDropDown.value={
           "id":filledData?.skill?[0].id??"0",
           "name": filledData?.skill?[0].name??appSelectSkill
         };
         selectedSkills.value=filledData?.skill?[0].name??'';
        selectedSkillsData.assignAll(filledData?.skill??[]);

        //selectedSkills.value=
         ///Select CTC
        if(filledData?.salary!=null){
          if(filledData?.salary==appCTC){
            selectedCTCDropDown.value={
              "id":"1",
              "name": appCTC
            };
          }else{
            selectedCTCDropDown.value={
              "id":"2",
              "name": appInHand
            };
          }

        }
        selectedType.value=selectedCTCDropDown.value['name'];
         ///Select Ctc Type
        if(filledData!.salaryMode!.isNotEmpty){
          if(filledData?.salary==appAnnually){
            selectedCTCTypeDropDown.value={
              "id":"1",
              "name": appAnnually
            };
          }else{
            selectedCTCTypeDropDown.value={
              "id":"2",
              "name": appPerMonth
            };
          }
        }
        selectedType.value=selectedCTCTypeDropDown.value['name'];
         ///Joiniing and employedTill
        joiningDateControllers.text=filledData?.joiningDate??"";
        selectedJoiningDate.value=filledData?.joiningDate??"";
        employedTillControllers.text=filledData?.workedTillDate??"";
        selectedEmployedTill.value=filledData?.workedTillDate??"";
        ///Employment type
        selectedEmployeeType.value=int.tryParse(filledData?.employmentType??"0");
        ///Role $ responsibility
        rolesAndResponsibilityControllers.text=filledData?.description??"";
        ///Resume
        selectedResumeName.value=filledData?.document?[0]??"";
        ///Ctc amount
        ctcAmount.text=filledData?.salaryInhand??"";
        ///Still working
        if(filledData?.stillWorking=="0"){
          isStillWorkingHere.value=false;
        }else{
          isStillWorkingHere.value=true;
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

  updateEmploymentApiCall(context)async{
    try {
      keyboardDismiss(context);
      progressDialog.show();
      var documentFile = await convertFileToMultipart(selectedResumeName.value??'');
      var formData = dio.FormData.fromMap({
        "designation":selectedDesignation.value??'',
        "company":selectedCompany.value??'',
        "department":selectedDepartment.value??"",
        "joining_date":selectedJoiningDate.value??'',
        "worked_till_date":selectedEmployedTill.value??'',
        "employment_type":selectedEmployeeType.value,
        "description":rolesAndResponsibilityControllers.text??"",
        "document[0]":documentFile??'',
        "salary_mode":selectedCTC.value??"",
        "salary_inhand":ctcAmount.value.text??"",
        "still_working":isStillWorkingHere.value?1:0
      });


      for (int i = 0; i < selectedSkillsData.length; i++) {
        formData.fields.add(MapEntry("skill[$i]", selectedSkillsData[i].name.toString()));
      }
      SaveUserProfileModel addEmployment = await ApiProvider.baseWithToken().updateEmployment(formData,isEditIdData.value);
      if(addEmployment.status==true){
        if (progressDialog.isShowing()) {
          Get.back();
        }
        if(screenNameData.value==dashboard){
          Get.offNamed(AppRoutes.bottomNavBar);
        }else if(screenNameData.value==profileDetails){
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


}