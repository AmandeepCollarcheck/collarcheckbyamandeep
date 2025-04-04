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
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/company_common_widget.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class CompanyJobPage extends GetView<CompanyJobControllers>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
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
                  onAddEmployment: (){
                    openAddEmploymentForm(context, designationListData: controller.designationListData.value);
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
    );
  }

  _openPage(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var pastData=controller.employeeData.value.data?.past??[];
            return pastData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pastData.length??0, (index){
                    return commonCompanyJobWidget(context,
                      profileImage: pastData[index].profile??"",
                      initialName:"Satyam Shukla",
                      userName: "Satyam Shukla",
                      ccId: pastData[index].individualId??'',
                      ratingStar: '10',
                      buttonName: appAddReview,
                      salary: "600 - 100 Lacs PA",
                      experienceYear: "3 years",
                      vaccancy: "12",
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: 'Published',
                      noOfVaccency: '10',
                      timeAgo: calculateTimeDifference(createDate:  "21-02-25"??""),
                      locations: 'Delhi, noida, lucknow',
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
            var pastData=controller.employeeData.value.data?.past??[];
            return pastData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pastData.length??0, (index){
                    return commonCompanyJobWidget(context,
                      profileImage: pastData[index].profile??"",
                      initialName:"Satyam Shukla",
                      userName: "Satyam Shukla",
                      ccId: pastData[index].individualId??'',
                      ratingStar: '10',
                      buttonName: appAddReview,
                      salary: "600 - 100 Lacs PA",
                      experienceYear: "3 years",
                      vaccancy: "12",
                      onClick: () {
                        Get.offNamed(AppRoutes.applicants,arguments: {screenName:companyJobsScreen,jobProfileName:"Web designer"});

                      },
                      jobStatus: 'Published',
                      noOfVaccency: '10',
                      timeAgo: calculateTimeDifference(createDate:  "21-02-25"??""),
                      locations: 'Delhi, noida, lucknow',
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
            var pastData=controller.employeeData.value.data?.past??[];
            return pastData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pastData.length??0, (index){
                    return commonCompanyJobWidget(context,
                      profileImage: pastData[index].profile??"",
                      initialName:"Satyam Shukla",
                      userName: "Satyam Shukla",
                      ccId: pastData[index].individualId??'',
                      ratingStar: '10',
                      buttonName: appAddReview,
                      salary: "600 - 100 Lacs PA",
                      experienceYear: "3 years",
                      vaccancy: "12",
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: 'Published',
                      noOfVaccency: '10',
                      timeAgo: calculateTimeDifference(createDate:  "21-02-25"??""),
                      locations: 'Delhi, noida, lucknow',
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