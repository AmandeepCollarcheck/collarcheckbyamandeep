import 'dart:io';

import 'package:collarchek/models/logout_model.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_image_widget.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../api_provider/api_provider.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller.dart';
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
  Rx profileDesignation="".obs;
  Rx userIdData="".obs;
  Rx professionData="".obs;
  Rx profilePercentageData=0.0.obs;
  Rx userNameData="".obs;
  late ProgressDialog progressDialog ;
  final BottomNavBarController controller = Get.find<BottomNavBarController>();

  @override
  void initState() {
    // TODO: implement initState
    _getAllDataLocally();
    progressDialog = ProgressDialog();
    super.initState();
  }

  _getAllDataLocally() async {
    profileImageData.value=await readStorageData(key: profileImage) ??"";
    profileDesignation.value=await readStorageData(key: profileDesignationData) ??"";
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
            _drawerOptionCard(icon: appRecommendedIconSvg, title: controller.userTypeData.value==company?appRecommendedCandidates:appRecommendJobs, onOptionClick: () {
              Get.back();
              Get.offNamed(AppRoutes.recommendJob);
            }),
            SizedBox(height: 10,),
            Container(
              height: 1,

              color: appPrimaryBackgroundColor,
            ),
            SizedBox(height: 20,),
            Container(padding: EdgeInsets.only(left: 10),child: Text(appAccount,style: AppTextStyles.font12.copyWith(color: appGreyBlackColor),)),
            controller.userTypeData.value==company?SizedBox(height: 0,):SizedBox(height: 10,),
            // _drawerOptionCard(icon: appPersonalInfo, title: appPersonalInformation, onOptionClick: () {
            //   Get.back();
            //   Get.toNamed(AppRoutes.profile);
            // }),
            // SizedBox(height: 10,),
            controller.userTypeData.value==company?Container(): _drawerOptionCard(icon: appRecommendedIconSvg, title: appAppliedJobs, onOptionClick: () {
              Get.back();
              controller.bottomNavCurrentIndex.value=2;
              controller.selectedTabIndexValue.value=1;
            }),


            SizedBox(height: 10,),

            ///My employee
            _drawerOptionCard(icon: appMyConnectionIconSvg, title: controller.userTypeData.value==company?appMyEmployees:appMyConnections, onOptionClick: () {
              Get.back();
              controller.bottomNavCurrentIndex.value=1;
              //Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
            }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appConnectionRequestIconSvg, title: controller.userTypeData.value==company?appEmployeeRequests:appConnectionsRequest, onOptionClick: () {
              Get.back();
              if(controller.userTypeData.value==company){
                Get.offNamed(AppRoutes.companyEmploymentRequest,arguments: {screenName:dashboard});
              }else{
                Get.offNamed(AppRoutes.request,arguments: {screenName:dashboard});
              }

            }),

            ///my connections
            controller.userTypeData.value==company?SizedBox(height: 10,):SizedBox(height: 0,),
            controller.userTypeData.value==company?_drawerOptionCard(icon: appMyConnectionIconSvg, title: appMyConnections, onOptionClick: () {
              Get.back();

              Get.offNamed(AppRoutes.mycompanyconnection,arguments: {bottomNavCurrentIndexData:"1"});
            //  controller.bottomNavCurrentIndex.value=1;
              //Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
            }):Container(),
            controller.userTypeData.value==company?SizedBox(height: 10,):SizedBox(height: 0,),
            controller.userTypeData.value==company?_drawerOptionCard(icon: appReviewRequestSvg, title: appReviewRequests, onOptionClick: () {
              if(controller.userTypeData.value==company){
                Get.back();
                Get.offNamed(AppRoutes.companyAllReview,arguments: {screenName:companyDashboardScreen});
              }else{
                Get.back();
                controller.bottomNavCurrentIndex.value=1;
              }

              //Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
            }):Container(),
            controller.userTypeData.value==company?SizedBox(height: 10,):SizedBox(height: 0,),
            controller.userTypeData.value==company?_drawerOptionCard(icon: appPostJobSvg, title: appPostJob, onOptionClick: () {
              Get.back();
              controller.bottomNavCurrentIndex.value=1;
              //Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
            }):Container(),

            SizedBox(height: 10,),
            _drawerOptionCard(icon: controller.userTypeData.value==company?appMyConnectionIconSvg:appSalaryRequestIconSvg, title: controller.userTypeData.value==company?appSavedCandidates:appSalaryRequest, onOptionClick: () {
              Get.back();
              Get.offNamed(AppRoutes.request,arguments: {screenName:dashboard,tabSelectionIndexValue:1});
            }),

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
            _drawerOptionCard(icon: appAboutUsIconSvg, title: appAboutUsText, onOptionClick: () {  }),

            SizedBox(height: 10,),
            _drawerOptionCard(icon: appBestPracticsIconSvg, title: appBestPractices, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appTermUseIconSvg, title: appTermsOfUse, onOptionClick: () {  }),

            SizedBox(height: 10,),
            _drawerOptionCard(icon: appNotificationSettingsIconSvg, title: appNotificationSettings, onOptionClick: () {  }),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appSettingsIconIconSvg, title: appGeneralSettings, onOptionClick: () {


              Get.offNamed(AppRoutes.accountsettings,arguments: {bottomNavCurrentIndexData:"1"});

            }),
            SizedBox(height: 10,),
            // _drawerOptionCard(icon: appSettings, title: appSettingsText, onOptionClick: () {  }),
            // SizedBox(height: 10,),
            // _drawerOptionCard(icon: appPrivacyPolicyIcon, title: appPrivacyPolicy, onOptionClick: () {  }),
            // SizedBox(height: 10,),
            // _drawerOptionCard(icon: appTermUse, title: appTermsOfUse, onOptionClick: () {  }),
            // SizedBox(height: 10,),
            Container(
              height: 1,
              color: appPrimaryBackgroundColor,
            ),
            SizedBox(height: 10,),
            _drawerOptionCard(icon: appLogoutIconSvg, title: appLogoutText, onOptionClick: () {
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
            icon.contains(".svg")?SvgPicture.asset(icon,height: 16,width: 16,):Image.asset(icon,height: 24,width: 24,),
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
            child: commonImageWidget(image: controller.profileImageData.value??"", initialName: userNameData.value??"", height: 64, width: 64, borderRadius: 100,isBorderDisable: true),
            //child: controller.profileImageData.value.isNotEmpty?Image.network(controller.profileImageData.value,height: 64,width: 64,fit: BoxFit.cover,):Image.asset(appDummyProfile,height: 64,width: 64,fit: BoxFit.cover,),
          ),
          progressColor: appPrimaryColor,
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userNameData.value!=null&&userNameData.value.isNotEmpty?  Text(userNameData.value,style: AppTextStyles.font16W700.copyWith(color: appBlackColor)):Container(),
            userIdData.value!=null&&userIdData.value.isNotEmpty? Text("$appId: ${userIdData.value}",style: AppTextStyles.font12.copyWith(color: appPrimaryColor)):Container(),
            profileDesignation.value!=null&&profileDesignation.value.isNotEmpty? Text(profileDesignation.value,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor)):Container(),
            SizedBox(height: 5,),
            GestureDetector(
              onTap: (){
                Get.back();
                controller.bottomNavCurrentIndex.value=4;
              },
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
