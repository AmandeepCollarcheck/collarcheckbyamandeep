import 'dart:io';

import 'package:collarchek/models/company_signUp_model.dart';
import 'package:collarchek/models/individual_signup_model.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class SignUpControllers extends GetxController{
  final formKey = GlobalKey<FormState>();
  var companyController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var companyEmailController = TextEditingController();
  var referralCodeController = TextEditingController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  var isCompanyProfile = false.obs;
  Rx isTermCheck =false.obs;
  Rx selectedCountryFlag ="https://cdn.kcak11.com/CountryFlags/countries/in.svg".obs;
  Rx countryCode="+91".obs;


  @override
  void dispose() {
    phoneController.dispose();
    companyController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    companyEmailController.dispose();
    referralCodeController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    final Map<String, dynamic> data = Get.arguments;
    isCompanyProfile.value=data['isCompanyProfile'];
    super.onInit();
  }

  sendOtpButtonClick(context) async {
    if (formKey.currentState!.validate()) {
      keyboardDismiss(context);
      if (isTermCheck.value == false) {
        showToast(appPleaseAcceptTermsConditions);
      } else {
        if (formKey.currentState!.validate()) {
          if (phoneController.text.length < 4) {
            showToast(appMobileNumberNotLessThanFourDigit);
          } else {
            try {
              progressDialog.show();
              var params = {
                "fname": firstNameController.text ?? "",
                "lname": lastNameController.text ?? "",
                "email": companyEmailController.text ?? "",
                "phone": "${countryCode.value}${phoneController.text}" ?? "",
                "referral_code": referralCodeController.text ?? ""
              };
              IndividualSignupModel individualSignUpModel = await ApiProvider
                  .base().individualSignUp(params);
              progressDialog.dismissLoader();
              if (individualSignUpModel.status == true) {
                // Get.toNamed(AppRoutes.otp);
                Get.offNamed(AppRoutes.otp, arguments: {
                  "mobile_number": "${countryCode.value}${phoneController.text}",
                  'isLoginScreen':false
                });
              } else {
                showToast(individualSignUpModel.messages ?? "");
              }
            } on HttpException catch (exception) {
              progressDialog.dismissLoader();
              showToast(exception.message);
            } catch (exception) {
              progressDialog.dismissLoader();
              showToast(exception.toString());
            }
          }
        }
      }
    }
  }
  companySignUpSendOtpButton(context)async{
    if (formKey.currentState!.validate()) {
      keyboardDismiss(context);
      if (isTermCheck.value == false) {
        showToast(appPleaseAcceptTermsConditions);
      } else {
        if (formKey.currentState!.validate()) {
          if (phoneController.text.length < 4) {
            showToast(appMobileNumberNotLessThanFourDigit);
          } else {
            try {
              progressDialog.show();
              var params = {
                "company_name": companyController.text ?? "",
                "email": companyEmailController.text ?? "",
                "phone": "${countryCode.value}${phoneController.text}" ?? "",
                "referral_code": referralCodeController.text ?? ""
              };
              CompanySignup companySignUpModel = await ApiProvider.base().companySignUp(params);
              progressDialog.dismissLoader();
              if (companySignUpModel.status == true) {
                // Get.toNamed(AppRoutes.otp);
                Get.offNamed(AppRoutes.otp, arguments: {
                  "mobile_number": "${countryCode.value}${phoneController.text}",
                  'isLoginScreen':false
                });
              } else {
                showToast(companySignUpModel.messages ?? "");
              }
            } on HttpException catch (exception) {
              progressDialog.dismissLoader();
              showToast(exception.message);
            } catch (exception) {
              progressDialog.dismissLoader();
              showToast(exception.toString());
            }
          }
        }
      }
    }
  }
  loginButtonClick(){
    Get.offNamed(AppRoutes.login);
  }
  backButtonClick(){
    Get.offNamed(AppRoutes.startUpSignup);
  }
}