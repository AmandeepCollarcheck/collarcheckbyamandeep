import 'dart:io';

import 'package:get/get.dart';

import '../api_provider/api_provider.dart';
import '../models/notification_model.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/common_widget/progress.dart';

class NotificationControllers extends GetxController{
  late ProgressDialog progressDialog=ProgressDialog() ;
  var notificationData=NotificationListModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit

    Future.delayed(Duration(milliseconds: 500), ()async {
      getNotificationApiData();
    });
    super.onInit();
  }

  backButtonClick(){
    Get.offNamed(AppRoutes.bottomNavBar);
  }

  void getNotificationApiData()async {
    try {
      progressDialog.show();
      NotificationListModel notificationListModel = await ApiProvider.baseWithToken().notificationData();
      if(notificationListModel.status==true){
        notificationData.value=notificationListModel;
        await writeStorageData(key: notificationCount, value: notificationData.value.data?.messagecount.toString()??"0");

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