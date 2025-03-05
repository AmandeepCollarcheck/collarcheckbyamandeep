import 'package:collarchek/connections/connection_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class ConnectionPage extends GetView<ConnectionControllers>{
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 20),
              child: commonSearchAppBar(context,controller: controller.searchController, actionButtonOne: appNotificationSVGIcon, actionButtonTwo: appSearchIcon, onSearchIconClick: (bool onSearchClick) {  }),
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
                    _followerWidget(context),
                    _followingWidget(context),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  _followerWidget(context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child:Wrap(
          children: List.generate(10, (index){
            return commonTopCompaniesWidgetWithFollowers(context,image: appCompanyImage, name: 'Kartik Mehra ', id: 'CCE824849', jobTitle: 'Sr. Frontend Dev ', location: 'Delhi, New Delhi', onClick: (){});
          }),
        )
      ),
    );
  }

  _followingWidget( context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(15),
          child:Wrap(
            children: List.generate(10, (index){
              return commonTopCompaniesWidgetWithFollowers(context,image: appCompanyImage, name: 'Kartik Mehra ', id: 'CCE824849', jobTitle: 'Sr. Frontend Dev ', location: 'Delhi, New Delhi', onClick: (){},isFollowers: false);
            }),
          )
      ),
    );
  }

}