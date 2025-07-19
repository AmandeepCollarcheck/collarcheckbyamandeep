import 'dart:async';
import 'dart:io';

import 'package:collarchek/api_provider/api_constant.dart';
import 'package:collarchek/dashboard/dashboard_page.dart';
import 'package:collarchek/models/verify_otp_model.dart';

import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:collarchek/utills/common_widget/update_profile_bottom_sheet.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';

import 'package:get_storage/get_storage.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:permission_handler/permission_handler.dart';

import '../api_provider/api_provider.dart';
import '../models/company_signUp_model.dart';
import '../models/individual_signup_model.dart';
import '../models/save_user_profile_model.dart';
import '../models/send_otp_model.dart';
import 'package:get/get.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';

class OtpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late ProgressDialog progressDialog = ProgressDialog();

  var otpController = TextEditingController();
  late OTPTextEditController otpTextController;
  final scaffoldKey = GlobalKey();


  Rx mobileNumberData = "".obs;
  Rx isLoginScreenData = false.obs;
  bool isTermAccepted = false;
  Rx isEmailVerificationData = false.obs;

  Rx otpCountDownTimer = 30.obs;
  Timer? _timer;
  Rx screenNameData = "".obs;
  var isOtpWrong = false.obs;
  var emailData="".obs;


  var firstNameData="".obs;
  var lastNameData="".obs;
  var refralCode="".obs;

  var companyName="".obs;
  String countryName="";
  var isCompanyProfile=false.obs;
  @override
  void onInit() {
    final Map<String, dynamic> data = Get.arguments ?? {};


    if (data.isNotEmpty) {
      mobileNumberData.value = data[mobileNumber] ?? "";
      isLoginScreenData.value = data[isLoginScreen] ?? false;
      isEmailVerificationData.value = data[isEmailVerification] ?? false;
      screenNameData.value = data[dashboard] ?? "";
      isTermAccepted = data['isTermAccepted'] ?? false;

      refralCode.value=data['refralcode']??'';
      emailData.value = data['email'] ?? '';
      firstNameData.value = data['firstName'] ?? '';
      lastNameData.value = data['lastName'] ?? '';
      companyName.value=data['companyName']??'';
      countryName =data['countryName']??'';
      isCompanyProfile.value = data['isCompanyProfile'] ?? false;
    }

    _autoFilledOtpHandle();
    _otpCountDownStart();
    super.onInit();
  }

  @override
  void onClose() {
    otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  /* loginButtonClick(context) async {
    //verfy otp
    keyboardDismiss(context);
    if (formKey.currentState!.validate()) {
      if (otpController.text.length < 6) {
        showToast(appOtpMustBeSixDigit);
      } else {
        try {
          progressDialog.show();

          final formData = dio.FormData.fromMap(isLoginScreenData.value
              ? {
                  "phone": mobileNumberData.value,
                  "otp": otpController.text,
                  "login": 1,
                }
              : {
                  "phone": mobileNumberData.value,
                  "email": emailData.value,
                  "otp": otpController.text,
                  "checkUnique": 1,
                });
          VerifyOtp verifyOtpResponse =
              await ApiProvider.base().verifyOtp(formData);

          if (verifyOtpResponse.status == true &&verifyOtpResponse.data?.loginauth != null) {
            //login success store data
            await writeStorageData(
                key: deviceAccessToken,
                value: verifyOtpResponse.data?.loginauth ?? "");
            await writeStorageData(
                key: profileImage,
                value: verifyOtpResponse.data?.profile ?? "");
            await writeStorageData(
                key: firstName, value: verifyOtpResponse.data?.fName ?? "");
            await writeStorageData(
                key: lastName, value: verifyOtpResponse.data?.lName ?? "");
            await writeStorageData(
                key: userId, value: verifyOtpResponse.data?.individualId ?? "");
            await writeStorageData(
                key: profession,
                value: verifyOtpResponse.data?.profileDescription ?? "");
            await writeStorageData(
                key: id, value: verifyOtpResponse.data?.id ?? "");
            await writeStorageData(
                key: slug, value: verifyOtpResponse.data?.slug ?? "");
            await writeStorageData(
                key: userType, value: verifyOtpResponse.data?.userType ?? "");
            progressDialog.dismissLoader();
            Get.offNamed(AppRoutes.bottomNavBar);

            //call register api
           if(isLoginScreenData.value==false&&isCompanyProfile.value==false)
             {
               registerButtonClick(context);

             }
           else
             {
               companySignUpSendButton(context);
             }




          } else {


            progressDialog.dismissLoader();

            final canVibrate = await Haptics.canVibrate();
            await Haptics.vibrate(HapticsType.error);
            isOtpWrong.value = true;
            showToast(verifyOtpResponse.message ?? "");
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
  }*/
  loginButtonClick(context) async {
    keyboardDismiss(context);

    if (formKey.currentState!.validate()) {
      if (otpController.text.length < 6) {
        showToast(appOtpMustBeSixDigit);
        return;
      }

      try {
        progressDialog.show();

        // Prepare form data
        final formData = dio.FormData.fromMap(
          isLoginScreenData.value
              ? {
            "phone": mobileNumberData.value,
            "otp": otpController.text,
            "login": 1,
          }
              : {
            "phone": mobileNumberData.value,
            //  "email": emailData.value,
            "otp": otpController.text,

            "login":0,
          },
        );

        // API call
        VerifyOtp verifyOtpResponse = await ApiProvider.base().verifyOtp(formData);

        progressDialog.dismissLoader();

        if (verifyOtpResponse.status == true) {


          final token = verifyOtpResponse.data?.loginauth;

          if (token != null && token.isNotEmpty) {

            // Store login data
            await writeStorageData(key: deviceAccessToken, value: token);
            await writeStorageData(key: profileImage, value: verifyOtpResponse.data?.profile ?? "");
            await writeStorageData(key: firstName, value: verifyOtpResponse.data?.fName ?? "");
            await writeStorageData(key: lastName, value: verifyOtpResponse.data?.lName ?? "");
            await writeStorageData(key: lastName, value: verifyOtpResponse.data?.companyName ?? "");
            await writeStorageData(key: userId, value: verifyOtpResponse.data?.individualId ?? "");
            await writeStorageData(key: userId, value: verifyOtpResponse.data?.phone ?? "");
            await writeStorageData(key: userId, value: verifyOtpResponse.data?.email ?? "");
            await writeStorageData(key: userId, value: verifyOtpResponse.data?.emailVerified ?? "");
            await writeStorageData(key: profession, value: verifyOtpResponse.data?.profileDescription ?? "");
            await writeStorageData(key: id, value: verifyOtpResponse.data?.id ?? "");
            await writeStorageData(key: slug, value: verifyOtpResponse.data?.slug ?? "");
            await writeStorageData(key: userType, value: verifyOtpResponse.data?.userType ?? "");
            await writeStorageData(key: userType, value: verifyOtpResponse.data?.permanentAddress ?? "");
            await writeStorageData(key: userType, value: verifyOtpResponse.data?.dob?? "");

            // Navigate to main app screen
            Get.offNamed(AppRoutes.bottomNavBar);
          }

          // If this is not login but signup, and token is not returned yet
          if (!isLoginScreenData.value) {
            if (isCompanyProfile.value == false) {
              registerButtonClick(context); // individual signup
            } else {
              companySignUpSendButton(context); // company signup
            }
          }
        } else {
          // Invalid OTP or API failed
          final canVibrate = await Haptics.canVibrate();
          if (canVibrate) await Haptics.vibrate(HapticsType.error);

          isOtpWrong.value = true;
          showToast(verifyOtpResponse.message ?? "Invalid OTP");
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

  registerButtonClick(context) async {
    if (formKey.currentState!.validate()) {
      keyboardDismiss(context);
      if (isTermAccepted == false) {
        showToast(appPleaseAcceptTermsConditions);
      } else {
        if (formKey.currentState!.validate()) {

          try {
            progressDialog.show();
            var params = {
              "fname": "${firstNameData}" ??"",
              "lname": "${lastNameData}" ?? "",
              "email": "${emailData.value}" ?? "",
              "phone": "${mobileNumberData.value}" ?? "",
              "country": "${countryName}" ?? "",
              "referral_code":"${refralCode}"  ?? ""
            };
            IndividualSignupModel individualSignUpModel =
            await ApiProvider.base().individualSignUp(params);
            progressDialog.dismissLoader();
            if (individualSignUpModel.status == true) {


              await writeStorageData(
                  key: deviceAccessToken,
                  value: individualSignUpModel.data?.loginauth ?? "");
              await writeStorageData(
                  key: profileImage,
                  value: individualSignUpModel.data?.profile ?? "");
              await writeStorageData(
                  key: firstName, value: individualSignUpModel.data?.fname ?? "");
              await writeStorageData(
                  key: lastName, value: individualSignUpModel.data?.lname ?? "");
              await writeStorageData(
                  key: lastName, value: individualSignUpModel.data?.phone ?? "");
              await writeStorageData(
                  key: userId, value: individualSignUpModel.data?.individualId ?? "");
              await writeStorageData(
                  key: lastName, value: individualSignUpModel.data?.email ?? "");
              await writeStorageData(
                  key: profession,
                  value: individualSignUpModel.data?.profileDescription ?? "");
              await writeStorageData(
                  key: id, value: individualSignUpModel.data?.id.toString() ?? "");
              await writeStorageData(
                  key: slug, value: individualSignUpModel.data?.slug ?? "");
              await writeStorageData(
                  key: userType, value: individualSignUpModel.data?.userType ?? "");


              Get.offNamed(AppRoutes.bottomNavBar);

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
  companySignUpSendButton(context)async{
    if (formKey.currentState!.validate()) {
      keyboardDismiss(context);
      if (isTermAccepted == false) {
        showToast(appPleaseAcceptTermsConditions);
      } else {
        if (formKey.currentState!.validate()) {

          try {
            progressDialog.show();
            var params = {



              // "contact_person":"firstNameData"??"",
              "company_name":"${companyName.value}"?? "",
              "email": "${emailData.value}" ?? "",
              "phone": "${mobileNumberData.value}" ?? "",
              "country": "${countryName}" ?? "",
              "referral_code":"${refralCode}"  ?? ""

            };
            CompanySignup companySignUpModel = await ApiProvider.base().companySignUp(params);
            progressDialog.dismissLoader();
            if (companySignUpModel.status == true) {


              await writeStorageData(
                  key: deviceAccessToken,
                  value: companySignUpModel.data?.loginauth ?? "");
              await writeStorageData(
                  key: profileImage,
                  value: companySignUpModel.data?.profile ?? "");
              await writeStorageData(
                  key: firstName, value: companySignUpModel.data?.companyName ?? "");
              await writeStorageData(
                  key: lastName, value: companySignUpModel.data?.email ?? "");
              await writeStorageData(
                  key: userId, value: companySignUpModel.data?.individualId ?? "");
              await writeStorageData(
                  key: userId, value: companySignUpModel.data?.phone ?? "");
              await writeStorageData(
                  key: profession,
                  value: companySignUpModel.data?.profileDescription ?? "");
              await writeStorageData(
                  key: id, value: companySignUpModel.data?.id.toString() ?? "");
              await writeStorageData(
                  key: slug, value: companySignUpModel.data?.slug ?? "");
              await writeStorageData(
                  key: userType, value: companySignUpModel.data?.userType ?? "");


              Get.offNamed(AppRoutes.bottomNavBar);



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
  resendOtp(context) async {
    otpController.clear();
    keyboardDismiss(context);
    try {
      progressDialog.show();
      var params = {"phone": mobileNumberData.value};
      SendOtp sendOtp = await ApiProvider.base().sendOtp(params);
      progressDialog.dismissLoader();
      if (sendOtp.status == true) {
        otpCountDownTimer.value = 30;
        _otpCountDownStart();
        //Get.toNamed(AppRoutes.otp,arguments: {"mobile_number":"${countryCode.value}${phoneController.text}"});
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

  signUpButtonClick(context) {
    Get.offNamed(AppRoutes.startUpSignup);
  }

  onBack({required bool isLogin}) {
    if (isEmailVerificationData.value == true) {
      Get.offNamed(AppRoutes.accountVerification);
    } else if (isLogin == false) {
      Get.offNamed(AppRoutes.signup);
    } else if (isEmailVerificationData.value == true) {
      Get.offNamed(AppRoutes.profile);
    } else if (screenNameData.value == dashboard) {
      Get.offNamed(AppRoutes.bottomNavBar);
    } else {

      Get.offNamed(AppRoutes.login);
    }
  }

  void _otpCountDownStart() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (otpCountDownTimer.value > 0) {
        otpCountDownTimer.value--;
      } else {
        timer.cancel(); // Stop timer when countdown reaches 0
      }
    });
  }

  verifyEmailOtpAPiCall(context) async {
    keyboardDismiss(context);
    if (formKey.currentState!.validate()) {
      if (otpController.text.length < 6) {
        showToast(appOtpMustBeSixDigit);
      } else {
        try {
          progressDialog.show();
          var formData = dio.FormData.fromMap({
            "email": mobileNumberData.value,
            "otp": otpController.text,
            "login": 1,
          });
          SaveUserProfileModel sendOtp =
          await ApiProvider.baseWithToken().verifyEmailOTP(formData);

          if (sendOtp.status == true) {
            progressDialog.dismissLoader();
            Get.offNamed(AppRoutes.profile);
            // await writeStorageData(key: deviceAccessToken, value: sendOtp.data?.loginauth??"");
            // await writeStorageData(key: profileImage, value: sendOtp.data?.profile??"");
            // await writeStorageData(key: firstName, value: sendOtp.data?.fName??"");
            // await writeStorageData(key: lastName, value: sendOtp.data?.lName??"");
            // await writeStorageData(key: userId, value: sendOtp.data?.individualId??"");
            // await writeStorageData(key: profession, value: sendOtp.data?.profileDescription??"");
            // progressDialog.dismissLoader();
            // Get.offNamed(AppRoutes.bottomNavBar);
          } else {
            isOtpWrong.value = true;
            showToast(sendOtp.messages ?? "");
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

  _autoFilledOtpHandle() async {
    // 🔹 Request SMS Permission Only if Not Granted
    if (await Permission.sms.isDenied || await Permission.phone.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.sms,
        Permission.phone,
      ].request();

      if (statuses[Permission.sms]!.isPermanentlyDenied ||
          statuses[Permission.phone]!.isPermanentlyDenied) {
        openAppSettings(); // Prompt user to enable from settings
      }
    }
    // 🔹 Initialize OTP Text Field Controller
    otpTextController = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        otpController.text = code; // 🔥 Set OTP in controller
      },
    )..startListenUserConsent((code) {
      final exp = RegExp(r'(\d{6})');
      return exp.stringMatch(code ?? '') ?? '';
    });
  }
}
