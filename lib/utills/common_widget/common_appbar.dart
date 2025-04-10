import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/common_text_field.dart';
import 'package:collarchek/utills/image_path.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../app_strings.dart';
import '../font_styles.dart';

commonAppBar(context, {required Function onClick}){
  return AppBar(
    backgroundColor: appBarBackgroundColor,
    leading: IconButton(
      icon: SvgPicture.asset(appBackSvgIcon, height: 24, width: 24),
      onPressed: () {

        onClick(); // Go back to the previous screen
      },
    ),
  );
}


Widget commonSearchAppBar(
    context,{
      required TextEditingController controller,
      required String actionButtonOne,
      required String actionButtonTwo,
      bool isSearchActive = false,
      required Function(bool) onSearchIconClick,
      bool isBadge=true,
      Function(String)? onChanged,
      Function()? onTap
    }) {

  return Container(
    color: appBarBackgroundColor,
    //padding: EdgeInsets.symmetric(horizontal: 10),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(appMenuIcon, height: 24, width: 24),
                ),
                if (!isSearchActive) // Show logo only when search is not active
                  Padding(
                    padding: EdgeInsets.only(left: 10,bottom: 5),
                    child: Image.asset(appLogoNewSvg, height: 32, width: 151),
                  ),
              ],
            ),
            Row(
              children: [
                isSearchActive?Container():GestureDetector(
                  onTap: () {
                    isSearchActive = !isSearchActive;
                    onSearchIconClick(isSearchActive);
                  },
                  child: SvgPicture.asset(actionButtonTwo, height: 20, width: 20),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: (){
                    Get.offNamed(AppRoutes.notifications);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(actionButtonOne, height: 25, width: 25),
                      isBadge?Positioned(
                        top: -7,
                        right: -3,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                            color: appPrimaryColor,
                          ),
                          constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                          child: Center(
                            child: Text(
                              "10",
                              style: AppTextStyles.font10.copyWith(
                                color: appWhiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ):Container(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isSearchActive) // Show search field on top when active
          Container(
            alignment: Alignment.center,
            height: 40,
            width: MediaQuery.of(context).size.width*0.7,
            color: appBarBackgroundColor,
           // padding: EdgeInsets.symmetric(horizontal: 10),
            child: commonTextField(
              onChanged: onChanged,
              onTap: onTap,
              onSearchClick: (){
                isSearchActive = !isSearchActive;
                onSearchIconClick(isSearchActive);
              },
                controller: controller,
                hintText: appSearchForJobsCompanies,
              suffixIcon: isSearchActive?appCloseIcon:appSearchIcon
            ),
          ),
      ],
    ),
  );
}

commonActiveSearchBar({required  Function onClick,required  Function onShareClick,required  Function onFilterClick,required String leadingIcon,required String screenName,bool isFilterShow=false,bool isScreenNameShow=true,bool isShowShare=false,required String actionButton,bool isProfileImageShow=false,String profileImageData="",String initialName="", Color backGroundColor=appWhiteColor}){
  return Container(
    padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
    color: backGroundColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
           GestureDetector(
             onTap: (){
               onClick();
             },
             child:  leadingIcon.contains(".svg")?SvgPicture.asset(leadingIcon, height: 15, width: 15,):Image.asset(leadingIcon, height: 24, width: 24),
           ),
            SizedBox(width: 5,),
            isProfileImageShow?ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: profileImageData.isNotEmpty?Image.network(
                profileImageData,height: 40,width: 40,fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [getRandomColor(),getRandomColor()]
                        )
                    ),
                    height: 40,width: 40,
                    child: Text(initialName,style: AppTextStyles.font14W500.copyWith(color: appBlackColor),),
                  );
                },
              ):Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [getRandomColor(),getRandomColor()]
                    )
                ),
                height: 40,width: 40,
                child: Text(initialName,style: AppTextStyles.font14W500.copyWith(color: appBlackColor),),
              ),
            ):Container(),
            SizedBox(width: 5,),
            isScreenNameShow?Text(
              screenName, // Notification count
              style: AppTextStyles.font16W600.copyWith(
                color: appBlackColor,
                fontWeight: FontWeight.bold,
              ),
            ):Container(),
          ],
        ),

        isFilterShow?GestureDetector(
          onTap: (){
            onFilterClick();
          },
          child: Row(
            children: <Widget>[
              SvgPicture.asset(appFilterSvgIcon, height: 24, width: 24)
            ],
          ),
        ):isShowShare?GestureDetector(
          onTap: (){
            onShareClick();
          },
          child: SvgPicture.asset(appShareAndroid,height: 24,width: 24,),
        ):Container(
          width: 0,
        )

      ],
    ),
  );
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    200 + random.nextInt(56),
    200 + random.nextInt(56),
    200 + random.nextInt(56),
  );
}


