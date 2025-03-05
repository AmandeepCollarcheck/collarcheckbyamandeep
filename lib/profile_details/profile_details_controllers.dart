import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_provider/api_provider.dart';
import '../models/user_profile_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/progress.dart';

class  ProfileDetailsControllers extends GetxController with GetTickerProviderStateMixin{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var userProfileData=UserProfileModel().obs;
  late final TabController tabController;


  var listTabLabel = [
    appHome, appEmploymentHistory, appPortfolio,appEducation
  ].obs;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getProfileApiCall();
    });
    super.onInit();
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      200 + random.nextInt(56),
      200 + random.nextInt(56),
      200 + random.nextInt(56),
    );
  }

  void getProfileApiCall() async{
    try {
      progressDialog.show();
      String firstname =await GetStorage().read(firstName);
      String lastname =await GetStorage().read(lastName);
      final userName=("$firstname-$lastname").replaceAll(" ", "");
      UserProfileModel userProfileModel = await ApiProvider.baseWithToken().userProfile(userName: userName);
      if(userProfileModel.status==true){
        userProfileData.value=userProfileModel;
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