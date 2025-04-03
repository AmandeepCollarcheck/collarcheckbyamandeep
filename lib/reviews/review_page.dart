import 'package:collarchek/reviews/review_controllers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class ReviewPage extends GetView<ReviewControllers>{
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              commonActiveSearchBar(
                onClick: (){
                  controller.backButtonClick(context);
                },
                leadingIcon: appBackSvgIcon,
                screenName: appAddReview,  onShareClick: (){}, onFilterClick: (){}, actionButton: '',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        commonTextFieldTitle(headerName: appSelectRating,isMendatory: true),
                        SizedBox(height: 5,),
                        commonRattingBar(context, initialRating: controller.ratingValue.value, updatedRating: (double data ) {
                          controller.ratingValue.value=data;
                        }),
                        SizedBox(height: 10,),
                        commonTextFieldTitle(headerName: appReview,isMendatory: true),
                        SizedBox(height: 5,),
                        commonTextField(controller: controller.descriptionController, hintText: appReview, maxLine: 5),
                        SizedBox(height: 10,),
                        commonTextFieldTitle(headerName: appAddUrlLink,isMendatory: false),
                        SizedBox(height: 5,),
                        commonTextField(controller: controller.linkController, hintText: appAddUrlLink,),
                        ///Certificates
                        SizedBox(height: 10,),
                        commonTextFieldTitle(headerName: appCertificates,isMendatory: false),
                        SizedBox(height: 5,),
                        GestureDetector(
                          onTap: (){

                            getPortfolioTypeFromGallery(context,onFilePickedData: (String pickedData) {
                              if(pickedData!=null){
                                controller.selectedImageFromTHeGallery.value=pickedData;
                              }
                            }, portfolioType: "Upload Image");
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
                        ),
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
                                      child: Text(controller.selectedImageFromTHeGallery.value,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),));
                                }),
                                GestureDetector(
                                    onTap:(){
                                      controller.selectedImageFromTHeGallery.value="";
                                    },
                                    child: SvgPicture.asset(appCloseIcon,height: 24,width: 24,))
                              ],
                            ),
                          ):Container();
                        })


                      ],
                    ),
                  ),
                  SizedBox(height:20,),
                  commonButton(context,
                      buttonName: appSave,
                      buttonBackgroundColor: appPrimaryColor,
                      textColor: appWhiteColor,
                      buttonBorderColor: appPrimaryColor,
                      onClick: (){
                        controller.addReviewValidation(context);
                      }
                  ),
                  SizedBox(height:30,),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}