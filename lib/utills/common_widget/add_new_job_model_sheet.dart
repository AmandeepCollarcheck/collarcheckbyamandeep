import 'dart:io';

import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:dio/dio.dart' as dio;
import '../../api_provider/api_provider.dart';
import '../../models/city_list_model.dart';
import '../../models/company_all_details_data.dart';
import '../../models/save_user_profile_model.dart';
import '../../models/state_list_model.dart';
import '../app_colors.dart';
import '../app_key_constent.dart';
import '../app_route.dart';
import '../app_strings.dart';
import '../font_styles.dart';
import '../image_path.dart';
import 'common_button.dart';
import 'common_methods.dart';
import 'common_text_field.dart';
import 'image_multipart.dart';

late ProgressDialog progressDialog=ProgressDialog() ;
var stateListData=StateListModel().obs;
var cityListData=CityListModel().obs;
var noOfVaccencyController=TextEditingController();
var jobDescriptionController=TextEditingController();
var appIndustryControllers=TextEditingController();
var selectedImageFromTHeGallery="".obs;
var selectedSkillsData = [].obs;
var selectedJobTitle={"id":"0","name": appSelectedJobTitles}.obs;
var selectedSkills={"id":"0","name": appSelectSkill}.obs;
var selectedDepartment={"id":"0","name": appSelectDepartment}.obs;
var selectedDesignationt={"id":"0","name": appSelectDesignation}.obs;
var selectedExperience={"id":"0","name": appSelectExperience}.obs;
var selectedSalary={"id":"0","name": appSelectSalary}.obs;
var selectedRoleType={"id":"0","name": appSelectRole}.obs;
var selectedCountry={"id":"0","name": appSelectCountry}.obs;
var selectedState={"id":"0","name": appSelectState}.obs;
var selectedCity={"id":"0","name": appSelectCity}.obs;
var selectedWorkMode={"id":"0","name": appSelectWorkMode}.obs;
var isUrgentJob=false.obs;

