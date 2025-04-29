import 'package:collarchek/connections/connection_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
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
              // Container(
              //   margin: EdgeInsets.only(left: 20,right: 20,top: 20),
              //   child: commonSearchAppBar(
              //       context,
              //       controller: controller.searchController,
              //       actionButtonOne: appNotificationSVGIcon,
              //       actionButtonTwo: appSearchIcon,
              //
              //       onTap: (){
              //         controller.openSearchScreen(context);
              //       },
              //       onSearchIconClick: (bool isSearchClick) {
              //         controller.isSearchActive.value=isSearchClick;
              //       })
              // ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Obx(()=>commonSearchAppBar(
                    context,controller: controller.searchController,
                    actionButtonOne: appNotificationSVGIcon,
                    actionButtonTwo: appSearchIcon,
                    isSearchActive: controller.isSearchActive.value,
                    onChanged: (value){
                      // controller.openSearchScreen(context);

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
                      _followerWidget(context),
                      _followingWidget(context),
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

  _followerWidget(context)  {

    return SingleChildScrollView(
      child: Obx(()  {
        var followersData=controller.connectionData.value.data?.followerList??[];
        return followersData.isNotEmpty?Container(
            padding: EdgeInsets.all(15),
            child:Wrap(
              children: List.generate(followersData.length??0, (index){
                return commonTopCompaniesWidgetWithFollowers(
                    context,
                    image: followersData[index].profile??"",
                    name: followersData[index].name??'',
                    id: followersData[index].individualId??"",
                    jobTitle: followersData[index].designationName??"",
                    location: generateLocation(cityName: "", stateName: followersData[index].stateName??"", countryName: followersData[index].countryName??""),
                    isFollowBack:followersData[index].followBack??false,
                    onClick: (){
                      Get.offNamed(
                          AppRoutes.chat,
                          arguments: {
                            screenName:connections,
                            messageReceiverName:followersData[index].name??"",
                            profileImageData:followersData[index].profile??"",
                            receiverId:followersData[index].userId??"",
                            senderId:controller.userId.value??"",

                          });

                    }, onSecondClick: (){
                      controller.followBackApiCall(context, companyId: '', userId: followersData[index].userId??"");

                });
              }),
            )
        ):SizedBox(
            height: MediaQuery.of(context).size.height*0.65,
            child: Center(
              child: Text(appNoDataFound,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
            )
        );
      }),
    );
  }

  _followingWidget( context) {
    return SingleChildScrollView(
      child: Obx((){
        var followingData=controller.connectionData.value.data?.followingList??[];
        return followingData.isNotEmpty?Container(
            padding: EdgeInsets.all(15),
            child:Wrap(
              children: List.generate(followingData.length??0, (index){
                return commonTopCompaniesWidgetWithFollowers(
                    context,
                    image: followingData[index].profile??"",
                    name: followingData[index].name??'',
                    id: followingData[index].individualId??'',
                    jobTitle: followingData[index].designationName??"",
                    location: generateLocation(cityName: "", stateName: followingData[index].stateName??"", countryName: followingData[index].countryName??""),
                    onClick: (){

                      controller.rejectFollowRequest(context,id: followingData[index].id??"");

                    },
                    isFollowers: false,
                    onSecondClick: (){

                    }
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
    );
  }

}