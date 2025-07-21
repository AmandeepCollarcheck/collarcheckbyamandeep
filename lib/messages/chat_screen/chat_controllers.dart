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
  late ProgressDialog progressDialog=ProgressDialog() ;
  var allMessageData=AllMessageDataListModel().obs;
  var messageDatum=MessageDatum().obs;
  var screenNameData="".obs;
  var receiverIdData="".obs;
  var senderIdData="".obs;
  var appBarName="".obs;
  var profileImage="".obs;
  var  messageController = TextEditingController();
  var selectedDocumentData="".obs;
  var selectedFileName="".obs;

  var argumentTypeDataDetails="".obs;
  var messagesData = <String>[].obs; // Observable list of messages
  var slugDataId="".obs;
  final GlobalKey menuKey = GlobalKey();





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
     slugDataId.value=data[slugId]??"";
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
   }else if(screenNameData.value==otherCompanyProfileScreen){
     Get.offNamed(AppRoutes.otherCompanyProfilePage,arguments: {screenName:companyProfileScreen,slugId:slugDataId.value});
   }else if(screenNameData.value==searchScreen){
     Get.offNamed(AppRoutes.search,arguments: {screenName:dashboard});
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

  ///Follow api
  companyFollowApiCall(context,{required String companyId,required String userId})async{
    try {
      progressDialog.show();
      var formData = dio.FormData.fromMap({
        "follower_id":userId??"",
        // "int-id":companyId??"0",
      });
      SaveUserProfileModel addSkillsData = await ApiProvider.baseWithToken().followCompany(formData);
      if(addSkillsData.status==true){
        //Get.offNamed(AppRoutes.bottomNavBar);s
        Future.delayed(Duration(milliseconds: 500), ()async {
          getAllMessage();
        });

      }else{
        showToast(addSkillsData.messages??"");
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