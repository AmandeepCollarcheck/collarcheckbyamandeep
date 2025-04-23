import 'package:collarchek/all_review/user_specific_review/user_specfic_review_controllers.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../utills/app_colors.dart';
import '../../utills/app_strings.dart';
import '../../utills/common_widget/common_appbar.dart';
import '../../utills/common_widget/common_methods.dart';
import '../../utills/common_widget/company_common_widget.dart';
import '../../utills/font_styles.dart';
import '../../utills/image_path.dart';

class UserSpecificReviewPage  extends GetView<UserSpecificReviewControllers>{
  const UserSpecificReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhiteColor,
      body:  SafeArea(
          child: Column(
            children: <Widget>[
              commonActiveSearchBar(
                  onClick: (){
                    controller.backButtonClick(context);
                  }, onShareClick: (){}, onFilterClick: (){}, leadingIcon: appBackSvgIcon, screenName: '$appReviewsFor${controller.userName}', actionButton: ''),
              Container(
                color: appWhiteColor,
                padding:EdgeInsets.zero,
                child: Obx(() {
                  return TabBar(
                    labelPadding: EdgeInsets.only(bottom: 10),
                    isScrollable: false,
                    dividerColor: appWhiteColor,
                    indicatorColor: appPrimaryColor,
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: controller.tabController,
                    tabs: List.generate(controller.listTabLabel.length, (index) {
                      return Obx(() {
                        bool isSelected = controller.selectedTabIndex.value == index;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              controller.listTabLabel[index],
                              style: AppTextStyles.font12.copyWith(
                                color: isSelected ? appPrimaryColor : appBlackColor,
                              ),
                            ),
                            SizedBox(width: 2),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? appPrimaryColor : appGreyBlackColor,
                              ),
                              child: Text(
                                controller.listTabCounter[index].toString(),
                                style: AppTextStyles.font10.copyWith(color: appWhiteColor),
                              ),
                            ),

                          ],
                        );
                      });
                    }),
                  );
                }),

              ),
              ///TabBarView
              Expanded(
                child: Container(
                  color: appPrimaryBackgroundColor,
                  height: MediaQuery.of(context).size.height ,
                  child: TabBarView(
                    // physics: NeverScrollableScrollPhysics(),
                    controller: controller.tabController,
                    children: <Widget>[
                      _reviewsPage(context),
                       _pendingReviewsPage(context),
                       _appRovedReviewsPage(context)
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  _reviewsPage(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var allReviewsData=controller.companyAllReviewData.value.data?.allEmployee??[];
            return allReviewsData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(allReviewsData.length??0, (index){
                    return commonCompanyUserReviewWidget(
                      context,
                      profileImage:allReviewsData[index].profile??"",
                      username:allReviewsData[index].user??"",
                      designation:allReviewsData[index].designation??"",
                      ratingsStar:allReviewsData[index].rating.toString()??"",
                      isProfileVerified:allReviewsData[index].isVerified??false,
                      date:formatDate(date: allReviewsData[index].lastEdit.toString()??""),
                      onClick:(){},
                      noOfReview:"",
                      pendingReview:"",
                      description: 's sjffd gd f g g f d f g f f  f g sdgsdf hsfj jhsfbn hjasn js bas aj hjf af ahhfsd sdd sd dg gsd dg gg gf f gf f gf g g g f f ',
                      buttonName: allReviewsData[index].edits==1?appEditReview:appAccept,
                      isEditReview: allReviewsData[index].edits==1?true:false,
                      onAcceptOrEditReview: () {  },
                      onReject: () {  },
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
    );
  }

  _pendingReviewsPage( context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var allReviewsData=controller.companyAllReviewData.value.data?.pendingData??[];
            return allReviewsData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(allReviewsData.length??0, (index){
                    return commonCompanyUserReviewWidget(
                      context,
                      profileImage:allReviewsData[index].profile??"",
                      username:allReviewsData[index].user??"",
                      designation:allReviewsData[index].designation??"",
                      ratingsStar:allReviewsData[index].rating.toString()??"",
                      isProfileVerified:allReviewsData[index].isVerified??false,
                      date:formatDate(date: allReviewsData[index].lastEdit.toString()??""),
                      onClick:(){},
                      noOfReview:"",
                      pendingReview:"",
                      description: 's sjffd gd f g g f d f g f f  f g sdgsdf hsfj jhsfbn hjasn js bas aj hjf af ahhfsd sdd sd dg gsd dg gg gf f gf f gf g g g f f ',
                      buttonName: appAccept
                      ,
                      isEditReview: allReviewsData[index].edits==1?true:false,
                      onAcceptOrEditReview: () {  },
                      onReject: () {  },
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
    );
  }

  _appRovedReviewsPage( context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var allReviewsData=controller.companyAllReviewData.value.data?.completeData??[];
            return allReviewsData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(allReviewsData.length??0, (index){
                    return commonCompanyUserReviewWidget(
                      context,
                      profileImage:allReviewsData[index].profile??"",
                      username:allReviewsData[index].user??"",
                      designation:allReviewsData[index].designation??"",
                      ratingsStar:allReviewsData[index].rating.toString()??"",
                      isProfileVerified:allReviewsData[index].isVerified??false,
                      date:formatDate(date: allReviewsData[index].lastEdit.toString()??""),
                      onClick:(){},
                      noOfReview:"",
                      pendingReview:"",
                      description: 's sjffd gd f g g f d f g f f f g sdgsdf hsfj jhsfbn hjasn js bas aj hjf af ahhfsd sdd sd dg gsd dg gg gf f gf f gf g g g f f ',
                      buttonName: appAccept
                      ,
                      isEditReview: allReviewsData[index].edits==1?true:false,
                      onAcceptOrEditReview: () {  },
                      onReject: () {  },
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
    );
  }

}
