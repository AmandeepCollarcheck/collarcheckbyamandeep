import 'dart:io';

import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../api_provider/api_provider.dart';
import '../../models/company_all_employment_model.dart';
import '../../models/employment_list_model.dart';
import '../../models/save_user_profile_model.dart';
import '../app_colors.dart';
import '../app_key_constent.dart';
import '../app_strings.dart';
import '../font_styles.dart';
import '../image_path.dart';
import 'common_button.dart';
import 'common_methods.dart';
import 'common_text_field.dart';
import 'image_multipart.dart';
late ProgressDialog progressDialog=ProgressDialog() ;
var joiningDateControllers=TextEditingController();
var employeesControllers=TextEditingController();
var employedTillControllers=TextEditingController();
var rolesAndResponsibilityControllers=TextEditingController();
var ctcAmount=TextEditingController();
var salaryType=[{'id':"1","name":appCTC},{'id':"2","name":appInHand},].obs;
var salaryBracts=[{'id':"1","name":appAnnually},{'id':"2","name":appPerMonth},].obs;
Rx selectedDesignation="".obs;
Rx selectedDepartment="".obs;
Rx selectedCompany="".obs;
Rx selecteedEmployee="".obs;
Rx selectedJoiningDateData="".obs;
Rx selectedEmployedTill="".obs;
Rx selectedCTC="".obs;
Rx selectedType="".obs;
Rx selectedResumeName="".obs;
Rx isStillWorkingHere =false.obs;
var selectedEmployeeType = Rxn<int>();
var selectedSkillsData = [].obs;
var selectedSkillsSelectedData = [].obs;
var isEditData=false.obs;
Rx selectedSkills="".obs;
/// Dropdown
var selectedDesignationDropDown={"id":"0","name": appSelectDesignation}.obs;
var selectedCompanyDropDown={"id":"0","name": appSelectEmployee}.obs;
var selectedDepartmentDropDown={"id":"0","name": appSelectDepartment}.obs;
var selectedSkillsDropDown={"id":"0","name": appSelectSkill}.obs;
var selectedCTCDropDown={"id":"0","name": appSelectCTC}.obs;
var selectedEmployeeDropDown={"id":"0","name": appSelectDesignation}.obs;
var selectedCTCTypeDropDown={"id":"0","name": appSelectCTCType}.obs;

