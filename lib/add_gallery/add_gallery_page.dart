import 'dart:io';

import 'package:collarchek/add_gallery/add_gallery_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_image_widget.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class AddGalleryPage extends GetView<AddGalleryControllers>{
  const AddGalleryPage({super.key});

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
                    screenName: appAddGallery,  onShareClick: (){}, onFilterClick: (){}, actionButton: '',
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: GestureDetector(
                        onTap: (){
                          controller.captureImageFromCameraOrGallery(context);
                        },
                        child: Column(
                          children: <Widget>[
                            DottedBorder(
                              borderType: BorderType.RRect,
                              color: appBlackColor,
                              strokeWidth: 1,
                              radius: const Radius.circular(20),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      appUploadResume,
                                      height: 24,
                                      width: 24,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      appSelectFileDragFiles,
                                      style: AppTextStyles.font14.copyWith(color: appPrimaryColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Obx((){
                              var imageData=controller.allSelectedGalleryImages??[];
                              return Wrap(
                                runSpacing: 5,
                                children: List.generate(controller.allSelectedGalleryImages.length, (index) {
                                  return Text(
                                    imageData[index]?.path.split("cache/")[1] ?? "",
                                    style: AppTextStyles.font12.copyWith(color: appPrimaryColor),
                                  );
                                }),
                              );
                            })

                          ],
                        )
                    ),
                  ),
                  commonButton(context,
                      buttonName: appSave,
                      buttonBackgroundColor: appPrimaryColor,
                      textColor: appWhiteColor,
                      buttonBorderColor: appPrimaryColor,
                      onClick: (){
                        controller.addImageDataGalleryApi(context);

                      }
                  ),
                  SizedBox(height: 20,),
                  Obx((){
                    var galleryData=controller.companyGalleryData.value.data??[];
                    return Wrap(
                      spacing:15,
                      runSpacing: 10,
                      children: List.generate(galleryData.length, (index){
                        return Stack(
                          children: <Widget>[
                            commonImageWidget(image: galleryData[index].image??"", initialName:  galleryData[index].name??"", height: MediaQuery.of(context).size.height*0.13, width: MediaQuery.of(context).size.width*0.42, borderRadius: 5,borderColor: appPrimaryBackgroundColor),

                            Positioned(
                                right:3,
                                top:3,
                                child: GestureDetector(
                                  onTap:(){
                                    controller.deleteGalleryImage(context, imageId: galleryData[index].id??"");
                                  },
                                  child: Container(
                                    padding:EdgeInsets.all(4),
                                    decoration:BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: appWhiteColor
                                    ),
                                    child:SvgPicture.asset(appCloseIcon,height: 12,width: 12,),
                                  ),
                                )
                            )
                          ],
                        );
                      }),
                    );
                  })
                ],
              ),
            )
        ),
      ),
    );
  }

}