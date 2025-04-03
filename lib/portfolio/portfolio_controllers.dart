import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/edit_portfolio_data_model.dart';
import '../models/portifolio_list_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/image_multipart.dart';

class PortfolioControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var titleController =TextEditingController();
  var descriptionController =TextEditingController();
  var youTubeController =TextEditingController();
  var portfolioData=EditPortfolioDataModel().obs;
  var selectedPortfolioId="".obs;
  var portfolioTitle="Select Portfolio".obs;
  var selectedImageFromTHeGallery="".obs;
  var portfolioType=[{'id':"1","name":"Image"},{'id':"2","name":"Video"},{'id':"3","name":"Youtube Link"},{'id':"4","name":"Pdf"},].obs;

  var screenNameData="".obs;
  var isEditData=false.obs;
  var isEditItemIdData="".obs;



  ///Dropdown
  var selectedPortfolioDropDown={"id":"0","name":appSelectPortfolioType}.obs;


  @override
  void onInit() {
    final Map<String, dynamic> data = Get.arguments??{};
   if(data.isNotEmpty){
     screenNameData.value=data[screenName]??"";
     isEditData.value=data[isEdit]??false;
     isEditItemIdData.value=data[isEditItemId]??"";
    }
   if(isEditData.value){
     Future.delayed(Duration(milliseconds: 500), ()async {
       getPortfolioDataListApiCall();

     });
   }

    print(data);
    super.onInit();
  }

  backButtonClick(context){
    if(screenNameData.value==profileDetails){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }


  }
  enableUploadOptionBasedOnPortfolio(context){
    if(portfolioTitle.value=="Select Portfolio"){
      showToast(appPleaseSelectPortFolioType);
    }else if(portfolioTitle.value=="Upload Image"){
      getPortfolioTypeFromGallery(context,onFilePickedData: (String pickedData) {
        if(pickedData!=null){
          selectedImageFromTHeGallery.value=pickedData;
        }
      }, portfolioType: portfolioTitle.value);
    }else if(portfolioTitle.value=="Upload Video"){
      getPortfolioTypeFromGallery(context,onFilePickedData: (String pickedData) {
        if(pickedData!=null){
          selectedImageFromTHeGallery.value=pickedData;
        }
      }, portfolioType: portfolioTitle.value);
    }else{
      getFileFromGallery(context,onFilePickedData: (String pickedData) {
        if(pickedData!=null){
          selectedImageFromTHeGallery.value=pickedData;
        }
      },);
    }

  }
  
  validateAndSavePortfolioApiCall(context){
    if(titleController.text.isEmpty){
      showToast(appPleaseValidEnterTitle);
    }else if(portfolioTitle.value=="Select Portfolio"){
      showToast(appPleaseSelectPortFolioType);
    }else if(portfolioTitle.value==appSelectYoutubeLink){
      if(youTubeController.text.isEmpty){
        showToast(appPleaseEnterValidUrl);
      }
    }else if(selectedImageFromTHeGallery.value.isEmpty){
      showToast(appPleaseSelectPortfolio);
    }else{
      if(isEditData.value){
        _updatePortfolioSaveApiCall(context);
      }else{
        _addPortfolioSaveApiCall(context);
      }

    }

  }

  void _addPortfolioSaveApiCall(context) async{
    keyboardDismiss(context);

    try {
      progressDialog.show();
      var documentFile = await convertFileToMultipart(selectedImageFromTHeGallery.value ?? "");
      var formData = dio.FormData.fromMap({
        "title":titleController.text??"0",
        "description":descriptionController.text??"",
        "type":selectedPortfolioId??"",
        "youtube":youTubeController.text??"",
        "file":documentFile??0.0
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().addPortfolio(formData);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        if(screenNameData.value==profileDetails){
          Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
        }else{
          Get.offNamed(AppRoutes.bottomNavBar);
        }
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

  void getPortfolioDataListApiCall() async{
    try {
      progressDialog.show();
      EditPortfolioDataModel allDropDownListModel = await ApiProvider.baseWithToken().EdirPortifolioData(id: isEditItemIdData.value);
      if(allDropDownListModel.status==true){
        portfolioData.value=allDropDownListModel;
        var itemData=portfolioData.value.data;
        titleController.text=itemData?.title??"";
        descriptionController.text=itemData?.description??"";
        selectedImageFromTHeGallery.value=itemData?.image??"";
        selectedPortfolioId.value=itemData?.type??"";
        var index = portfolioType.indexWhere((item) => item['id'] == itemData?.type);
        if (index != -1) {
          // Swap the 0th index with the found index
          var selectedItem = portfolioType[index];
          portfolioType.removeAt(index);
          portfolioType.insert(0, selectedItem);
          portfolioTitle.value=selectedItem['name']??"";
          selectedPortfolioDropDown.value={
            "id": selectedItem['id'] ?? "0",
            "name": selectedItem['name'] ?? appSelectedUniversity
          };
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

  void _updatePortfolioSaveApiCall(context) async{
    keyboardDismiss(context);

    try {
      progressDialog.show();
      var documentFile = await convertFileToMultipart(selectedImageFromTHeGallery.value ?? "");
      var formData = dio.FormData.fromMap({
        "title":titleController.text??"0",
        "description":descriptionController.text??"",
        "type":selectedPortfolioId??"",
        "youtube":youTubeController.text??"",
        "file":documentFile??0.0
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().updatePortfolio(formData, id: isEditItemIdData.value);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
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
}