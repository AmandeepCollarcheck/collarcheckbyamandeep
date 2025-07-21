import 'package:collarchek/educations/education_controllers.dart';
import 'package:collarchek/models/state_list_model.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../models/city_list_model.dart';
import '../models/education_details_model.dart';
import '../utills/app_colors.dart';
import '../utills/app_strings.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/common_methods.dart';
import '../utills/common_widget/common_text_field.dart';
import '../utills/common_widget/progress.dart';
import '../utills/font_styles.dart';
import '../utills/image_path.dart';

class EducationPage extends GetView<EducationControllers>{
  const EducationPage({super.key});

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
                    screenName: appAddEducation, onShareClick: (){}, onFilterClick: (){}, actionButton: '',
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
                              var designation = List<CourseListElement>.from(controller.educationDataDetails.value.data?.institutionList ?? []);
                              return designation!=null&&designation.isNotEmpty?customDropDown(
                                  hintText: appSelectDesignation,
                                  item: [{"id":"0","name":appSelectedUniversity},
                                    ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                  ],
                                  selectedValue: designation.any((datum)=>datum.id==controller.selectedUniverCityDropDown["id"])?controller.selectedUniverCityDropDown:{"id":"0","name":appSelectedUniversity},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if(selectedData!=null){
                                      controller.selectedUniverCityDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectedUniversity
                                      };
                                      controller.selectedInstitutationData.value=selectedData['name'];
                                      controller.selectedInstitutationIdData.value=selectedData['id'];
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):Container();
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

                              // designation.insert(0, CourseListElement(id: "0", name: "Select"));
                              return designation!=null&&designation.isNotEmpty?customDropDown(
                                  hintText: appSelectCompany,
                                  item: [{"id":"0","name":appSelectedCourse},
                                    ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                  ],
                                  selectedValue: designation.any((datum)=>datum.id==controller.selectedCourseDropDown["id"])?controller.selectedCourseDropDown:{"id":"0","name":appSelectedCourse},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if(selectedData!=null){
                                      controller.selectedCourseDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectedCourse
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
                                            if(controller.isPurcuing.value){
                                              showToast(appThisCourseIsMarkedAsPursuing);
                                            }else{
                                              selectDate(
                                                  context, isEndDate: true,
                                                  firstDateData: convertStringDateTime(date: controller.joiningDateControllers.text??""),
                                                  onSelectedDate: (String employedTill) {
                                                    controller.employedTillControllers.text=employedTill;
                                                    controller.selectedEmployedTill.value=employedTill;
                                                  });
                                            }

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
                                      Text(appPursuing,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            ///Course Type
                            commonTextFieldTitle(headerName: appCourseType,isMendatory: true),
                            SizedBox(height: 5,),
                            Obx(() {
                              var employeeType = controller.educationDataDetails.value.data?.courseTypeList ?? [];

                              if (controller.selectedCourseTypeData.value == null && employeeType.length > 1) {
                                controller.selectedCourseTypeData.value = int.parse(employeeType[0].id??""); // Default selection at index 1
                              }
                              return Wrap(
                                spacing: 10, // Add spacing between radio buttons
                                children: List.generate(employeeType.length, (index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
                                    children: <Widget>[
                                      Radio<int>(
                                        value: int.parse(employeeType[index].id??""), // Set correct value
                                        groupValue: controller.selectedCourseTypeData.value, // Bind to selected value
                                        onChanged: (value) {
                                          controller.selectedCourseTypeData.value = value; // Update selected value
                                          print("Selected Employee Type ID: $value");
                                        },),
                                      Text(employeeType[index].name ?? "",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),),
                                    ],
                                  );
                                }),
                              );
                            }),
                            ///Country
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appCountry,isMendatory: true),
                            SizedBox(height: 5,),
                            Obx((){
                              var skills = List<CountryList>.from(controller.educationDataDetails.value.data?.countryList ?? []);
                              return skills!=null&&skills.isNotEmpty?customDropDown(
                                  hintText: appSelectDepartment,
                                  item: [{"id":"0","name":appSelectCountry},
                                    ...skills.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                  ],
                                  selectedValue: skills.any((datum)=>datum.id==controller.selectedCountryDropDown["id"])?controller.selectedCountryDropDown:{"id":"0","name":appSelectCountry},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if (selectedData != null) {
                                      controller.selectedCountryDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectCountry
                                      };
                                      controller.selectedCountryData.value=selectedData['name'];// Add new selected skill
                                      controller.selectedCountryIdData.value=selectedData['id'];// Add new selected skill
                                      ///Calling State Api
                                      controller.getStateListApiCall(countryName: selectedData['id']);
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):Container();
                            }),
                            ///State
                            SizedBox(height: 10,),
                            Obx((){
                              var stateList = List<StateDatum>.from(controller.stateListData.value.data ?? []);
                              return Column(
                                children: <Widget>[
                                  stateList!=null&&stateList.isNotEmpty?commonTextFieldTitle(headerName: appState,isMendatory: true):Container(),
                                  SizedBox(height: 5,),
                                  stateList!=null&&stateList.isNotEmpty?customDropDown(
                                      hintText: appSelectDepartment,
                                      item:[{"id":"0","name":appSelectState},
                                        ... stateList.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                      ],
                                      selectedValue: stateList.any((datum)=>datum.id==controller.selectedStateDropDown["id"])?controller.selectedStateDropDown:{"id":"0","name":appSelectState},
                                      onChanged: (Map<String,dynamic>? selectedData){
                                        if (selectedData != null) {
                                          controller.selectedStateDropDown.value={
                                            "id": selectedData?['id'].toString() ?? "0",
                                            "name": selectedData?['name'].toString() ?? appSelectState
                                          };
                                          controller.selectedStateData.value=selectedData['name'];
                                          controller.selectedStateIdData.value=selectedData['id'];
                                          controller.getCityListApiCall(stateName: selectedData['id']??"");
                                        }
                                      },
                                      icon: appDropDownIcon
                                  ):Container()
                                ],
                              );
                            }),