addNewJobForm(context,{required  CompanyAllDetailsData companyAllDetails,required String screenNameData }){
  return showModalBottomSheet(
    backgroundColor: appScreenBackgroundColor,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context){
        return SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(appBackIconSvg,height: 12,width: 12,color: appBlackColor,),
                      ),
                      SizedBox(width: 15,),
                      Text(appAddNewJobPosted,style: AppTextStyles.font20w600.copyWith(color: appBlackColor),)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                    ///Job Title
                      commonTextFieldTitle(headerName: appJobTitle,isMendatory: true),
                      SizedBox(height: 5,),
                      Obx((){
                        var jobTitle=companyAllDetails.data?.designationList??[];
                        return jobTitle!=null&&jobTitle.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectedJobTitles},
                              ...jobTitle.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: jobTitle.any((detum)=>detum.id==selectedJobTitle["id"])?selectedJobTitle:{"id":"0","name": appSelectCompany},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedJobTitle.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectCompany
                                };
                                //selectedCompany.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                     SizedBox(height: 10,),
                     /// No of Vacency
                      commonTextFieldTitle(headerName: appNoOfVacancies,isMendatory: true),
                      SizedBox(height: 5,),
                      commonTextField(controller: noOfVaccencyController, hintText: appNoOfVacancies,keyboardType: TextInputType.phone),
                      SizedBox(height: 10,),
                      ///Job Description
                      commonTextFieldTitle(headerName: appJobDescription,isMendatory: true),
                      SizedBox(height: 5,),
                      commonTextField(controller: jobDescriptionController, hintText: appJobDescription,maxLine: 5),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset(appAISvg,height: 16,width: 16,),
                          Text(appReWriteWithAi,style: AppTextStyles.font14Underline.copyWith(color: appPrimaryColor),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      ///Skills
                      commonTextFieldTitle(headerName: appSkills,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var skills=companyAllDetails.data?.skillList??[];
                        return skills!=null&&skills.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectSkill},
                              ...skills.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: skills.any((detum)=>detum.id==selectedSkills["id"])?selectedSkills:{"id":"0","name": appSelectSkill},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedSkills.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectCompany
                                };
                                selectedSkillsData.add(selectedData);
                                //selectedCompany.value=selectedData['name'];
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
                      SizedBox(height: 10,),
                      ///Industry
                      commonTextFieldTitle(headerName: appIndustry,isMendatory: false),
                      SizedBox(height: 5,),
                      commonTextField(controller: appIndustryControllers, hintText: appIndustry),
                      SizedBox(height: 10,),
                      /// Department
                      commonTextFieldTitle(headerName: appDepartment,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var department=companyAllDetails.data?.departmentList??[];
                        return department!=null&&department.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectDepartment},
                              ...department.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: department.any((detum)=>detum.id==selectedDepartment["id"])?selectedDepartment:{"id":"0","name": appSelectDepartment},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedDepartment.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectDepartment
                                };
                                //selectedCompany.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Designation
                      commonTextFieldTitle(headerName: appDesignation,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var designation=companyAllDetails.data?.designationList??[];
                        return designation!=null&&designation.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectDesignation},
                              ...designation.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: designation.any((detum)=>detum.id==selectedDesignationt["id"])?selectedDesignationt:{"id":"0","name": appSelectDesignation},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedDesignationt.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectDesignation
                                };
                                //selectedCompany.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Experience
                      commonTextFieldTitle(headerName: appExperience,isMendatory: true),
                      SizedBox(height: 5,),
                      Obx((){
                        var experience=companyAllDetails.data?.jobExperienceList??[];
                        return experience!=null&&experience.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectExperience},
                              ...experience.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: experience.any((detum)=>detum.id==selectedExperience["id"])?selectedExperience:{"id":"0","name": appSelectExperience},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedExperience.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectExperience
                                };
                                //selectedCompany.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Salary
                      commonTextFieldTitle(headerName: appSalary,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var salary=companyAllDetails.data?.salaryList??[];
                        return salary!=null&&salary.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectSalary},
                              ...salary.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: salary.any((detum)=>detum.id==selectedSalary["id"])?selectedSalary:{"id":"0","name": appSelectSalary},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedSalary.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectSalary
                                };
                                //selectedCompany.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Role Type
                      commonTextFieldTitle(headerName: appSelectRole,isMendatory: true),
                      SizedBox(height: 5,),
                      Obx((){
                        var roleType=companyAllDetails.data?.roleTypeList??[];
                        return roleType!=null&&roleType.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectRole},
                              ...roleType.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: roleType.any((detum)=>detum.id==selectedRoleType["id"])?selectedRoleType:{"id":"0","name": appSelectRole},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedRoleType.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectRole
                                };
                                //selectedCompany.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Country
                      commonTextFieldTitle(headerName: appSelectCountry,isMendatory: false),
                      SizedBox(height: 5,),
                      Obx((){
                        var country=companyAllDetails.data?.countryList??[];
                        return country!=null&&country.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectCountry},
                              ...country.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: country.any((detum)=>detum.id==selectedCountry["id"])?selectedCountry:{"id":"0","name": appSelectCountry},
                            onChanged: (Map<String,dynamic>? selectedData) async {
                              if(selectedData!=null){
                                selectedCountry.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectCountry
                                };
                                //selectedCompany.value=selectedData['name'];
                                 getStateListApiCall(countryName: selectedData?['id'].toString() ?? "0");
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      ///State
                      Obx((){
                        var state=stateListData.value.data??[];
                        return state.isNotEmpty?Column(
                          children: <Widget>[
                            commonTextFieldTitle(headerName: appSelectState,isMendatory: false),
                            SizedBox(height: 5,),
                            state!=null&&state.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectState},
                              ...state.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: state.any((detum)=>detum.id==selectedState["id"])?selectedState:{"id":"0","name": appSelectState},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedState.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectState
                                };
                                getCityListApiCall(stateName: selectedData?['id'].toString() ?? "0");
                                //selectedCompany.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                            ):Container()
                          ],
                        ):Column();
                      }),
                      SizedBox(height: 10,),
                      ///City
                      Obx((){
                        var city=cityListData.value.data??[];
                        return city.isNotEmpty?Column(
                          children: <Widget>[
                            commonTextFieldTitle(headerName: appSelectCity,isMendatory: false),
                            SizedBox(height: 5,),
                            city!=null&&city.isNotEmpty?customDropDown(
                                hintText: appSelectCompany,
                                item: [{"id":"0","name": appSelectCity},
                                  ...city.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                                ],
                                selectedValue: city.any((detum)=>detum.id==selectedCity["id"])?selectedCity:{"id":"0","name": appSelectCity},
                                onChanged: (Map<String,dynamic>? selectedData){
                                  if(selectedData!=null){
                                    selectedCity.value={
                                      "id": selectedData?['id'].toString() ?? "0",
                                      "name": selectedData?['name'].toString() ?? appSelectCity
                                    };
                                    //selectedCompany.value=selectedData['name'];
                                  }
                                },
                                icon: appDropDownIcon
                            ):Container()
                          ],
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Work Mode
                      commonTextFieldTitle(headerName: appWorkMode,isMendatory: true),
                      SizedBox(height: 5,),
                      Obx((){
                        var workMode=companyAllDetails.data?.jobModeList??[];
                        return workMode!=null&&workMode.isNotEmpty?customDropDown(
                            hintText: appSelectCompany,
                            item: [{"id":"0","name": appSelectSalary},
                              ...workMode.map((data)=>{'id':data.id,'name':data.name}).toList()??[]
                            ],
                            selectedValue: workMode.any((detum)=>detum.id==selectedWorkMode["id"])?selectedWorkMode:{"id":"0","name": appSelectWorkMode},
                            onChanged: (Map<String,dynamic>? selectedData){
                              if(selectedData!=null){
                                selectedWorkMode.value={
                                  "id": selectedData?['id'].toString() ?? "0",
                                  "name": selectedData?['name'].toString() ?? appSelectSalary
                                };
                                //selectedCompany.value=selectedData['name'];
                              }
                            },
                            icon: appDropDownIcon
                        ):Container();
                      }),
                      SizedBox(height: 10,),
                      ///Add Pdf
                      commonTextFieldTitle(headerName: appAddPdf,isMendatory: false),
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: (){

                          getFileFromGallery(context,onFilePickedData: (String pickedData) {
                            if(pickedData!=null){
                              selectedImageFromTHeGallery.value=pickedData;
                            }
                          }, );
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
                        return selectedImageFromTHeGallery.value.isNotEmpty? Container(
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
                                    child: Text(selectedImageFromTHeGallery.value,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),));
                              }),
                              GestureDetector(
                                  onTap:(){
                                    selectedImageFromTHeGallery.value="";
                                  },
                                  child: SvgPicture.asset(appCloseIcon,height: 24,width: 24,))
                            ],
                          ),
                        ):Container();
                      }),
                      Text(appSupportedFormats,style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),),
                      SizedBox(height: 10,),
                      ///Mark as urgent
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
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
                                value: isUrgentJob.value,
                                onChanged: (value) {
                                  isUrgentJob.value = !isUrgentJob.value;
                                },
                              ),
                            )),
                            SizedBox(width: 10,),
                            Text(appMarkAsUrgent,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: 40,
                        child:commonButton(
                            isPaddingDisabled: true,
                            context,
                            buttonName: appSaveDraft,
                            buttonBackgroundColor: appWhiteColor,
                            textColor: appPrimaryColor,
                            buttonBorderColor: appPrimaryColor,
                            isPrefixIconShow: false,
                            isPrefixIcon: appViewJd,
                            onClick: (){

                            }
                        ),
                      ),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: 40,
                        child:commonButton(
                            isPaddingDisabled: true,
                            context,
                            buttonName: appPublishedJob,
                            buttonBackgroundColor: appPrimaryColor,
                            textColor: appWhiteColor,
                            buttonBorderColor: appPrimaryColor,
                            onClick: (){
                              addJobValidation(context, screenNameData: screenNameData);
                            }
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 1,
                  color: appPrimaryBackgroundColor,
                )
              ],
            ),
          ),
        );
      }
  );
}

