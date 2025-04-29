import 'package:collarchek/certificates/certificates_controllers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../models/education_details_model.dart';
import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_button.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class CertificatesPage extends GetView<CertificatesControllers>{
  const CertificatesPage({super.key});

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
                      controller.backButton(context);
                    },
                    leadingIcon: appBackSvgIcon,
                    screenName: appAddCertificates, onShareClick: (){}, onFilterClick: (){}, actionButton: '',
                  ),
                  SizedBox(height: 20,),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            commonTextFieldTitle(headerName: appUniversityName,isMendatory: true),
                            SizedBox(height: 5,),
                            Obx((){
                              //var designation=controller.designationListData.value.data?.designationList??[];
                              var designation = List<CourseListElement>.from(controller.educationDataDetails.value.data?.institutionList ?? []);
                              return designation!=null&&designation.isNotEmpty?customDropDown(
                                  hintText: appSelectDesignation,
                                  item: [{"id":"0","name": appSelectedUniversity},
                                    ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[],],
                                  selectedValue: designation.any((datum)=>datum.id==controller.selectedUniversityDropDown["id"])?controller.selectedUniversityDropDown:{"id":"0","name": appSelectedUniversity},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if(selectedData!=null){
                                      controller.selectedUniversityDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectedUniversity
                                      };
                                      controller.selectedInstitutationData.value=selectedData['name'];
                                      controller.selectedInstitutationIdData.value=selectedData['id'];
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):SizedBox(
                                child:  Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }),
                            // commonTextField(
                            //     isRealOnly: true,
                            //     controller: controller.designationController,
                            //     hintText: appSelectDesignation
                            // ),
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appCourseName,isMendatory: true),
                            SizedBox(height: 5,),
                            Obx((){
                              // var designation=controller.designationListData.value.data?.companyList??[];
                              var designation = List<CourseListElement>.from(controller.educationDataDetails.value.data?.courseList??[]);
                              return designation!=null&&designation.isNotEmpty?customDropDown(
                                  hintText: appSelectCompany,
                                  item: [{"id":"0","name": appSelectedCourse},
                                    ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                  ],
                                  selectedValue: designation.any((datem)=>datem.id==controller.selectedCourseDropDown["id"])?controller.selectedCourseDropDown:{"id":"0","name": appSelectedCourse},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if(selectedData!=null){
                                      controller.selectedCourseDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectedUniversity
                                      };
                                      controller.selectedCourseName.value=selectedData['name'];
                                      controller.selectedCourseIdName.value=selectedData['id'];
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):Container();
                            }),




                            SizedBox(height: 10,),
                            ///Joining date and Employee Till
                            Row(
                              children: <Widget>[
                                Flexible(
                                    child: Column(
                                      children: <Widget>[
                                        commonTextFieldTitle(headerName: appJoiningDate,isMendatory: true),
                                        SizedBox(height: 5,),
                                        commonTextField(
                                            isRealOnly: true,
                                            controller: controller.joiningDateControllers,
                                            hintText: appSelectDesignation,
                                            onTap: (){
                                              selectDate(context,onSelectedDate: (String selectedJoiningDate) {
                                                controller.joiningDateControllers.text=selectedJoiningDate;
                                                controller.selectedJoiningDate.value=selectedJoiningDate;
                                              });
                                            }
                                        ),


                                      ],
                                    )
                                ),
                                SizedBox(width: 10,),
                                Flexible(
                                  child: Column(
                                    children: <Widget>[
                                      commonTextFieldTitle(headerName: appEndDate,isMendatory: true),
                                      SizedBox(height: 5,),
                                      commonTextField(
                                          isRealOnly: true,
                                          controller: controller.employedTillControllers,
                                          hintText: appSelectDesignation,
                                          onTap: (){
                                            selectDate(
                                                context,
                                                isEndDate: true,
                                                firstDateData: convertStringDateTime(date: controller.joiningDateControllers.text??""),
                                                onSelectedDate: (String employedTill) {
                                                  controller.employedTillControllers.text=employedTill;
                                                  controller.selectedEmployedTill.value=employedTill;

                                                });
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 5,),
                            Container(
                              alignment: Alignment.topRight,
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Obx(() => SizedBox(
                                        height: 14,
                                        width: 14,
                                        child: Checkbox(
                                          activeColor: appPrimaryColor,
                                          checkColor: appWhiteColor,
                                          side: BorderSide(color:appGreyBlackColor,width: 1 ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4), // Set border radius to 4
                                          ),
                                          value: controller.isPurcuing.value,
                                          onChanged: (value) {
                                            controller.isPurcuing.value = !controller.isPurcuing.value;
                                          },
                                        ),
                                      )),
                                      SizedBox(width: 10,),
                                      Text(appOngoing,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),

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
                                }, portfolioType: 'Upload Image', );
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
                      SizedBox(height: 20,),
                      commonButton(
                          context,
                          buttonName: appSave,
                          buttonBackgroundColor: appPrimaryColor,
                          textColor: appWhiteColor,
                          buttonBorderColor: appPrimaryColor,
                          onClick: (){
                            controller.addEducationValidation(context);
                          }
                      ),




                      SizedBox(height: 50,)
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

}