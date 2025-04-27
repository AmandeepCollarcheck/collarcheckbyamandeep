import 'package:collarchek/company_employment_request/company_employment_request_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
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
                    controller.backButtonClick();
                  },
                  onShareClick: (){},
                  onAddEmployment:()async{
                    final result=await openAddEmploymentForm(context, designationListData: controller.designationListData.value, screenNameData: companyEmploymentRequest, companyAllEmployment: controller.companyEmploymentData.value);
                    if(result['result']==true){
                      Future.delayed(Duration(milliseconds: 500), ()async {
                        controller.getEmploymentRequestApiCall();
                      });
                    }
                  },
                  isScreenNameShow: true,
                  isShowShare: false
              ),
            ),
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
            var pendingData=controller.companyEmploymentRequestData.value.data?.pendingList??[];
            return pendingData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pendingData.length??0, (index){
                    return companyEmploymentRequestWidget(context,
                      profileImage: pendingData[index].profile??"",
                      initialName:pendingData[index].userName??"",
                      userName: pendingData[index].userName??"",
                      ccId: pendingData[index].individualId??"",
                      dataPosted:commonEmployementDataPosted(joiningData: pendingData[index].joiningDate??"", employementTillDate: pendingData[index].workedTillDate??"", stillWorking: pendingData[index].stillWorking??""),
                      designation: pendingData[index].designation??"",
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: appEmployment,
                      approved:pendingData[index].approved??"0",
                      isAcceptClick: () {
                        controller.acceptEmploymentApiCall(context, id: pendingData[index].id??"",);
                      },
                      isRejectClick: () {
                        controller.rejectEmploymentApiCall(context, id: pendingData[index].id??"",);
                      },
                      isProfileVerified: pendingData[index].isVerified??false,
                        cardWidth: MediaQuery.of(context).size.width*0.82
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
            var approved=controller.companyEmploymentRequestData.value.data?.approvedList??[];
            return approved.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(approved.length??0, (index){
                    return companyEmploymentRequestWidget(context,
                      profileImage: approved[index].profile??"",
                      initialName:approved[index].userName??"",
                      userName: approved[index].userName??"",
                      ccId: approved[index].individualId??"",
                      dataPosted:commonEmployementDataPosted(joiningData: approved[index].joiningDate??"", employementTillDate: approved[index].workedTillDate??"", stillWorking: approved[index].stillWorking??""),
                      designation: approved[index].designation??"",
                      isApproved: true,
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: appEmployment,
                        approved: "0",
                      isAcceptClick: () {
                        Get.offNamed(AppRoutes.review,arguments: {experienceId:approved[index].id??'',screenName:companyEmploymentRequest});
                      },
                      isRejectClick: () {
                        print("Left Company");
                      },
                        isProfileVerified: approved[index].isVerified??false,
                        cardWidth: MediaQuery.of(context).size.width*0.82
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
            var update=controller.companyEmploymentRequestData.value.data?.newUpdateList??[];
            return update.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(update.length??0, (index){
                    return companyEmploymentRequestWidget(context,
                      profileImage: update[index].profile??"",
                      initialName:update[index].userName??"",
                      userName:update[index].userName??"",
                      ccId: update[index].individualId??"",
                      dataPosted:commonEmployementDataPosted(joiningData: update[index].joiningDate??"", employementTillDate: update[index].workedTillDate??"", stillWorking: update[index].stillWorking??""),
                      designation: update[index].designation??"",
                      isUpdates: true,
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: appEmployment,
                        approved:update[index].approved??"0",
                      isAcceptClick: () {
                        controller.acceptEmploymentApiCall(context, id: update[index].id??"",);
                      },
                      isRejectClick: () {
                        controller.rejectEmploymentApiCall(context, id: update[index].id??"",);
                      },
                        isProfileVerified: update[index].isVerified??false,
                        cardWidth: MediaQuery.of(context).size.width*0.82
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
            var reject=controller.companyEmploymentRequestData.value.data?.rejectList??[];
            return reject.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(reject.length??0, (index){
                    return companyEmploymentRequestWidget(context,
                      profileImage: reject[index].profile??"",
                      initialName:reject[index].userName??"",
                      userName:reject[index].userName??"",
                      ccId:reject[index].individualId??"",
                      dataPosted: commonEmployementDataPosted(joiningData: reject[index].joiningDate??"", employementTillDate: reject[index].workedTillDate??"", stillWorking: reject[index].stillWorking??""),
                      designation: reject[index].designation??"",
                      isRejected: true,
                      onClick: () {
                        print("On click wor,");
                      },
                      jobStatus: appEmployment, approved: '',
                      isAcceptClick: () {  },
                      isRejectClick: () {  },
                        isProfileVerified: reject[index].isVerified??false,
                        cardWidth: MediaQuery.of(context).size.width*0.82
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