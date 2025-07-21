import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/all_message_data_list_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/progress.dart';

class MessageControllers extends GetxController{
  var searchController =TextEditingController();
  late ProgressDialog progressDialog=ProgressDialog() ;
  Rx isSearchActive=false.obs;
  var allMessageData=AllMessageDataListModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllMessage();
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
  void getAllMessage()async {
    try {
      progressDialog.show();
      AllMessageDataListModel allMessageDataList = await ApiProvider.baseWithToken().allMessageListData();
      if(allMessageDataList.status==true){
        allMessageData.value=allMessageDataList;

      }else{
        showToast(somethingWentWrong);
      }
      progressDialog.dismissLoader();
    } on
    HttpException catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.message);
    } catch (exception) {
      progressDialog.dismissLoader();
      showToast(exception.toString());
    }
  }


  openSearchScreen(context){
    Get.offNamed(AppRoutes.search,arguments: {screenName:messages});
  }
}