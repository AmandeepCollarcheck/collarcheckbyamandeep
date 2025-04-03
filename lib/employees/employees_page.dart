import 'package:collarchek/employees/employees_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/common_widget/add_employment_bottom_sheet.dart';
import '../utills/common_widget/common_appbar.dart';
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
              child: TabBar(
                labelPadding: EdgeInsets.only(bottom: 10),
                isScrollable: false,
                dividerColor: appWhiteColor,
                indicatorColor: appPrimaryColor,
                indicatorWeight: 2,
                // indicatorPadding: EdgeInsets.only(left: 20,right: 20),
                indicatorSize: TabBarIndicatorSize.tab,
                controller: controller.tabController,
                tabs: List.generate(controller.listTabLabel.length, (index){
                  return Text(controller.listTabLabel[index],style: AppTextStyles.font14.copyWith(color: appBlackColor),);
                }),
              ),
            ),
            Expanded(
              child: Container(
                color: appPrimaryBackgroundColor,
                height: MediaQuery.of(context).size.height ,
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: <Widget>[
                    Text("asjnjksdkfjs"),
                    Text("asjnjksdkfjs"),
                   // _followerWidget(context),
                    //_followingWidget(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}