import 'package:collarchek/portfolio/portfolio_controllers.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class PortfolioPage extends GetView<PortfolioControllers>{
  const PortfolioPage({super.key});

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
                    controller.backButtonClick(context);
                  },
                  leadingIcon: appBackSvgIcon,
                  screenName: appAddPortfolio,  onShareClick: (){}, onFilterClick: (){}, actionButton: '',
                ),
                SizedBox(height: 20,),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: <Widget>[
                          commonTextFieldTitle(headerName: appTitle,isMendatory: true),
                          SizedBox(height: 5,),
                          commonTextField(controller: controller.titleController, hintText: appTitle, validator: (value) => value!.isEmpty ? appTitle+appIsRequired : null,),
                          SizedBox(height: 10,),
                          commonTextFieldTitle(headerName: appDescription,isMendatory: false),
                          SizedBox(height: 5,),
                          commonTextField(controller: controller.descriptionController, hintText: appDescription, maxLine: 5),

                          SizedBox(height: 10,),
                          commonTextFieldTitle(headerName: appSelectPortfolioType,isMendatory: true),
                          SizedBox(height: 5,),
                          Obx((){
                            var portfolioType = controller.portfolioType ?? [];
                            return portfolioType!=null&&portfolioType.isNotEmpty?customDropDown(
                                hintText: appSelectCompany,
                                item: [{"id":"0","name":appSelectPortfolioType},
                                  ...portfolioType.map((data)=>{'id':data['id'],'name':data['name']}).toList()??[]
                                ],
                                selectedValue: portfolioType.any((datum)=>datum['id']==controller.selectedPortfolioDropDown["id"])?controller.selectedPortfolioDropDown:{"id":"0","name":appSelectPortfolioType},
                                onChanged: (Map<String,dynamic>? selectedData){
                                  if(selectedData!=null){
                                    controller.selectedPortfolioDropDown.value={
                                      "id": selectedData?['id'].toString() ?? "0",
                                      "name": selectedData?['name'].toString() ?? appSelectPortfolioType
                                    };


                                    controller.selectedPortfolioId.value=selectedData['id']??"";
                                    if(selectedData['name']=="Select Portfolio"){
                                      controller.youTubeController.clear();
                                      controller.portfolioTitle.value=appSelectImage??"";
                                    }else if(selectedData['name']=="Image"){
                                      controller.youTubeController.clear();
                                      controller.portfolioTitle.value=appSelectImage??"";
                                    }else if(selectedData['name']=="Video"){
                                      controller.youTubeController.clear();
                                      controller.portfolioTitle.value=appSelectVideo??"";
                                    }else if(selectedData['name']=="Youtube Link"){
                                      controller.portfolioTitle.value=appSelectYoutubeLink??"";
                                    }else if(selectedData['name']=="Pdf"){
                                      controller.youTubeController.clear();
                                      controller.portfolioTitle.value=appSelectPdf??"";
                                    }
                                  }
                                },
                                icon: appDropDownIcon
                            ):Container();
                          }),
                          SizedBox(height: 10,),
                          Obx((){
                            return commonTextFieldTitle(headerName: controller.portfolioTitle.value,isMendatory: true);
                          }),
                          SizedBox(height: 5,),
                          Obx((){
                            return controller.portfolioTitle.value==appSelectYoutubeLink?commonTextField(controller: controller.youTubeController, hintText: appSelectYoutubeLink):GestureDetector(
                              onTap: (){

                                controller.enableUploadOptionBasedOnPortfolio(context);
                              },
                              child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: appBlackColor,
                                  strokeWidth: 1,
                                  radius: Radius.circular(20),
                                  child:Container(
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(appUploadResume,height: 24,width: 24,),
                                          SizedBox(width: 10,),
                                          Text(appUpload,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                        ],
                                      )
                                  )
                              ),
                            );
                          }),
                          //SizedBox(height: 5,),
                          // Text(appSupportedFormats,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                          SizedBox(height: 10,),
                          Obx((){
                            return controller.selectedImageFromTHeGallery.value.isNotEmpty? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: appPrimaryBackgroundColor
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Obx((){
                                    return SizedBox(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        child: Text(controller.selectedFileName.value,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),));
                                  }),
                                  GestureDetector(
                                      onTap:(){
                                        controller.selectedImageFromTHeGallery.value="";
                                        controller.selectedFileName.value="";
                                      },
                                      child: SvgPicture.asset(appCloseIcon,height: 24,width: 24,))
                                ],
                              ),
                            ):Container();
                          })

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
                          controller.validateAndSavePortfolioApiCall(context);
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