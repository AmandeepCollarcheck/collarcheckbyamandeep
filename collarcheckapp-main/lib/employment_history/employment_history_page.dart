import 'package:collarchek/employment_history/employment_history_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_methods.dart';
import 'package:collarchek/utills/common_widget/common_text_field.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../models/employment_list_model.dart';
import '../utills/common_widget/common_appbar.dart';
import '../utills/common_widget/progress.dart';
import '../utills/image_path.dart';

class EmploymentHistoryPage extends GetView<EmploymentHistoryControllers>{
  const EmploymentHistoryPage({super.key});

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
                  commonActiveWithDeleteIcon(
                    onClick: (){
                      controller.backButtonClick(context);
                    },
                    leadingIcon: appBackSvgIcon,
                    screenName: appEmploymentHistory, onDeleteClick: (){},
                  ),
                  SizedBox(height: 20,),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                commonTextFieldTitle(headerName: appDesignation,isMendatory: true),
                                GestureDetector(
                                  onTap: (){},
                                  child: Text(appDesignationChanged,style: AppTextStyles.font16W600.copyWith(color: appPrimaryColor),),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            ///Designation
                            Obx((){
                              var designation=controller.designationListData.value.data?.designationList??[];
                              return designation!=null&&designation.isNotEmpty?customDropDown(
                                  hintText: appSelectDesignation,
                                  item: [{"id":"0","name": appSelectDesignation},
                                    ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                  ],
                                  selectedValue: designation.any((datum)=>datum.id==controller.selectedDesignationDropDown["id"])?controller.selectedDesignationDropDown:{"id":"0","name": appSelectDesignation},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if(selectedData!=null){
                                      controller.selectedDesignationDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectDesignation
                                      };
                                      controller.selectedDesignation.value=selectedData['name'];
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
                            commonTextFieldTitle(headerName: appCompany,isMendatory: true),
                            SizedBox(height: 5,),
                            ///Select Company
                            Obx((){
                              var designation=controller.designationListData.value.data?.companyList??[];

                              return designation!=null&&designation.isNotEmpty?customDropDown(
                                  hintText: appSelectCompany,
                                  item: [{"id":"0","name": appSelectCompany},
                                    ...designation.map((data)=>{'id':data.id,'name':data.company}).toList()??[]
                                  ],
                                  selectedValue: designation.any((detum)=>detum.id==controller.selectedCompanyDropDown["id"])?controller.selectedCompanyDropDown:{"id":"0","name": appSelectCompany},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if(selectedData!=null){
                                      controller.selectedCompanyDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectCompany
                                      };
                                      controller.selectedCompany.value=selectedData['name'];
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):Container();
                            }),
                            // commonTextField(
                            //     isRealOnly: true,
                            //     controller: controller.companyController,
                            //     hintText: appSelectDesignation
                            // ),
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appDepartment,isMendatory: true),
                            SizedBox(height: 5,),
                            ///Select Department
                            Obx((){
                              var designation=controller.designationListData.value.data?.departmentList??[];

                              return designation!=null&&designation.isNotEmpty?customDropDown(
                                  hintText: appSelectDepartment,
                                  item: [{"id":"0","name": appSelectDepartment},
                                    ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[]

                                  ],
                                  selectedValue: designation.any((detum)=>detum.id==controller.selectedDepartmentDropDown["id"])?controller.selectedDepartmentDropDown:{"id":"0","name": appSelectDepartment},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if(selectedData!=null){
                                      controller.selectedDepartmentDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectDepartment
                                      };
                                      controller.selectedDepartment.value=selectedData['name'];
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):Container();
                            }),
                            // commonTextField(
                            //     isRealOnly: true,
                            //     controller: controller.departmentController,
                            //     hintText: appSelectDesignation
                            // ),
                            SizedBox(height: 10,),
                            ///Joining date and Employee Till
                            Row(
                              children: <Widget>[
                                Flexible(
                                    child: Column(
                                      children: <Widget>[
                                        commonTextFieldTitle(headerName: appJoiningDate,isMendatory: false),
                                        SizedBox(height: 5,),
                                        commonTextField(
                                            isRealOnly: true,
                                            controller: controller.joiningDateControllers,
                                            hintText: appChooseJoiningDate,
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
                                      commonTextFieldTitle(headerName: appEmployedTill,isMendatory: false),
                                      SizedBox(height: 5,),
                                      commonTextField(
                                          isRealOnly: true,
                                          controller: controller.employedTillControllers,
                                          hintText: appChooseEmployedTillDate,
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
                                  // child: Obx((){
                                  //   return controller.stateListData.value.data!=null&&controller.stateListData.value.data!.isNotEmpty?Column(
                                  //     children: <Widget>[
                                  //       commonTextFieldTitle(headerName: appEmployedTill,isMendatory: false),
                                  //       SizedBox(height: 5,),
                                  //       Obx((){
                                  //         return customDropDown(
                                  //           hintText: appAccomodationType,
                                  //           item: controller.stateListData.value.data?.map((datum) => {"id": datum.id, "name": datum.name,}).toList() ?? [],
                                  //           selectedValue: controller.stateListData.value.data != null && controller.stateListData.value.data!.isNotEmpty ? {"id": controller.stateListData.value.data?[0].id, "name": controller.stateListData.value.data?[0].name,} : null,
                                  //           onChanged: (Map<String,dynamic>? selectedData) {
                                  //             controller.getCityListApiCall(stateName:  selectedData?['id']);
                                  //             controller.state.value=selectedData?['name'];
                                  //           },
                                  //           icon: appDropDownIcon,);
                                  //       })
                                  //     ],
                                  //   ):Column();
                                  // })
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
                                          value: controller.isStillWorkingHere.value,
                                          onChanged: (value) {
                                            controller.isStillWorkingHere.value = !controller.isStillWorkingHere.value;
                                          },
                                        ),
                                      )),
                                      SizedBox(width: 10,),
                                      Text(appIAmStillWorkingHere,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            ///Employment Type
                            commonTextFieldTitle(headerName: appEmployType,isMendatory: true),
                            SizedBox(height: 5,),
                            Obx(() {
                              var employeeType = controller.designationListData.value.data?.employementTypeList ?? [];

                              if (controller.selectedEmployeeType.value == null && employeeType.length > 1) {
                                controller.selectedEmployeeType.value = int.parse(employeeType[0].id??""); // Default selection at index 1
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
                                        groupValue: controller.selectedEmployeeType.value, // Bind to selected value
                                        onChanged: (value) {
                                          controller.selectedEmployeeType.value = value; // Update selected value
                                          print("Selected Employee Type ID: $value");
                                        },),
                                      Text(employeeType[index].name ?? "",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),),
                                    ],
                                  );
                                }),
                              );
                            }),
                            ///Skills
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appSkills,isMendatory: true),
                            SizedBox(height: 5,),
                            Obx((){
                              var skills = List<DepartmentListElement>.from(controller.designationListData.value.data?.skillList ?? []);
                              return skills!=null&&skills.isNotEmpty?customDropDown(
                                  hintText: appSelectDepartment,
                                  item: [{"id":"0","name": appSelectSkill},
                                    ...skills.map((data)=>{'id':data.id,'name':data.name}).toList()??[],
                                  ],
                                  selectedValue: skills.any((detum)=>detum.id==controller.selectedSkillsDropDown["id"])?controller.selectedSkillsDropDown:{"id":"0","name": appSelectSkill},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if (selectedData != null) {
                                      controller.selectedSkillsDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectSkill
                                      };
                                      controller.selectedSkillsData.add(selectedData);
                                      controller.selectedSkills.value=selectedData['name'];// Add new selected skill
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):Container();
                            }),
                            SizedBox(height: 5,),
                            Obx((){
                              var skills=controller.selectedSkillsData.value??[];
                              return Wrap(
                                spacing: 10, // Horizontal spacing between items
                                runSpacing: 10, // Vertical spacing between items
                                children: skills.map((skill) {
                                  return IntrinsicWidth( // Ensures the width adjusts based on content
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: appWhiteColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: appPrimaryColor, width: 1),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min, // Ensures it wraps around content
                                        children: <Widget>[
                                          Text(
                                            ((skill is Map ? skill['name'] : skill.name) ?? '').isNotEmpty
                                                ? (skill is Map ? skill['name'] : skill.name)
                                                : '',
                                            style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),
                                          ),
                                          SizedBox(width: 5), // Spacing between text and icon
                                          SvgPicture.asset(appCloseIcon, height: 12, width: 12),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );

                            }),

                            ///Salary CtC
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appCTC,isMendatory: true),
                            SizedBox(height: 5,),
                            Obx((){
                              var ctc =controller.salaryType?? [];
                              return ctc!=null&&ctc.isNotEmpty?customDropDown(
                                  hintText: appSelectDepartment,
                                  item: [{"id":"0","name": appSelectCTC},
                                    ...ctc.map((data)=>{'id':data['id'],'name':data['name']}).toList()??[]
                                  ],
                                  selectedValue:ctc.any((datum)=>datum['id']==controller.selectedCTCDropDown["id"])?controller.selectedCTCDropDown:{"id":"0","name": appSelectCTC},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if (selectedData != null) {
                                      controller.selectedCTCDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectCTC
                                      };
                                      controller.selectedType.value=selectedData['name'];// Add new selected skill
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):Container();
                            }),
                            ///Ctc Amount
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appSalaryAmount,isMendatory: true),
                            SizedBox(height: 5,),
                            commonTextField(controller: controller.ctcAmount, hintText: appSalaryAmount,onTap: (){}),
                            ///Ctc type
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appCtcTpe,isMendatory: true),
                            SizedBox(height: 5,),
                            Obx((){
                              var salaryBracts =controller.salaryBracts?? [];
                              return salaryBracts!=null&&salaryBracts.isNotEmpty?customDropDown(
                                  hintText: appSelectDepartment,
                                  item: [{"id":"0","name": appSelectCTCType},
                                    ...salaryBracts.map((data)=>{'id':data['id'],'name':data['name']}).toList()??[]
                                  ],
                                  selectedValue: salaryBracts.any((datum)=>datum['id']==controller.selectedCTCTypeDropDown["id"])?controller.selectedCTCTypeDropDown:{"id":"0","name": appSelectCTCType},
                                  onChanged: (Map<String,dynamic>? selectedData){
                                    if (selectedData != null) {
                                      controller.selectedCTCTypeDropDown.value={
                                        "id": selectedData?['id'].toString() ?? "0",
                                        "name": selectedData?['name'].toString() ?? appSelectCTCType
                                      };
                                      controller.selectedType.value=selectedData['name'];// Add new selected skill
                                    }
                                  },
                                  icon: appDropDownIcon
                              ):Container();
                            }),


