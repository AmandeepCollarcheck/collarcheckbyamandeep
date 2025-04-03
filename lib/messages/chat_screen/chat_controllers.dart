import 'dart:io';

import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../api_provider/api_provider.dart';
import '../../models/all_message_data_list_model.dart';
import '../../models/save_user_profile_model.dart';
import '../../utills/common_widget/image_multipart.dart';
import '../../utills/common_widget/progress.dart';

class ChatControllers extends GetxController{

  var allMessageData=AllMessageDataListModel().obs;
  var messageDatum=MessageDatum().obs;
  var screenNameData="".obs;
  var receiverIdData="".obs;
  var senderIdData="".obs;
  var appBarName="".obs;
  var profileImage="".obs;
  var  messageController = TextEditingController();
  var selectedDocumentData="".obs;

  var argumentTypeDataDetails="".obs;
  var messagesData = <String>[].obs; // Observable list of messages




 @override
  void onInit() {
    // TODO: implement onInit
   Map<String,dynamic> data=Get.arguments??{};
   if(data.isNotEmpty){
     screenNameData.value=data[screenName]??"";
     appBarName.value=data[messageReceiverName]??"";
     profileImage.value=data[profileImageData]??"";
     receiverIdData.value=data[receiverId]??"";
     senderIdData.value=data[senderId]??"";
     argumentTypeDataDetails.value=data[argumentTypeData]??"";
   }
   Future.delayed(Duration(milliseconds: 500), ()async {
     getAllMessage();
   });
    super.onInit();
  }


 backButtonClick(context){

   if(screenNameData.value==messages){
     Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"3"});
   }else if(screenNameData.value==profileDetails){
     Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
   }else if(screenNameData.value==connections){
     Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
   }else if(screenNameData.value==topCompaniesScreen){
     Get.offNamed(AppRoutes.topCompanies,arguments: {argumentTypeData:argumentTypeDataDetails.value});
   } else{
     Get.offNamed(AppRoutes.bottomNavBar,);
   }
 }

  void sendMessage(String message) async{
    if (message.trim().isNotEmpty) {
      messagesData.insert(0, message);

      try {
        var documentFile = await convertFileToMultipart(selectedDocumentData.value ?? "");
        var formData = dio.FormData.fromMap({
          "send_to": receiverIdData.value??"",
          "message": message,
          "doc[0]":documentFile??"",

        });
        SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().sendMessage(formData);
        if(addSkillsData.status==true){
          Future.delayed(Duration(milliseconds: 10), ()async {
            getAllMessage();
          });
        }else{
          showToast(somethingWentWrong);
        }
      } on HttpException catch (exception) {
        showToast(exception.message);
      } catch (exception) {
        showToast(exception.toString());
      }
    }
    }

  void getAllMessage()async {
    try {
      AllMessageDataListModel allMessageDataList = await ApiProvider.baseWithToken().allMessageListData();
      if(allMessageDataList.status==true){
        allMessageData.value=allMessageDataList;

        messageDatum.value = allMessageData.value.data!.firstWhere(
              (chat) => chat.receiver == receiverIdData.value,
          orElse: () => MessageDatum(), // Return null if not found
        );



      }else{
        showToast(somethingWentWrong);
      }
    } on
    HttpException catch (exception) {
      showToast(exception.message);
    } catch (exception) {
      showToast(exception.toString());
    }
  }


}