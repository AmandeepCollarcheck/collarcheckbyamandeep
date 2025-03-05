import 'dart:io';

import 'package:collarchek/api_provider/api_provider.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';




import '../models/send_otp_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/auth_services.dart';
import '../utills/common_widget/progress.dart';

class LoginControllers extends GetxController{
  final formKey = GlobalKey<FormState>();
  late final TextEditingController phoneController ;
  late ProgressDialog progressDialog ;
  Rx selectedCountryFlag ="https://cdn.kcak11.com/CountryFlags/countries/in.svg".obs;
  Rx countryCode="+91".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    phoneController = TextEditingController();
    progressDialog = ProgressDialog();
    super.onInit();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.onClose();
  }

  sendOtpLogin(context) async {
    keyboardDismiss(context);
    if(formKey.currentState!.validate()) {
      if (phoneController.text.length < 4) {
        showToast(appMobileNumberNotLessThanFourDigit);
      } else {
        try {
          progressDialog.show();
          var params = {
            "phone": "${countryCode.value}${phoneController.text}"
          };
          SendOtp sendOtp = await ApiProvider.base().sendOtp(params);
          progressDialog.dismissLoader();
          if (sendOtp.status == true) {
            Get.offNamed(AppRoutes.otp,arguments: {"mobile_number":"${countryCode.value}${phoneController.text}",'isLoginScreen':true});
          } else {
            showToast(sendOtp.message);
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

  signUpButtonClick(){
    Get.offNamed(AppRoutes.startUpSignup);
  }
  backClick(){
    Get.offNamed(AppRoutes.startup);
  }

  googleLogin() async {
    final AuthService authService = AuthService();
    UserCredential? user = await authService.signInWithGoogle();
    if (user != null) {
      print("Login successful: ${user.user?.displayName}");
    }
  }

}