void addJobValidation(context, {required String screenNameData}) {

  if (isInvalidSelection(selectedJobTitle.value, appSelectedJobTitles)) {
    showToast(appSelectJobTitle);
  } else if(noOfVaccencyController.text==null||noOfVaccencyController.text.isEmpty){
    showToast(appEnterVacancy);
  }else if(jobDescriptionController.text==null||jobDescriptionController.text.isEmpty){
    showToast(appWriteJobDescription);
  }else if(isInvalidSelection(selectedExperience.value, appSelectExperience)) {
    showToast(appSelectExperienceText);
  }else if(isInvalidSelection(selectedRoleType.value, appSelectRole)) {
    showToast(appSelectRole);
  }else if(isInvalidSelection(selectedWorkMode.value, appSelectWorkMode)) {
    showToast(appSelectWorkMode);
  }else{
    _addNewJob(context,screenNameData: screenNameData);
  }


}

void _addNewJob(context,{required String screenNameData})async {
  try {
    keyboardDismiss(context);
    progressDialog.show();
     var documentFile = await convertFileToMultipart(selectedImageFromTHeGallery.value??'');
    // var formData = dio.FormData.fromMap({
    //   "job_title":selectedJobTitle.value["name"]??"",
    //   "job_description":jobDescriptionController.text??'',
    //   "roles_responsibility":selectedRoleType.value['name']??'',
    //   "experience":selectedExperience.value['id']??"",
    //   "role_type":selectedRoleType.value['id']??'',
    //   "country":selectedCountry.value['id']??'',
    //   "state":selectedState.value['id']??'',
    //   "salary":selectedSalary.value['id']??"",
    //   "document[0]":documentFile??'',
    //   "vacancy":int.tryParse(noOfVaccencyController.text)??"",
    //   "job_mode":selectedWorkMode.value['id']??"",
    //   //"status":isStillWorkingHere.value?1:0,
    //   "urgent":isUrgentJob.value??false,
    //   //"slug":isStillWorkingHere.value?1:0,
    //   "designation":selectedDesignationt.value["id"]??"",
    //   "department":selectedDepartment.value["id"]??"",
    //   "city":selectedCity.value["id"]??"",
    //   "industry":appIndustryControllers.text??""
    // });
    // for (int i = 0; i < selectedSkillsData.length; i++) {
    //   var skillId = selectedSkillsData[i]['id'];
    //   if (skillId != null) {
    //     formData.fields.add(MapEntry("skill[$i]", skillId.toString()));
    //   } else {
    //     print("Missing skill ID at index $i");
    //   }
    // }
    final data = {
      "job_title": selectedJobTitle.value["name"] ?? "",
      "job_description": jobDescriptionController.text,
      "roles_responsibility": selectedRoleType.value['name'] ?? '',
      "experience": selectedExperience.value['id'] ?? "",
      "role_type": selectedRoleType.value['id'] ?? '',
      "country": selectedCountry.value['id'] ?? '',
      "state": selectedState.value['id'] ?? '',
      "salary": selectedSalary.value['id'] ?? '',
      "document[0]":documentFile??'',
      "vacancy": int.tryParse(noOfVaccencyController.text) ?? "",
      "job_mode": selectedWorkMode.value['id'] ?? '',
      "urgent": isUrgentJob.value ?? false,
      "designation": selectedDesignationt.value["id"] ?? "",
      "department": selectedDepartment.value["id"] ?? "",
      "city": selectedCity.value["id"] ?? "",
      "industry": appIndustryControllers.text ?? "",
      "skill": selectedSkillsData.map((e) => e['id']).where((id) => id != null).toList()
    };




    SaveUserProfileModel addEmployment = await ApiProvider.baseWithToken().addJob(data);
    if(addEmployment.status==true){
      if (progressDialog.isShowing()) {
        Get.back();
      }
      if(screenNameData==companyJobsScreen){
        Navigator.pop(context);
        Get.offNamed(AppRoutes.bottomNavBar,arguments: {bottomNavCurrentIndexData:"1"});
      }

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

bool isInvalidSelection(Map<String, String> selected, String defaultText) {
  final name = selected["name"];
  return name == null || name.isEmpty || name == defaultText;
}


///State list Api
void getStateListApiCall({required String countryName}) async{
  try {
    progressDialog.show();
    StateListModel stateListModel = await ApiProvider.base().stateList(countryName: countryName);
    if(stateListModel.status==true){
      stateListData.value.data?.clear();
      stateListData.value=stateListModel;
      if(stateListData.value.data!=null&&stateListData.value.data!.isNotEmpty){
        progressDialog.dismissLoader();
      }
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
///City list api
void getCityListApiCall({required String stateName}) async{
  try {
    progressDialog.show();
    CityListModel cityListModel = await ApiProvider.base().cityList(stateName: stateName);
    if(cityListModel.status==true){
      cityListData.value.data?.clear();
      cityListData.value=cityListModel;
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