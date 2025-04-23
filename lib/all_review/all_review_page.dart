import 'package:collarchek/all_review/all_review_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/company_common_widget.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class AllReviewPage extends GetView<AllReviewControllers>{
  const AllReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: appWhiteColor,
     body:  SafeArea(
         child: Container(
           height: MediaQuery.of(context).size.height,
           color: appPrimaryBackgroundColor,
           child: SingleChildScrollView(
             child: Column(
               children: <Widget>[
                 commonActiveSearchBar(
                     onClick: (){
                       controller.backButtonClick(context);
                     }, onShareClick: (){}, onFilterClick: (){}, leadingIcon: appBackSvgIcon, screenName: appAllReviews, actionButton: ''),
                 SizedBox(height: 10,),
                 Obx(()  {
                   var allReviewData=controller.companyAllReviewData.value.data??[];
                   return allReviewData.isNotEmpty?Container(
                       padding: EdgeInsets.all(10),
                       child:Wrap(
                         children: List.generate(allReviewData.length??0, (index){
                           return commonCompanyReviewWidget(
                               context,
                               profileImage:allReviewData[index].profile??"",
                               username:allReviewData[index].user??"",
                               designation:allReviewData[index].designation??"",
                               ratingsStar:allReviewData[index].rating.toString()??"",
                               isProfileVerified:allReviewData[index].isVerified??false,
                               buttonName:appAllReviews,
                               onClick:(){
                                 Get.offNamed(AppRoutes.userSpecificReview,arguments: {screenName:companyAllReviewScreen,jobProfileName:allReviewData[index].user??"",userId:allReviewData[index].userId.toString()??""});
                               },
                               noOfReview:allReviewData[index].noofrecord.toString()??"",
                               pendingReview:allReviewData[index].pendingReview.toString()??"",
                           );
                         }),
                       )
                   ):SizedBox(
                       height: MediaQuery.of(context).size.height*0.65,
                       child: Center(
                         child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                       )
                   );
                 }),
                 Container(
                   //color: appPrimaryColor,
                   alignment: Alignment.bottomCenter,
                   child: allRightReservedWidget(),
                 )
               ],
             ),
           ),
         )
     ),
   );
  }

}