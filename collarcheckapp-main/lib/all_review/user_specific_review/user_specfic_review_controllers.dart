import 'dart:io';

import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api_provider/api_provider.dart';
import '../../models/company_all_review_model.dart';
import '../../models/company_user_specific_review_model.dart';
import '../../models/save_user_profile_model.dart';
import '../../utills/app_key_constent.dart';
import '../../utills/app_route.dart';
import '../../utills/common_widget/progress.dart';
import '../../utills/image_path.dart';

class UserSpecificReviewControllers extends GetxController with GetTickerProviderStateMixin{
  late final TabController tabController;
  late ProgressDialog progressDialog=ProgressDialog() ;
  var companyAllReviewData=CompanyUserSpecificReviewModel().obs;
  var screenNameData="".obs;
  var userName="".obs;
  var selectedTabIndex=0.obs;
  var userIdData="0".obs;
  var listTabCounter=["0","0","0"].obs;
  var listTabLabel = [
    appReviews,appPendingReviews,appApprovedReviews
  ].obs;

  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    Map<String,dynamic> data=Get.arguments??{};
    if(data.isNotEmpty){
      screenNameData.value=data[screenName]??"";
      userName.value=data[jobProfileName]??"";
      userIdData.value=data[userId]??"0";
    }
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(milliseconds: 500), ()async {
      getAllReviewApiCall();
    });
  }
  void onTabSelected(int index) {
    selectedTabIndex.value = index;
  }


  backButtonClick(context){
    if(screenNameData.value==companyAllReviewScreen){
      Get.offNamed(AppRoutes.companyAllReview);
    }
  }




  void getAllReviewApiCall() async{
    try {
      progressDialog.show();
      CompanyUserSpecificReviewModel companyAllReviewModel = await ApiProvider.baseWithToken().companyUserSpecificAllReview(userIdData.value);
      if(companyAllReviewModel.status==true){
        companyAllReviewData.value=companyAllReviewModel;
        var allReviews=companyAllReviewData.value.data!.allcount.toString();
        var pendingReviews=companyAllReviewData.value.data!.pendingCount.toString();
        var approvedReviews=companyAllReviewData.value.data!.activeCount.toString();
        listTabCounter.clear();
        listTabCounter.add(allReviews);
        listTabCounter.add(pendingReviews);
        listTabCounter.add(approvedReviews);

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



  openHistoryDialog(BuildContext context,{required List<History> historyData}) {
    return Get.dialog(
      Dialog(
        backgroundColor: appScreenBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Wrap(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        appReviewsHistory,
                        style: AppTextStyles.font14.copyWith(color: appBlackColor),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                          child: SvgPicture.asset(appCloseIconWithCircularBorderSvgIcon,height: 25,width: 25,))
                    ],
                  ),
                  SizedBox(height: 10,),
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context,int index){
                      return Container(height: 10,);
                    },
                    itemCount: historyData.length,
                    itemBuilder: (BuildContext context,int index){
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: appPrimaryBackgroundColor,width: 1)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    commonRattingBar(context, initialRating: double.parse(historyData[index].rating.toString()), updatedRating: (value){},ignoreGesture: true,size: 16),
                                    SizedBox(width: 5,),
                                    Text((double.parse(historyData[index].rating.toString()).toString()),style: AppTextStyles.font16W600.copyWith(color: appBlackColor),)

                                  ],
                                ),
                                Text(formatDate(date: historyData[index].modifyDate.toString()??""),style: AppTextStyles.font12.copyWith(color: appPrimaryColor),)
                              ],
                            ),
                            SizedBox(height: 5,),
                            commonReadMoreWidget(context, message: historyData[index].review??"", textStyle: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor)),
                            SizedBox(height: 10,),
                            historyData[index].link!.isNotEmpty?GestureDetector(
                              onTap: () async {
                                String link = historyData[index].link.toString()??"";
                                if(historyData[index].link!=null&&historyData[index].link!.isNotEmpty){
                                  final Uri _url = Uri.parse(link.startsWith('http') ? link : 'https://$link');
                                  if (!await launchUrl(_url)) {
                                    throw Exception('Could not launch $_url');
                                  }
                                }else{
                                  showToast(appNoAnyLinkAvailable);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: appPrimaryColor
                                ),
                                child:  Text(appViewMore,style: AppTextStyles.font12.copyWith(color: appWhiteColor),),
                              ),
                            ):Container(),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ) ,
            )
          ],
        ),
      ),
    );
  }


  acceptRatingApiCall(context,{required String id})async{
    try {
      progressDialog.show();
      SaveUserProfileModel acceptEmployment = await ApiProvider.baseWithToken().acceptCompanyEmployment(id: id);
      if(acceptEmployment.status==true){
        Future.delayed(Duration(milliseconds: 500), ()async {
          getAllReviewApiCall();
        });
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

  rejectRatingApiCall(context,{required String id})async{
    try {
      progressDialog.show();
      SaveUserProfileModel acceptEmployment = await ApiProvider.baseWithToken().rejectCompanyEmployment(id: id);
      if(acceptEmployment.status==true){
        Future.delayed(Duration(milliseconds: 500), ()async {
          getAllReviewApiCall();
        });
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