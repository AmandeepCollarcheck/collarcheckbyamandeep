import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../utills/app_colors.dart';
import '../utills/app_key_constent.dart';
import '../utills/app_route.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/commonDrawer.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart' show AppTextStyles;
import '../utills/image_path.dart';
import 'company_connection_controller.dart';

class CompanyConnectionPage extends GetView<CompanyConnectionControllers>{
  CompanyConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
         PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
      if (!didPop) {
        onWillPop();
      }
    },
    child: Scaffold(
        backgroundColor: appScreenBackgroundColor,
        drawer: CommonDrawer(),

   body:Builder(
    builder: (scaffoldContext) =>
    Column(
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Obx(()=>commonSearchAppBar(
              scaffoldContext,controller: controller.searchController,
              actionButtonOne: "",
              titleWidget: Text("Connections"),
              actionButtonTwo: appSearchIcon,
              isBadge: false,
              onTap: (){
                controller.openSearchScreen(context);
              },
              isSearchActive: controller.isSearchActive.value,
              onSearchIconClick: (bool isSearchClick) {
                controller.isSearchActive.value=isSearchClick;
              })),
        ),
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


      ]),
   ))
    ));}

  _followerWidget(context)  {

    return SingleChildScrollView(
      child: Obx(
              ()  {
            var followersData=controller.followerList??[];
            return followersData.isNotEmpty?Container(
                padding: EdgeInsets.all(15),
                child:Wrap(
                  children:
                  List.generate(followersData.length??0, (index){
                    return commonTopCompaniesWidgetWithFollowers(
                        context,
                        image: followersData[index].profile??"",
                        name: followersData[index].name??'',
                        id: followersData[index].individualId??"",
                        jobTitle: followersData[index].designationName??"",
                        location: generateLocation(cityName: "", stateName: followersData[index].stateName??"",
                            countryName: followersData[index].countryName??""),
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
                     // controller.followBackApiCall(context, companyId: '', userId: followersData[index].userId??"");

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

  _followingWidget( context) {
    return SingleChildScrollView(
      child: Obx((){
        var followingData=controller.followingList??[];
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

                    //  controller.rejectFollowRequest(context,id: followingData[index].id??"");

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