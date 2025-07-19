import 'dart:io';
import 'package:collarchek/utills/common_widget/update_profile_bottom_sheet.dart';
import 'package:dio/dio.dart' as dio;
import 'package:collarchek/models/company_signUp_model.dart';
import 'package:collarchek/models/individual_signup_model.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../api_provider/api_provider.dart';
import '../models/country_list_model.dart';
import '../models/send_otp_model.dart';
import '../models/social_login_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/auth_services.dart';
import '../utills/common_widget/progress.dart';

class SignUpControllers extends GetxController{
  final formKey = GlobalKey<FormState>();
  var companyController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var countryListData=CountryListModel().obs;

  var companyEmailController = TextEditingController();
  var referralCodeController = TextEditingController();
  var socialLoginData=SocailLoginModel().obs;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var isCompanyProfile = false.obs;
  Rx isTermCheck =false.obs;
  Rx selectedCountryFlag ="https://cdn.kcak11.com/CountryFlags/countries/in.svg".obs;
  Rx countryCode="+91".obs;
  Rx country=appSelect.obs;

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
    final Map<String, dynamic> data = Get.arguments??{};
    isCompanyProfile.value=data['isCompanyProfile']??false;

    Future.delayed(Duration(milliseconds: 500), ()async {
      getCountryListApiCall();

    });

    super.onInit();


  }
  var selectedCountry={'id':"0","name":appSelectCountry}.obs;


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
  sendOtpButtonSignup(context) async{
    if (formKey.currentState!.validate()) {
      if (phoneController.text.length < 4) {
        showToast(appMobileNumberNotLessThanFourDigit);
      } else {

        try {
          progressDialog.show();
          var params = {

            "email": companyEmailController.text ?? "",
            "phone": "${countryCode.value}${phoneController.text}" ?? "",
            "checkUnique": 1,
          };
          /*  IndividualSignupModel individualSignUpModel = await ApiProvider
            .base().individualSignUp(params);*/

          SendOtp sendOtp = await ApiProvider.base().sendOtp(params);
          progressDialog.dismissLoader();
          if (sendOtp.status == true) {
            // Get.toNamed(AppRoutes.otp);
            /* Get.offNamed(AppRoutes.otp, arguments: {
            "mobile_number": "${countryCode.value}${phoneController.text}",
            'isLoginScreen':false, 'isTermAccepted': isTermCheck.value, "email": companyEmailController.text, "firstName": firstNameController.text,
          "lastName": lastNameController.text,
            "companyName": companyController.text,
           "isCompanyProfile": isCompanyProfile.value,"refralcode":referralCodeController.text
          });*/

            if(isCompanyProfile.value==false)
            {
              Get.offNamed(AppRoutes.otp, arguments: {
                "mobile_number": "${countryCode.value}${phoneController.text}",
                'isLoginScreen':false, 'isTermAccepted': isTermCheck.value, "email": companyEmailController.text, "firstName": firstNameController.text,
                "lastName": lastNameController.text,'countryName':selectedCountry,


                "isCompanyProfile": isCompanyProfile.value,"refralcode":referralCodeController.text
              });

            }
            else{
              Get.offNamed(AppRoutes.otp, arguments: {
                "mobile_number": "${countryCode.value}${phoneController.text}",
                'isLoginScreen':false, 'isTermAccepted': isTermCheck.value, "email": companyEmailController.text,
                'companyName':companyController.text,

                'countryName': selectedCountry['name'],
                "isCompanyProfile": isCompanyProfile.value,"refralcode":referralCodeController.text
              });


            }



            print("$isCompanyProfile what is");

          } else {
            showToast(sendOtp.message ?? "");
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

  /* companySignUpSendOtpButton(context)async{
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
  }*/
  loginButtonClick(){
    Get.offNamed(AppRoutes.login);
  }
  backButtonClick(){
    Get.offNamed(AppRoutes.startUpSignup);
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