openAddEmploymentForm(context,{required DesignationListModel designationListData,required String screenNameData,required CompanyAllEmploymentModel companyAllEmployment}){
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: appWhiteColor,
      enableDrag: true,
      context: context,
      builder: (BuildContext context){
        return SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          child:SingleChildScrollView(
            child:  Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                          //Get.back();
                        },
                        child: SvgPicture.asset(appBackIconSvg,height: 12,width: 12,color: appBlackColor,),
                      ),
                      SizedBox(width: 15,),
                      Text(appAddNewEmployment,style: AppTextStyles.font20w600.copyWith(color: appBlackColor),)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      /// Form
                      ///Select Company
                      ///Select Company
                      commonTextFieldTitle(headerName: appSelectEmployee,isMendatory: true),
                      SizedBox(height: 5,),
                     // commonTextField(controller: employeesControllers, hintText: appEnterEmployee),
                      Obx((){
                        var employeeData=companyAllEmployment.data??[];

                        return employeeData!=null&&employeeData.isNotEmpty?customDropDown(
                            hintText: appSelectDesignation,
                            item: [{"id":"0","name": appSelectEmployee},
                              ...employeeData.map((data)=>{'id':data.id,'name':data.userName}).toList()??[]
                            ],
                            selectedValue: employeeData.any((detum)=>detum.id==selectedDesignationDropDown["id"])?selectedDesignationDropDown:{"id":"0","name": appSelectDesignation},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedDesignationDropDown.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectEmployee
                                };
                                employeesControllers.text=selectedData?['id'].toString() ?? "0";
                                selectedDesignation.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      commonTextFieldTitle(headerName: appDepartment,isMendatory: true),
                      SizedBox(height: 5,),
                      ///Select Department
                      Obx((){
                        var designation=designationListData.data?.departmentList??[];

                        return designation!=null&&designation.isNotEmpty?customDropDown(
                            hintText: appSelectDepartment,
                            item: [{"id":"0","name": appSelectDepartment},
                              ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[]

                            ],
                            selectedValue: designation.any((detum)=>detum.id==selectedDepartmentDropDown["id"])?selectedDepartmentDropDown:{"id":"0","name": appSelectDepartment},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedDepartmentDropDown.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectDepartment
                                };
                                selectedDepartment.value=selectedData['id'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      ///Select Designation
                      SizedBox(height: 10,),
                      commonTextFieldTitle(headerName: appDesignation,isMendatory: true),
                      SizedBox(height: 5,),
                      Obx((){
                        var designation=designationListData.data?.designationList??[];
                        return designation!=null&&designation.isNotEmpty?customDropDown(
                            hintText: appSelectDesignation,
                            item: [{"id":"0","name": appSelectDesignation},
                              ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: designation.any((datum)=>datum.id==selectedEmployeeDropDown["id"])?selectedEmployeeDropDown:{"id":"0","name": appSelectDesignation},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedEmployeeDropDown.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectDesignation
                                };
                                selecteedEmployee.value=selectedData['id'];
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
                                      controller: joiningDateControllers,
                                      hintText: appChooseJoiningDate,
                                      onTap: (){
                                        selectDate(context,onSelectedDate: (String selectedJoiningDate) {
                                          joiningDateControllers.text=selectedJoiningDate;
                                          selectedJoiningDateData.value=selectedJoiningDate;
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
                                commonTextFieldTitle(headerName: appEmployedTill,isMendatory: true),
                                SizedBox(height: 5,),
                                commonTextField(
                                    isRealOnly: true,
                                    controller: employedTillControllers,
                                    hintText: appChooseEmployedTillDate,
                                    onTap: (){
                                      selectDate(
                                          context,
                                          isEndDate: true,
                                          firstDateData: convertStringDateTime(date: joiningDateControllers.text??""),
                                          onSelectedDate: (String employedTill) {
                                            employedTillControllers.text=employedTill;
                                            selectedEmployedTill.value=employedTill;

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
                                    value: isStillWorkingHere.value,
                                    onChanged: (value) {
                                      isStillWorkingHere.value = !isStillWorkingHere.value;
                                    },
                                  ),
                                )),
                                SizedBox(width: 10,),
                                Text(appEmployeeStillWorkingHere,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)
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
                        var employeeType = designationListData.data?.employementTypeList ?? [];

                        if (selectedEmployeeType.value == null && employeeType.length > 1) {
                          selectedEmployeeType.value = int.parse(employeeType[0].id??""); // Default selection at index 1
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
                                  groupValue: selectedEmployeeType.value, // Bind to selected value
                                  onChanged: (value) {
                                    selectedEmployeeType.value = value; // Update selected value
                                    print("Selected Employee Type ID: $value");
                                  },),
                                Text(employeeType[index].name ?? "",style: AppTextStyles.font14W500.copyWith(color: appBlackColor),),
                              ],
                            );
                          }),
                        );
                      }),
                      SizedBox(height: 10,),
                      commonTextFieldTitle(headerName: appSkills,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var skills = List<DepartmentListElement>.from(designationListData.data?.skillList ?? []);
                        return skills!=null&&skills.isNotEmpty?customDropDown(
                            hintText: appSelectDepartment,
                            item: [{"id":"0","name": appSelectSkill},
                              ...skills.map((data)=>{'id':data.id,'name':data.name}).toList()??[],
                            ],
                            selectedValue: skills.any((detum)=>detum.id==selectedSkillsDropDown["id"])?selectedSkillsDropDown:{"id":"0","name": appSelectSkill},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if (selectedData != null) {
                                selectedSkillsDropDown.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectSkill
                                };
                                print("/////");
                                print(selectedData);
                                selectedSkillsData.add(selectedData);
                                selectedSkillsSelectedData.add(selectedData['name']);
                                selectedSkills.value=selectedData['name'];// Add new selected skill
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 5,),
                      Obx((){
                        var skills=selectedSkillsData.value??[];
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
                      ///Role and Responsibility
                      SizedBox(height: 10,),
                      commonTextFieldTitle(headerName: appRoleAndResponsibility,isMendatory: false),
                      SizedBox(height: 5,),
                      commonTextField(controller: rolesAndResponsibilityControllers, hintText: appRoleAndResponsibility,maxLine: 5),
                      ///CTC Detial
                      SizedBox(height: 10,),
                      commonTextFieldTitle(headerName: appCTC,isMendatory: true),
                      SizedBox(height: 5,),
                      Obx((){
                        var ctc =salaryType?? [];
                        return ctc!=null&&ctc.isNotEmpty?customDropDown(
                            hintText: appSelectDepartment,
                            item: [{"id":"0","name": appSelectCTC},
                              ...ctc.map((data)=>{'id':data['id'],'name':data['name']}).toList()??[]
                            ],
                            selectedValue:ctc.any((datum)=>datum['id']==selectedCTCDropDown["id"])?selectedCTCDropDown:{"id":"0","name": appSelectCTC},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if (selectedData != null) {
                                selectedCTCDropDown.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectCTC
                                };
                                selectedCTC.value=selectedData['name'];// Add new selected skill
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      ///Ctc Amount
                      SizedBox(height: 10,),
                      commonTextFieldTitle(headerName: appSalaryAmount,isMendatory: true),
                      SizedBox(height: 5,),
                      commonTextField(controller: ctcAmount, hintText: appSalaryAmount,onTap: (){}),
                      ///Ctc type
                      SizedBox(height: 10,),
                      commonTextFieldTitle(headerName: appCtcTpe,isMendatory: true),
                      SizedBox(height: 5,),
                      Obx((){
                        var salaryBract =salaryBracts?? [];
                        return salaryBracts!=null&&salaryBracts.isNotEmpty?customDropDown(
                            hintText: appSelectDepartment,
                            item: [{"id":"0","name": appSelectCTCType},
                              ...salaryBracts.map((data)=>{'id':data['id'],'name':data['name']}).toList()??[]
                            ],
                            selectedValue: salaryBracts.any((datum)=>datum['id']==selectedCTCTypeDropDown["id"])?selectedCTCTypeDropDown:{"id":"0","name": appSelectCTCType},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if (selectedData != null) {
                                selectedCTCTypeDropDown.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectCTCType
                                };
                                selectedType.value=selectedData['name'];// Add new selected skill
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
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
                              selectedResumeName.value=pickedData;
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
                        return selectedResumeName.value.isNotEmpty? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: appWhiteColor
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
                                    child: Text(selectedResumeName.value,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),));
                              }),
                              GestureDetector(
                                  onTap:(){
                                    selectedResumeName.value="";
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
                    buttonName: isEditData.value?appUpdateEmployement:appAddEmployement,
                    buttonBackgroundColor: appPrimaryColor,
                    textColor: appWhiteColor,
                    buttonBorderColor: appPrimaryColor,
                    onClick: (){
                      addEmploymentValidation(context, screenNameData: screenNameData);
                    }
                ),
                SizedBox(height: 20,)

              ],
            ),
          ),
        );
      }
  );
}

addEmploymentValidation(context,{required String screenNameData}){
  if(employeesControllers.text==null||employeesControllers.text.isEmpty){
    showToast(appPleaseSelectEmployee);
  }else if(selectedDepartment.value==null||selectedDepartment.value==""){
    showToast(appPleaseSelectDepartment);
  }else if(selecteedEmployee.value==null||selecteedEmployee.value==""){
    showToast(appPleaseSelectDesignation);
  }else if(selectedJoiningDateData.value==null||selectedJoiningDateData.value==""){
    showToast(appPleaseSelectJoiningDate);
  }else if (!isStillWorkingHere.value && (selectedEmployedTill == null || selectedEmployedTill.value == "")) {
    showToast(appPleaseSelectEmpluedDate);
  }else if(selectedCTC.value==null||selectedCTC.value==""){
    showToast(appPleaseSelectCTC);
  }else if(ctcAmount.text==null||ctcAmount.text.isEmpty){
    showToast(appPleaseSelectCTCAmount);
  }else if(selectedType.value==null||selectedType.value==""){
    showToast(appPleaseSelectCTCType);
  }else if(selectedType.value==null||selectedType.value==""){
    showToast(appPleaseSelectCTCType);
  }else{
    if(isEditData.value){
      //updateEmploymentApiCall(context);
    }else{
      addEmploymentApiCall(context, screenNameData: screenNameData);
    }

  }
}

addEmploymentApiCall(context,{required String screenNameData})async{
  try {
    keyboardDismiss(context);
    progressDialog.show();
    var documentFile = await convertFileToMultipart(selectedResumeName.value??'');
    var formData = dio.FormData.fromMap({
      "user":employeesControllers.text.toString(),
      "employment_type":selectedEmployeeType.value.toString(),
      "designation":selecteedEmployee.value.toString()??'',
      "salary":ctcAmount.value.text.toString()??"",
      "salary_inhand":selectedCTC.value.replaceAll(" ", "").toLowerCase()??"",
      "salary_mode":selectedType.value.toString(),
      "joining_date":convertDateFormat(selectedJoiningDateData.value.toString()??''),
      "worked_till_date":convertDateFormat(selectedEmployedTill.value.toString()??''),
      "department":selectedDepartment.value.toString()??"",
      "still_working":isStillWorkingHere.value?"1":"0",
      "description":rolesAndResponsibilityControllers.text??"",
      "document[0]":documentFile??'',

    });



    for (int i = 0; i < selectedSkillsData.length; i++) {
      formData.fields.add(MapEntry("skill[$i]", selectedSkillsData[i]['name'].toString()));
    }
    SaveUserProfileModel addEmployment = await ApiProvider.baseWithToken().addCompanyEmployment(formData);
    if(addEmployment.status==true){
      if (progressDialog.isShowing()) {
        Get.back();
      }
      if(screenNameData==companyEmployeesScreen){
        Navigator.pop(context);
        Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
      }
      // if(screenNameData.value==dashboard){
      //   Get.offNamed(AppRoutes.bottomNavBar);
      // }else if(screenNameData.value==profileDetails){
      //   Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"4"});
      // }else{
      //   Get.offNamed(AppRoutes.bottomNavBar);
      // }
    }else{
      showToast(somethingWentWrong);
    }
    progressDialog.dismissLoader();
  } on HttpException catch (exception) {
    progressDialog.dismissLoader();
    showToast(exception.message);
  } catch (exception) {
    progressDialog.dismissLoader();
    showToast(exception.toString());
  }
}