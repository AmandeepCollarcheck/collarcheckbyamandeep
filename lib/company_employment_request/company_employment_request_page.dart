import 'package:collarchek/company_employment_request/company_employment_request_controllers.dart';
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

class CompanyEmploymentRequestPage extends GetView<CompanyEmploymentRequestControllers>{
  const CompanyEmploymentRequestPage({super.key});

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
              child: commonCompanyActiveSearchBar(
                  leadingIcon: appBackSvgIcon,
                  screenName: appEmployeeRequests,
                  isFilterShow: true,
                  actionButton: appFilterMore,
                  onClick: (){
                    //controller.backButtonClick();
                  },
                  onShareClick: (){},
                  onAddEmployment:(){
                   // controller.clickFilterButton();
                  },
                  isScreenNameShow: true,
                  isShowShare: false
              ),
            ),
            SizedBox(height: 20,),
            Container(
              color: appWhiteColor,
              padding: EdgeInsets.zero,
              child: Obx(() {
                return TabBar(
                  labelPadding: EdgeInsets.zero, // Remove default horizontal padding
                  isScrollable: true,
                  dividerColor: appWhiteColor,
                  indicatorColor: appPrimaryColor,
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: controller.tabController,
                  tabs: List.generate(controller.listTabLabel.length, (index) {
                    return Obx(() {
                      bool isSelected = controller.selectedTabIndex.value == index;

                      return Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Custom spacing
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                controller.listTabLabel[index],
                                style: AppTextStyles.font14.copyWith(
                                  color: isSelected ? appPrimaryColor : appBlackColor,
                                ),
                              ),
                              SizedBox(width: 4),
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
                          ),
                        ),
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
                    _openPending(context),
                    _approved(context),
                    _updateds(context),
                    _rejected(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openPending(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var pastData=controller.employeeData.value.data?.past??[];
            return pastData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pastData.length??0, (index){
                    return companyEmploymentRequestWidget(context,
                      profileImage: pastData[index].profile??"",
                      initialName:"Satyam Shukla ",
                      userName: "Satyam Shukla ",
                      ccId: "CCyeuue788"??'',
                      dataPosted: "asknfsjdjf",
                      designation: "Software Enginner",
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: 'Employment', approved: '',
                      isAcceptClick: () {  },
                      isRejectClick: () {  },
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

  _approved(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var pastData=controller.employeeData.value.data?.past??[];
            return pastData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pastData.length??0, (index){
                    return companyEmploymentRequestWidget(context,
                      profileImage: pastData[index].profile??"",
                      initialName:"Satyam Shukla ",
                      userName: "Satyam Shukla ",
                      ccId: "CCyeuue788"??'',
                      dataPosted: "asknfsjdjf",
                      designation: "Software Enginner",
                      isApproved: true,
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: 'Employment', approved: '',
                      isAcceptClick: () {  },
                      isRejectClick: () {  },
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

  _updateds(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var pastData=controller.employeeData.value.data?.past??[];
            return pastData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pastData.length??0, (index){
                    return companyEmploymentRequestWidget(context,
                      profileImage: pastData[index].profile??"",
                      initialName:"Satyam Shukla ",
                      userName: "Satyam Shukla ",
                      ccId: "CCyeuue788"??'',
                      dataPosted: "asknfsjdjf",
                      designation: "Software Enginner",
                      isUpdates: true,
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: 'Employment', approved: '',
                      isAcceptClick: () {  },
                      isRejectClick: () {  },
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

  _rejected(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var pastData=controller.employeeData.value.data?.past??[];
            return pastData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pastData.length??0, (index){
                    return companyEmploymentRequestWidget(context,
                      profileImage: pastData[index].profile??"",
                      initialName:"Satyam Shukla ",
                      userName: "Satyam Shukla ",
                      ccId: "CCyeuue788"??'',
                      dataPosted: "asknfsjdjf",
                      designation: "Software Enginner",
                      isRejected: true,
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: 'Employment', approved: '',
                      isAcceptClick: () {  },
                      isRejectClick: () {  },
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