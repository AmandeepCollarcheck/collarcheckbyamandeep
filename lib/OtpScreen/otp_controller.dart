import 'dart:async';
import 'dart:io';

import 'package:collarchek/models/verify_otp_model.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';

import 'package:get_storage/get_storage.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../api_provider/api_provider.dart';
import '../models/save_user_profile_model.dart';
import '../models/send_otp_model.dart';
import 'package:get/get.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';

class OtpController extends GetxController{
  final formKey = GlobalKey<FormState>();
  late ProgressDialog progressDialog=ProgressDialog() ;
  var otpController = TextEditingController();
  final scaffoldKey = GlobalKey();
  late OTPInteractor _otpInteractor;

  Rx mobileNumberData="".obs;
  Rx isLoginScreenData=false.obs;
  Rx isEmailVerificationData=false.obs;
  Rx otpCountDownTimer=30.obs;
  Timer? _timer;
  Rx screenNameData="".obs;


  @override
  void onInit() {
    final Map<String, dynamic> data = Get.arguments??{};
    if(data.isNotEmpty){
      mobileNumberData.value=data[mobileNumber]??"";
      isLoginScreenData.value=data[isLoginScreen]??false;
      isEmailVerificationData.value=data[isEmailVerification]??false;
      screenNameData.value=data[dashboard]??"";
    }
    _autoFilledOtpHandle();
    _otpCountDownStart();
    super.onInit();
  }
  @override
  void dispose() {
    otpController.dispose();
    SmsAutoFill().unregisterListener();
    _timer?.cancel();
    super.onClose();
  }
  loginButtonClick(context) async {
    keyboardDismiss(context);
    if (formKey.currentState!.validate()) {
      if (otpController.text.length < 6) {
        showToast(appOtpMustBeSixDigit);
      } else {
        try {
          progressDialog.show();
          var formData = dio.FormData.fromMap({
            "phone": mobileNumberData.value,
            "otp": otpController.text,
            "login": 1,
          });
          VerifyOtp sendOtp = await ApiProvider.base().verifyOtp(formData);

          if (sendOtp.status == true) {
            await writeStorageData(key: deviceAccessToken, value: sendOtp.data?.loginauth??"");
            await writeStorageData(key: profileImage, value: sendOtp.data?.profile??"");
            await writeStorageData(key: firstName, value: sendOtp.data?.fName??"");
            await writeStorageData(key: lastName, value: sendOtp.data?.lName??"");
            await writeStorageData(key: userId, value: sendOtp.data?.individualId??"");
            await writeStorageData(key: profession, value: sendOtp.data?.profileDescription??"");
            await writeStorageData(key: id, value: sendOtp.data?.id??"");
            await writeStorageData(key: slug, value: sendOtp.data?.slug??"");
            await writeStorageData(key: userType, value: sendOtp.data?.userType??"");
            progressDialog.dismissLoader();
            Get.offNamed(AppRoutes.bottomNavBar);
          } else {
            progressDialog.dismissLoader();
            final canVibrate = await Haptics.canVibrate();
            await Haptics.vibrate(HapticsType.error);
            showToast(sendOtp.message??"");
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
  resendOtp(context) async {
    otpController.clear();
    keyboardDismiss(context);
        try {
          progressDialog.show();
          var params = {
            "phone": mobileNumberData.value
          };
          SendOtp sendOtp = await ApiProvider.base().sendOtp(params);
          progressDialog.dismissLoader();
          if (sendOtp.status == true) {
            otpCountDownTimer.value=30;
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
  signUpButtonClick(context){
    Get.offNamed(AppRoutes.startUpSignup);
  }
  onBack({required bool isLogin}){
    if(isEmailVerificationData.value==true){
      Get.offNamed(AppRoutes.accountVerification);
    }else if(isLogin==false){
      Get.offNamed(AppRoutes.signup);
    }else if(isEmailVerificationData.value==true){
      Get.offNamed(AppRoutes.profile);
    }else if(screenNameData.value==dashboard){
      Get.offNamed(AppRoutes.bottomNavBar);
    }else{
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

  verifyEmailOtpAPiCall(context)async{
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
          SaveUserProfileModel sendOtp = await ApiProvider.baseWithToken().verifyEmailOTP(formData);

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
            showToast(sendOtp.messages??"");
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
      await Permission.sms.request();
      await Permission.phone.request();
    }

    // 🔹 Initialize OTP Text Field Controller
    otpController = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        print('Received OTP: $code');
        otpController.text = code; // 🔥 Set OTP in controller
        update(); // 🔥 Force UI Update in GetX
      },
    )..startListenUserConsent((code) {
      final exp = RegExp(r'(\d{6})');
      return exp.stringMatch(code ?? '') ?? '';
    });

    print("Listening for OTP...");

    // 🔹 Start listening for OTP using SmsAutoFill
    await SmsAutoFill().listenForCode();

    // 🔹 Listen for OTP changes
    SmsAutoFill().code.listen((otp) {
      if (otp.isNotEmpty) {
        otpController.text = otp;
        update(); // 🔥 Force UI Update
        print("Updated OTP: $otp");
      }
    });
  }




}