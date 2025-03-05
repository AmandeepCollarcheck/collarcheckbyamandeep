import 'dart:io';
import 'dart:ui';

import 'package:collarchek/utills/app_colors.dart';
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
      icon: Image.asset(appBackIcon, height: 24, width: 24),
      onPressed: () {

        onClick(); // Go back to the previous screen
      },
    ),
  );
}


Widget commonSearchAppBar(context,{required TextEditingController controller,required String actionButtonOne,required String actionButtonTwo, bool isSearchActive = false,required Function(bool) onSearchIconClick}) {
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
                    child: Image.asset(appNewLogoIcons, height: 32, width: 151),
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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(actionButtonOne, height: 25, width: 25),
                    Positioned(
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
                    ),
                  ],
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
              onSearchClick: (){
                isSearchActive = !isSearchActive;
                onSearchIconClick(isSearchActive);
              },
                controller: controller,
                hintText: appSearchForJobsCompanies,
              suffixIcon: appSearchIcon
            ),
          ),
      ],
    ),
  );;
}

commonActiveSearchBar({required  Function onClick,required  Function onShareClick,required  Function onFilterClick,required String leadingIcon,required String screenName,bool isFilterShow=false,bool isScreenNameShow=true,bool isShowShare=false,required String actionButton}){
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: appPrimaryColor,width: 1),
              color: appWhiteColor
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Row(
                children: <Widget>[
                  Image.asset(appFilterIcon, height: 15, width: 15),
                  SizedBox(width: 3,),
                  Text(
                    actionButton, // Notification count
                    style: AppTextStyles.font14.copyWith(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ):isShowShare?GestureDetector(
          onTap: (){
            onShareClick();
          },
          child: Image.asset(appShareIcon,height: 24,width: 24,),
        ):Container(
          width: 0,
        )

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


commonAppBarWithSettingAndShareOption({required String leadingIcon,required Function() onClick,required Function() onSettingsClick}){
  return Container(
    color: appWhiteColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SvgPicture.asset(appLogoSvg, height: 40, width: 38),
            // GestureDetector(
            //   onTap: (){
            //     onClick();
            //   },
            //   child:  leadingIcon.contains(".svg")?SvgPicture.asset(leadingIcon, height: 15, width: 15,):Image.asset(leadingIcon, height: 24, width: 24),
            // ),

            SizedBox(width: 5,),
            Text(
              appProfile, // Notification count
              style: AppTextStyles.font20w600.copyWith(
                color: appBlackColor,
              ),
            )
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


