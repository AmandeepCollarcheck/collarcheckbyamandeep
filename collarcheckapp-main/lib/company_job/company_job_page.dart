import 'package:collarchek/company_job/company_job_controllers.dart';
import 'package:collarchek/utills/app_key_constent.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/add_employment_bottom_sheet.dart';
import '../utills/common_widget/add_new_job_model_sheet.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/company_common_widget.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class CompanyJobPage extends GetView<CompanyJobControllers>{
  const CompanyJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
          if (!didPop) {
            onWillPop();
          }
        },
        child: Scaffold(
          backgroundColor: appScreenBackgroundColor,
          body: Column(
            children: <Widget>[
              ///Search Widget
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Obx(()=>commonCompanySearchAppBar(
                    context,controller: controller.searchController,
                    actionButtonOne: appNotificationSVGIcon,
                    actionButtonTwo: appSearchIcon,
                    isSearchActive: controller.isSearchActive.value,
                    onChanged: (value){
                      // controller.openSearchScreen(context);
                    },
                    onEmploymentRequestClick: (){
                      Get.offNamed(AppRoutes.companyEmploymentRequest,arguments: {screenName:companyJobsScreen});
                    },
                    onAddEmployment: ()async{
                      final result=await addNewJobForm(context, companyAllDetails: controller.designationListData.value,screenNameData:companyJobsScreen);
                      if(result['result']==true){
                        Future.delayed(Duration(milliseconds: 500), ()async {
                          controller.getJobListApiCall();
                        });
                      }
                    },
                    onTap: (){
                      controller.openSearchScreen(context);
                    },
                    onSearchIconClick: (bool isSearchClick) {
                      controller.isSearchActive.value=isSearchClick;

                    })),
              ),
              SizedBox(height: 20,),
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
                              style: AppTextStyles.font14.copyWith(
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
              Expanded(
                child: Container(
                  color: appPrimaryBackgroundColor,
                  height: MediaQuery.of(context).size.height ,
                  child: TabBarView(
                    // physics: NeverScrollableScrollPhysics(),
                    controller: controller.tabController,
                    children: <Widget>[
                      _openPage(context),
                      _draftPage(context),
                      _completedPage(context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openPage(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var publishData=controller.jobData.value.data?.publishJobs??[];
            return publishData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(publishData.length??0, (index){
                    return commonCompanyJobWidget(context,
                      profileImage: publishData[index].profile??"",
                      initialName:publishData[index].jobTitle??"",
                      userName:publishData[index].jobTitle??"",
                      ccId: publishData[index].individualId??'',
                      ratingStar: '10',
                      buttonName: appAddReview,
                      salary: publishData[index].salaryName??"",
                      experienceYear: publishData[index].experienceName??"",
                      vaccancy: publishData[index].vacancy??"",
                      onClick: () {
                        Get.offNamed(AppRoutes.applicants,arguments: {screenName:companyJobsScreen,jobProfileName:publishData[index].jobTitle??"",jobId:publishData[index].id??"",});
                      },
                      jobStatus: 'Published',
                      noOfVaccency: publishData[index].applicationCount??"",
                      timeAgo: calculateTimeDifference(createDate:  publishData[index].createDate??""),
                      locations: generateLocation(cityName: publishData[index].cityName??"", stateName: publishData[index].stateName??"", countryName: publishData[index].countryName??"",),
                      markAsCompleted: () {
                       controller.markAsCompleteApiCall(context, statusId: publishData[index].id??"",);
                      },
                      isEdit: () {  },
                        isProfileVerified:  publishData[index].isVerified??false,
                        cardWidth: MediaQuery.of(context).size.width*0.92
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

  _draftPage(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var draftData=controller.jobData.value.data?.draftJobs??[];
            return draftData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(draftData.length??0, (index){
                    return commonCompanyJobWidget(context,
                      profileImage: draftData[index].profile??"",
                      initialName: draftData[index].jobTitle??"",
                      userName: draftData[index].jobTitle??"",
                      ccId: draftData[index].individualId??'',
                      ratingStar: '10',
                      buttonName: appAddReview,
                      salary:  draftData[index].salaryName??"",
                      experienceYear:  draftData[index].experienceName??"",
                      vaccancy: draftData[index].vacancy??"",
                      onClick: () {
                        Get.offNamed(AppRoutes.applicants,arguments: {screenName:companyJobsScreen,jobProfileName:draftData[index].jobTitle??"",jobId:draftData[index].id??"",});
                      },
                      jobStatus: controller.tabController.index==1?appInDraft:controller.tabController.index==2?appCompleted:appPublished,
                      noOfVaccency: draftData[index].applicationCount??"",
                      timeAgo: calculateTimeDifference(createDate:  draftData[index].createDate??"",),
                      locations: generateLocation(cityName: draftData[index].cityName??"", stateName: draftData[index].stateName??"", countryName: draftData[index].countryName??"",),
                      markAsCompleted: () {  },
                      isEdit: () {  },
                        isProfileVerified:  draftData[index].isVerified??false,
                        cardWidth: MediaQuery.of(context).size.width*0.92
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
  _completedPage(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var completeData=controller.jobData.value.data?.cancelJobs??[];
            return completeData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(completeData.length??0, (index){
                    return commonCompanyJobWidget(context,
                      profileImage: completeData[index].profile??"",
                      initialName:completeData[index].jobTitle??"",
                      userName: completeData[index].jobTitle??"",
                      ccId: completeData[index].individualId??"",
                      ratingStar: "10",
                      buttonName: appAddReview,
                      salary: completeData[index].salaryName??"",
                      experienceYear: completeData[index].experienceName??"",
                      vaccancy: completeData[index].vacancy??"",
                      onClick: () {
                        Get.offNamed(AppRoutes.applicants,arguments: {screenName:companyJobsScreen,jobProfileName:completeData[index].jobTitle??"",jobId:completeData[index].id??"",});
                      },
                      jobStatus: appCompleted,
                      noOfVaccency: completeData[index].applicationCount??"",
                      timeAgo: calculateTimeDifference(createDate:  completeData[index].createDate??"",),
                      locations: generateLocation(cityName: completeData[index].cityName??"", stateName: completeData[index].stateName??"", countryName: completeData[index].countryName??"",),
                      markAsCompleted: () {  },
                      isEdit: () {  },
                      isProfileVerified:  completeData[index].isVerified??false,
                      cardWidth: MediaQuery.of(context).size.width*0.92
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