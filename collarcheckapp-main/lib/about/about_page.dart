import 'package:collarchek/about/about_controllers.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/image_path.dart';

class AboutPage extends GetView<AboutControllers>{
  const AboutPage({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                commonActiveSearchBar(
                  onClick: (){
                    controller.backButtonClick();
                  },
                  leadingIcon: appBackSvgIcon,
                  screenName: appAbout,  onShareClick: (){}, onFilterClick: (){}, actionButton: '',
                ),
                SizedBox(height: 20,),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: <Widget>[
                          //commonTextFieldTitle(headerName: appTitle,isMendatory: false),
                          SizedBox(height: 5,),
                          // commonTextField(controller: controller.titleController, hintText: appTitle,),
                          // SizedBox(height: 10,),
                          commonTextFieldTitle(headerName: appProfileDescription,isMendatory: false),
                          SizedBox(height: 5,),
                          commonTextField(controller: controller.descriptionController, hintText: appDescription, maxLine: 5),


                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    commonButton(context,
                        buttonName: appSave,
                        buttonBackgroundColor: appPrimaryColor,
                        textColor: appWhiteColor,
                        buttonBorderColor: appPrimaryColor,
                        onClick: (){
                          controller.validateAbout(context);
                        }
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}