commonActiveWithDeleteIcon({required  Function onClick,required  Function onDeleteClick,required String leadingIcon,required String screenName,}){
  return Container(
    padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
    color: appWhiteColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                onClick();
              },
              child:  leadingIcon.contains(".svg")?SvgPicture.asset(leadingIcon, height: 15, width: 15,):Image.asset(leadingIcon, height: 24, width: 24),
            ),
            SizedBox(width: 5,),
            Text(
              screenName, // Notification count
              style: AppTextStyles.font16W600.copyWith(
                color: appBlackColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: (){
            onDeleteClick();
          },
            child: SvgPicture.asset(appDeleteSvgIcon,height: 22,width:22))

      ],
    ),
  );
}



Future<String?> shortedDataFilter( context,{required List<Map<String, dynamic>>  menuItem,required Function(Map<String, dynamic>) onVoidCallBack }) {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final Offset position = button.localToGlobal(Offset.zero);
  final Size size = button.size;
  final Size screenSize = MediaQuery.of(context).size;
  return showMenu(
    color: appWhiteColor,
    context: context,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Set border radius here
    ),
    position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width*0.63, // Aligns to right corner
      MediaQuery.of(context).size.height*0.19, // Aligns to the top
      screenSize.width, // Right edge of the screen
      size.height, // Height of the menu
    ),
    items: List.generate(
        menuItem.length, (index) {
      return PopupMenuItem(
        onTap: (){
          onVoidCallBack(menuItem[index]);
        },
        height: 30,
        value: menuItem[index]['id'].toString(), // Ensure 'id' exists
        child: Text(
          menuItem[index]['name'], // Ensure 'name' exists
          style: AppTextStyles.font14W500.copyWith(color: appBlackColor),
        ),
      );
    }),
  );
}


commonAppBarWithSettingAndShareOption(context,{required String leadingIcon,required Function() onClick,required Function() onSettingsClick}){
  return Container(
    color: appWhiteColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: SvgPicture.asset(appMenuIcon, height: 24, width: 24),
            ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Image.asset(appLogoNewSvg, height: 32, width: 151),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                onSettingsClick();
              },
              child: SvgPicture.asset(appSetting, height: 24, width: 24,),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                onSettingsClick();
              },
              child: SvgPicture.asset(Platform.isAndroid?appShareAndroid:appShareIos, height: 24, width: 24,),
            ),
          ],
        ),
      ],
    ),
  );
}


Widget commonCompanySearchAppBar(
    context,{
      required TextEditingController controller,
      required String actionButtonOne,
      required String actionButtonTwo,
      bool isSearchActive = false,
      required Function(bool) onSearchIconClick,
      bool isBadge=true,
      Function(String)? onChanged,
      Function()? onTap,
      Function()? onAddEmployment
    }) {

  return Container(
    color: appBarBackgroundColor,
    //padding: EdgeInsets.symmetric(horizontal: 10),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(appMenuIcon, height: 24, width: 24),
                ),
                if (!isSearchActive) // Show logo only when search is not active
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Image.asset(appLogoNewSvg, height: 32, width: 151),
                  ),
              ],
            ),
            Row(
              children: [
                isSearchActive?Container():GestureDetector(
                  onTap: () {
                    isSearchActive = !isSearchActive;
                    onSearchIconClick(isSearchActive);
                  },
                  child: SvgPicture.asset(actionButtonTwo, height: 20, width: 20),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: (){
                    onAddEmployment!();
                  },
                  child: SvgPicture.asset(appAddEmploymentIconSvg, height: 22, width: 22),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: (){
                    Get.offNamed(AppRoutes.notifications);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(actionButtonOne, height: 25, width: 25),
                      isBadge?Positioned(
                        top: -7,
                        right: -3,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                            color: appPrimaryColor,
                          ),
                          constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                          child: Center(
                            child: Text(
                              "10",
                              style: AppTextStyles.font10.copyWith(
                                color: appWhiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ):Container(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isSearchActive) // Show search field on top when active
          Container(
            alignment: Alignment.center,
            height: 40,
            width: MediaQuery.of(context).size.width*0.7,
            color: appBarBackgroundColor,
            // padding: EdgeInsets.symmetric(horizontal: 10),
            child: commonTextField(
                onChanged: onChanged,
                onTap: onTap,
                onSearchClick: (){
                  isSearchActive = !isSearchActive;
                  onSearchIconClick(isSearchActive);
                },
                controller: controller,
                hintText: appSearchForJobsCompanies,
                suffixIcon: isSearchActive?appCloseIcon:appSearchIcon
            ),
          ),
      ],
    ),
  );
}