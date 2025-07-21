import 'package:collarchek/request/request_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/common_widget/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class RequestPage extends GetView<RequestControllers>{
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
          if (!didPop) {
            onWillPop();
          }
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              commonActiveSearchBar(
                  onClick: (){
                    controller.backButtonClick(context);
                  }, onShareClick: (){}, onFilterClick: (){}, leadingIcon: appBackSvgIcon, screenName: appRequest, actionButton: ''),
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
                      _followRequestWidget(context),
                      _salaryRequestWidget(context),
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

  _followRequestWidget(context) {
    return SingleChildScrollView(
      child: Obx((){
        var followData=controller.followDataList.value.data?.follow??[];
        return Container(
            padding: EdgeInsets.all(15),
            child:followData.isNotEmpty?Wrap(
              children: List.generate(followData.length??0, (index){
                return commonTopCompaniesWidgetWithFollowers(
                    context,
                    image: followData[index].profile??appCompanyImage,
                    name: followData[index].name??"",
                    id: followData[index].individualId??"",
                    jobTitle: '',
                    location: '',
                    onClick: (){
                      controller.acceptFollowRequest(context,id: followData[index].id??"");
                    },isRequest: true, 
                    onSecondClick: (){

                      controller.rejectFollowRequest(context,id: followData[index].id??"");
                    }
                );
              }),
            ):Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(appNoDataFound,style: AppTextStyles.font12w500.copyWith(color: appBlackColor),),
            )
        );
      }),
    );
  }

  _salaryRequestWidget( context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(15),
          child:Wrap(
            children: List.generate(10, (index){
              return commonTopCompaniesWidgetWithFollowers(context,image: appCompanyImage, name: 'Kartik Mehra ', id: 'CCE824849', jobTitle: 'Sr. Frontend Dev ', location: 'Delhi, New Delhi', onClick: (){},isFollowers: false, onSecondClick: (){});
            }),
          )
      ),
    );
  }

}