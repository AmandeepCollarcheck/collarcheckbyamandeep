import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/saveaccount_model/delete_account_model.dart';
import '../models/saveaccount_model/get_account_detail.dart';
import '../models/saveaccount_model/reason_delete_account.dart';
import '../models/saveaccount_model/save_account_detail.dart';
import '../models/verify_otp_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/add_employment_bottom_sheet.dart';
import '../utills/common_widget/progress.dart';

class AccountSettingController extends GetxController{
  late BuildContext context;
  final RxString selectedOption = 'no_one'.obs;
  var getsettingsData=SettingsDataModel().obs;
  var saveData=SaveAccountModel().obs;
  var deleteAccountOptionsList = <ReasonOptionsList>[].obs;
  Rx isLoginScreenData = false.obs;
  var selectedReasonName = ''.obs;
  RxString selectedReasonId = ''.obs;
  var isCompanyProfile=false.obs;
  final TextEditingController descriptionController = TextEditingController();



  int get messagingEnumValue {
    switch (selectedOption.value) {
      case 'no_one':
        return 1;

      case 'all_companies':
        return 3;

      case 'everyone':
        return 4;

      default:
        return 1;
    }
  }
  void saveMessagingPreference(String selectedValue) {
    // Map value to what API expects if needed
    print("Selected Messaging Option: $selectedValue");

    // Call API or local save
  }
@override
  void onInit() {
    // TODO: implement onInit

  final Map<String, dynamic> data = Get.arguments ?? {};


  if (data.isNotEmpty) {

    isLoginScreenData.value = data[isLoginScreen] ?? false;
    isCompanyProfile.value = data['isCompanyProfile'] ?? false;

  }
  Future.delayed(Duration(milliseconds: 500), ()async {
    getSettingsAPIs();();
  });
  Future.delayed(Duration(milliseconds: 500), ()async {
    reasonDeleteAccount();();
  });


    super.onInit();
  }


  void getSettingsAPIs() async{


    var userID = readStorageData(key: userId);
    final token = readStorageData(key: deviceAccessToken);
    try {
      progressDialog.show();

      SettingsDataModel settingsDataModel = await ApiProvider.baseWithToken().getSettings(options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token", // ✅ Add token here
        },
      ),);
      if(settingsDataModel.status==true){
        getsettingsData.value=settingsDataModel;

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

  /// This function maps the selectedOption to the required enum value

  void postsaveaccountApiCall() async{



    final token = readStorageData(key: deviceAccessToken);
    try {
      progressDialog.show();



      final Map<String, dynamic> body = {
        if (!isCompanyProfile.value) ...{
          "mobile": getsettingsData.value.getSettingDetailModel?.mobile ?? "",
          "address": getsettingsData.value.getSettingDetailModel?.address ?? "",
          "email": getsettingsData.value.getSettingDetailModel?.email ?? "",
          "dob": getsettingsData.value.getSettingDetailModel?.dob ?? "",
        },
        "message": messagingEnumValue,
      };

      SaveAccountModel savedetail =
       await ApiProvider.baseWithToken().generalSettings(body,
         options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token", // ✅ Add token here
        },
      ),);

      if(savedetail.status==true){
        progressDialog.dismissLoader();
saveData.value=savedetail;
Get.snackbar(
  "Save Settings Detail",                 // title of snackbar
  savedetail.messages.toString(),    // message
  snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
  backgroundColor: Colors.black87,
  colorText: Colors.white,
  duration: Duration(seconds: 2),
);
      }else{

        Get.snackbar(
          "Not Save Settings Detail",                 // title of snackbar
          savedetail.messages.toString(),    // message
          snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
        showToast(somethingWentWrong);
      }

    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }

  void deleteAccountApi() async{


    final selectedId = selectedReasonId.value;

    final token = readStorageData(key: deviceAccessToken);
    try {
      progressDialog.show();


      final Map<String, dynamic> body = {



        "option_id": selectedId,
        "message": descriptionController.text,
      };

      DeleteAccountModel deleteDetail = await ApiProvider.baseWithToken().deleteAccountApiCall(body,

        options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token", // ✅ Add token here
        },
      ),


      );


      progressDialog.dismissLoader();
      if(deleteDetail.status==true){
        Get.snackbar(
          "Delete Account",                 // title of snackbar
          deleteDetail.messages.toString(),    // message
          snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );


      }else{
        Get.snackbar(
          "Delete Account",                 // title of snackbar
          deleteDetail.messages.toString(),    // message
          snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
          backgroundColor: Colors.black87,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
        showToast(somethingWentWrong);
      }

    } on HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }
  void reasonDeleteAccount() async{


    try {
      progressDialog.show();
      DeleteAccountReasonModel reasonlistdetail = await ApiProvider.base().reasonDeleteAccount();



     if(reasonlistdetail.status==true){

       if (reasonlistdetail.reasonOptionsList != null &&
           reasonlistdetail.reasonOptionsList!.isNotEmpty) {

         // Assign directly to your observable list
         // deleteAccountOptionsList.value = turnoverListModel.turnOverListData!;

         deleteAccountOptionsList.addAll(reasonlistdetail.reasonOptionsList!);
         print("Reason list fetched by aman: ${deleteAccountOptionsList.length}");
         deleteAccountOptionsList.refresh();


       }


     }


      else{
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