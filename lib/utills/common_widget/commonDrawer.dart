import 'dart:io';

import 'package:collarchek/models/logout_model.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../api_provider/api_provider.dart';
import '../app_key_constent.dart';
import '../app_route.dart';
import '../app_strings.dart';
import '../image_path.dart';
class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  Rx profileImageData="".obs;
  Rx userIdData="".obs;
  Rx professionData="".obs;
  Rx profilePercentageData=0.0.obs;
  Rx userNameData="".obs;
  late ProgressDialog progressDialog ;
  @override
  void initState() {
    // TODO: implement initState
    _getAllDataLocally();
    progressDialog = ProgressDialog();
    super.initState();
  }

  _getAllDataLocally() async {
    profileImageData.value=await readStorageData(key: profileImage) ??"";
    userIdData.value=await readStorageData(key: userId) ??"";
    professionData.value=await readStorageData(key: profession) ??"";
    String firstName = await readStorageData(key: 'firstName') ?? "";
    String lastName = await readStorageData(key: 'lastName') ?? "";
    userNameData.value = "$firstName $lastName".trim();
    profilePercentageData.value=(double.tryParse(await readStorageData(key: progressPercentage)) ?? 0.0) / 100;
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appWhiteColor,
      child: Obx(()=>Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30,),
            _profileDetails(),
            SizedBox(height: 20,),
            Container(
              height: 1,
              color: appPrimaryBackgroundColor,
            ),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appRecommendedJob, title: appRecommendJobs, onOptionClick: () {
              Get.offNamed(AppRoutes.recommendJob);
            }),
            SizedBox(height: 10,),
            Container(
              height: 1,
              color: appPrimaryBackgroundColor,
            ),
            SizedBox(height: 20,),
            Container(padding: EdgeInsets.only(left: 10),child: Text(appAccount,style: AppTextStyles.font12.copyWith(color: appGreyBlackColor),)),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appPersonalInfo, title: appPersonalInformation, onOptionClick: () {
              Get.toNamed(AppRoutes.profile);
            }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appRecommendedJob, title: appAppliedJobs, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appConnectionsIcons, title: appConnections, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appSettings, title: appSettingsText, onOptionClick: () {  }),
            SizedBox(height: 10,),
            Container(
              height: 1,
              color: appPrimaryBackgroundColor,
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(appGeneral,style: AppTextStyles.font12.copyWith(color: appGreyBlackColor),),
            ),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appAboutUs, title: appAboutUsText, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appAboutUs, title: appHelpCenter, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appRecommendedJob, title: appCareer, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appFAQ, title: appFAQText, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appPrivacyPolicyIcon, title: appPrivacyPolicy, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appTermUse, title: appTermsOfUse, onOptionClick: () {  }),
            SizedBox(height: 10,),
            Container(
              height: 1,
              color: appPrimaryBackgroundColor,
            ),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appLogout, title: appLogoutText, onOptionClick: () {
              _callingLogoutApi();
            },isPrimaryColor: true),
            SizedBox(height: 10,),
            Container(
              height: 1,
              color: appPrimaryBackgroundColor,
            ),

          ],
        ),
      )),
    );
  }

  _drawerOptionCard({required String icon,required String title ,required Function() onOptionClick,bool isPrimaryColor=false}) {
    return GestureDetector(
      onTap: (){
        onOptionClick();
      },
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: <Widget>[
            Image.asset(icon,height: 24,width: 24,),
            SizedBox(width: 10,),
            Text(title,style: AppTextStyles.font14.copyWith(color: isPrimaryColor?appPrimaryColor:appBlackColor)),
          ],
        ),
      ),
    );
  }

  _profileDetails(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircularPercentIndicator(
          radius: 30.0,
          lineWidth: 2.0,
          percent: profilePercentageData.value,
          backgroundColor: appGreyColor,
          center: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: profileImageData.value != null || profileImageData.value.isNotEmpty?Image.asset(appDummyProfile,height: 64,width: 64,fit: BoxFit.cover,):Image.network(profileImageData.value,height: 64,width: 64,fit: BoxFit.cover,),
          ),
          progressColor: appPrimaryColor,
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userNameData.value!=null&&userNameData.value.isNotEmpty?  Text(userNameData.value,style: AppTextStyles.font16W700.copyWith(color: appBlackColor)):Container(),
            userIdData.value!=null&&userIdData.value.isNotEmpty? Text("$appId: ${userIdData.value}",style: AppTextStyles.font12.copyWith(color: appPrimaryColor)):Container(),
            professionData.value!=null&&professionData.value.isNotEmpty? Text(professionData.value,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor)):Container(),
            SizedBox(height: 5,),
            GestureDetector(
              onTap: (){},
              child: Text(appViewAndUpdateProfile,style: AppTextStyles.font14.copyWith(color: appPrimaryColor)),
            )
          ],
        )
      ],
    );
  }

   _callingLogoutApi() async{
     try {
       progressDialog.show();
       LogoutModel logoutModel = await ApiProvider.baseWithToken().logout();
       progressDialog.dismissLoader();
       if (logoutModel.status == true) {
         await GetStorage().erase();
         Get.offNamed(AppRoutes.startup,);
       } else {
         showToast(logoutModel.message);
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
