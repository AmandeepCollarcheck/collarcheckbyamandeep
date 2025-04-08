import 'package:collarchek/employees/employees_controllers.dart';
import 'package:collarchek/utills/app_key_constent.dart';
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

class EmployeesPage extends GetView<EmployeeControllers>{
  const EmployeesPage({super.key});

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
                    openAddEmploymentForm(context, designationListData: controller.designationListData.value, screenNameData: companyEmployeesScreen);
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
                    _currentPage(context),
                    _pastPage(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _currentPage(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var currentData=controller.employeeData.value.data?.current??[];
            return currentData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(currentData.length??0, (index){
                    return commonCompanyWidget(context,
                      profileImage: currentData[index].profile??"",
                      initialName: currentData[index].contactPerson??'',
                      userName:  currentData[index].contactPerson??'',
                      ccId: currentData[index].individualId??'',
                      ratingStar: '0',
                      buttonName: appAddReview,
                      designation: currentData[index].designation??'',
                      location: generateLocation(cityName: currentData[index].presentAddress??'', stateName: "", countryName: ""),
                      dataPosted: dateCombination(joiningDate: '', endDate: '',isPresent: false),
                      onClick: () {  },
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

  _pastPage(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Obx(()  {
            var pastData=controller.employeeData.value.data?.past??[];
            return pastData.isNotEmpty?Container(
                padding: EdgeInsets.all(10),
                child:Wrap(
                  children: List.generate(pastData.length??0, (index){
                    return commonCompanyWidget(context,
                      profileImage: pastData[index].profile??"",
                      initialName:pastData[index].contactPerson??'',
                      userName:" Person"??'',
                      ccId: pastData[index].individualId??'',
                      ratingStar: '10.0',
                      buttonName: appAddReview,
                      designation: pastData[index].designation??'',
                      location: generateLocation(cityName: pastData[index].presentAddress??'', stateName: "", countryName: ""),
                      dataPosted: dateCombination(joiningDate: pastData[index].joiningDate??'', endDate: pastData[index].workedTillDate??'',isPresent: false),
                      onClick: () {
                        print("On click wor,");
                      },
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