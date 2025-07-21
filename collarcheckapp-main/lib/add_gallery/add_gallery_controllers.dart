import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/image_multipart.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../api_provider/api_provider.dart';
import '../models/company_benefit_model.dart';
import '../models/save_user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/common_widget/progress.dart';

class AddGalleryControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var screenNameData="".obs;
  var companyGalleryData=CompanyBenefitListModel().obs;
  var selectedImage = Rx<File?>(null);
  var allSelectedGalleryImages = <File?>[].obs;

  @override
  void onInit() {
    final Map<String, dynamic> data = Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
    }
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getCompanyGalleryData();
    });

    super.onInit();
  }
  backButtonClick(context){
    if(screenNameData.value==companyDashboardScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"0"});
    }else if(screenNameData.value==companyProfileScreen){
      Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
    }else{
      Get.offNamed(AppRoutes.bottomNavBar);
    }
  }

  captureImageFromCameraOrGallery(context){
    openCameraOrGallery(context, onCameraCapturedData: (File cameraCapturedImage ) {
      if(cameraCapturedImage.path!=null&&cameraCapturedImage.path.isNotEmpty){
        allSelectedGalleryImages.add(cameraCapturedImage);
      }
    }, onGalleryCapturedData: (File galleryCaptureImage) {
      if(galleryCaptureImage.path!=null&&galleryCaptureImage.path.isNotEmpty){
        allSelectedGalleryImages.value.add(galleryCaptureImage);
      }
    });
  }




  void getCompanyGalleryData() async{
    try {
      progressDialog.show();
      CompanyBenefitListModel benefitDataListModel = await ApiProvider.baseWithToken().companyGalleryData();
      if(benefitDataListModel.status==true){
        companyGalleryData.value=benefitDataListModel;

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
  addImageDataGalleryApi(context)async{
    keyboardDismiss(context);
    try {
      progressDialog.show();

      var formData = dio.FormData();

      for (int i = 0; i < allSelectedGalleryImages.length; i++) {
        if (allSelectedGalleryImages[i] != null && allSelectedGalleryImages[i]!.path.isNotEmpty) {
          var imageData = await convertFileToMultipart(allSelectedGalleryImages[i]!.path);
          formData.files.add(MapEntry("file[$i]", imageData!));
        }
      }

      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().addGalleryImage(formData);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        allSelectedGalleryImages.value.clear();
        update();
        Future.delayed(Duration(milliseconds: 500), ()async {
          getCompanyGalleryData();
        });

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

  deleteGalleryImage(context,{required String imageId})async{
    keyboardDismiss(context);
    try {
      progressDialog.show();
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().deleteGalleryImage(imageId);
      if(addSkillsData.status==true){
        progressDialog.dismissLoader();
        Future.delayed(Duration(milliseconds: 500), ()async {
          getCompanyGalleryData();
        });

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