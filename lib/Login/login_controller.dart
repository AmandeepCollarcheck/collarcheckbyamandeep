import 'dart:io';

import 'package:collarchek/api_provider/api_provider.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:linkedin_login/linkedin_login.dart';
import 'package:url_launcher/url_launcher.dart';



import '../models/send_otp_model.dart';
import '../models/social_login_model.dart';
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
  var socialLoginData=SocailLoginModel().obs;

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
      if (phoneController.text.length < 10) {
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
      print("Login successful: ${user.user?.email}");
      Future.delayed(Duration(milliseconds: 500), ()async {
        socialLoginApiCall(email: user.user?.email??"");
      });
    }
  }

  facebookLogin()async{
    final AuthService authService = AuthService();
    UserCredential? user = await authService.signInWithFacebook();
  }

  linkedinLogin()async{
    progressDialog.show();
    final String redirectUrl = 'https://www.linkedin.com/developers/tools/oauth/redirect';
    final String clientId = '77k0w5amiegwcb';
    final String clientSecret = 'WPL_AP1.C1OpJn3ExMpoZgYd.6nBt1Q==';
     Get.off((){
       return LinkedInUserWidget(
         redirectUrl: redirectUrl,
         clientId: clientId,
         destroySession: true,
         clientSecret: clientSecret,
         onGetUserProfile: (UserSucceededAction linkedInUser)  async {
           print("User Detail${linkedInUser.user.email??""}");
           Future.delayed(Duration(milliseconds: 500), ()async {
             socialLoginApiCall(email: linkedInUser.user.email??"");
           });



         },
         onError: (UserFailedAction e) {
           Get.offNamed(AppRoutes.login);
         },
       );
     });

  }

  void socialLoginApiCall({required String email}) async{
    try {
      progressDialog.show();
      var formData = dio.FormData.fromMap({
        "email": email??"",
      });
      SocailLoginModel connectionDataListModel = await ApiProvider.base().socialLoginApi(formData);
      if(connectionDataListModel.status==true){
        socialLoginData.value=connectionDataListModel;
        if(socialLoginData.value.data!=null){
          var socialData=socialLoginData.value.data;
          await writeStorageData(key: deviceAccessToken, value: socialData?.loginauth??"");
          await writeStorageData(key: profileImage, value: socialData?.profile??"");
          await writeStorageData(key: firstName, value: socialData?.fname??"");
          await writeStorageData(key: lastName, value: socialData?.lname??"");
          await writeStorageData(key: userId, value: socialData?.individualId??"");
          await writeStorageData(key: profession, value: socialData?.profileDescription??"");
          await writeStorageData(key: id, value: socialData?.id.toString()??"");
          await writeStorageData(key: slug, value: socialData?.slug??"");
          progressDialog.dismissLoader();
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