                            ///City
                            SizedBox(height: 10,),
                            Obx((){
                              var cityName = List<CityDatum>.from(controller.cityListData.value.data ?? []);
                              return Column(
                                children: <Widget>[
                                  cityName!=null&&cityName.isNotEmpty?commonTextFieldTitle(headerName: appResidingCity,isMendatory: true):Container(),
                                  SizedBox(height: 5,),
                                  cityName!=null&&cityName.isNotEmpty?customDropDown(
                                      hintText: appSelectDepartment,
                                      item: [{"id":"0","name":appSelectCity},
                                        ...cityName.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                      ],
                                      selectedValue: cityName.any((datum)=>datum.id==controller.selectedCityDropDown["id"])?controller.selectedCityDropDown:{"id":"0","name":appSelectCity},
                                      onChanged: (Map<String,dynamic>? selectedData){
                                        if (selectedData != null) {

                                          controller.selectedCityDropDown.value={
                                            "id": selectedData?['id'].toString() ?? "0",
                                            "name": selectedData?['name'].toString() ?? appSelectCity
                                          };
                                          controller.selectedCityData.value=selectedData['name'];// Add new selected skill
                                          controller.selectedCityIdData.value=selectedData['id'];// Add new selected skill
                                        }
                                      },
                                      icon: appDropDownIcon
                                  ):Container()
                                ],
                              );
                            }),


                            ///HigestQuilification
                            SizedBox(height: 10,),
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
                                    value: controller.isHeigestQuilification.value,
                                    onChanged: (value) {
                                      controller.isHeigestQuilification.value = !controller.isHeigestQuilification.value;
                                    },
                                  ),
                                )),
                                SizedBox(width: 10,),
                                Text(appThisISMyHeigst,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)
                              ],
                            ),
                            ///Certificates
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appCertificates,isMendatory: false),
                            SizedBox(height: 5,),
                            GestureDetector(
                              onTap: (){

                                getPortfolioTypeFromGallery(context,onFilePickedData: (String fileName,String pickedData) {
                                  if(pickedData!=null){
                                    controller.selectedImageFromTHeGallery.value=pickedData;
                                    controller.selectedFileName.value=fileName;
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
                      commonButton(
                          context,
                          buttonName:controller.isEditData.value?appUpDateEducation: appAddEducation,
                          buttonBackgroundColor: appPrimaryColor,
                          textColor: appWhiteColor,
                          buttonBorderColor: appPrimaryColor,
                          onClick: (){
                            if(controller.isEditData.value){
                              controller.editEducationApiCall(context);

                            }else{
                              controller.addEducationValidation(context);
                            }

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