                            ///Role and Responsibility
                            SizedBox(height: 10,),
                            commonTextFieldTitle(headerName: appRoleAndResponsibility,isMendatory: true),
                            SizedBox(height: 5,),
                            commonTextField(controller: controller.rolesAndResponsibilityControllers, hintText: appRoleAndResponsibility,maxLine: 5),
                            ///Supportive Document
                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                    width:MediaQuery.of(context).size.width*0.8,
                                    child: Text(appSupportingDocument,style: AppTextStyles.font14W500.copyWith(color: appGreyBlackColor),)),
                                SizedBox(width: 5,),
                                Text("*",style: AppTextStyles.font12w500.copyWith(color: appRedColor),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            GestureDetector(
                              onTap: (){
                                getFileFromGallery(context,onFilePickedData: (String pickedData) {
                                  if(pickedData!=null){
                                    controller.selectedResumeName.value=pickedData;
                                  }
                                });
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
                                          Text(appUpdateResume,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),),
                                        ],
                                      )
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(appSupportedFormats,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                            SizedBox(height: 10,),
                            Obx((){
                              return controller.selectedResumeName.value.isNotEmpty? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: appPrimaryBackgroundColor
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Obx((){
                                      return SizedBox(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Text(controller.selectedResumeName.value,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),));
                                    }),
                                    GestureDetector(
                                        onTap:(){
                                          controller.selectedResumeName.value="";
                                        },
                                        child: SvgPicture.asset(appCloseIcon,height: 24,width: 24,))
                                  ],
                                ),
                              ):Container();
                            }),

                            SizedBox(height: 20,),


                          ],
                        ),
                      ),
                      commonButton(
                          context,
                          buttonName: controller.isEditData.value?appUpdateEmployement:appAddEmployement,
                          buttonBackgroundColor: appPrimaryColor,
                          textColor: appWhiteColor,
                          buttonBorderColor: appPrimaryColor,
                          onClick: (){
                            controller.addEmploymentValidation(context);
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