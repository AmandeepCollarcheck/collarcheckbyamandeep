import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../models/filter_data_list_model.dart';
import '../utills/app_strings.dart';
import '../utills/font_styles.dart';

commonFilterWidgetForSelectCompany(context,{
  required RxInt  selectedTabIndex,
  required String filterTypeLabel,
  required List filterTypeLabelList,
  required TextEditingController controller,
  required FilterData? searchItemData,
  required RxList<bool> isCheckedCheckboxValue,
  required Function(int, bool, String) onVoidCallBack,
}) {
  return Container(
    height: MediaQuery.of(context).size.height*0.4,
    margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
    padding: EdgeInsets.only(left: 15,right: 15,top: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: appWhiteColor,
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(filterTypeLabel, style: AppTextStyles.font16W600.copyWith(color: appBlackColor)),
          SizedBox(height: 10),
          commonTextField(controller: controller, hintText: appSearch),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Obx(()=>_searchOptionList(context,
              selectedTabIndex:selectedTabIndex.value,
              searchItemData: searchItemData,
              isCheckedCheckboxValue: isCheckedCheckboxValue,
              onVoidCallBack: onVoidCallBack, filterTypeLabelList:filterTypeLabelList?? [],
            )),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}

_searchOptionList(context,{
  required int selectedTabIndex,
  required FilterData? searchItemData,
  required RxList<bool> isCheckedCheckboxValue,  // ✅ Expect a reactive list
  required Function(int, bool,String) onVoidCallBack,
  required List filterTypeLabelList,
}) {
  List<DepartmentListElement>? filteredData;
  List<CompanyList>? companyListFilteredData;
  List<CountryList>? countryListFilteredData;


  if(selectedTabIndex==0&&filterTypeLabelList[selectedTabIndex]==appSelectCompany){
    companyListFilteredData=searchItemData?.companyList;
  }else if(selectedTabIndex==9&&filterTypeLabelList[selectedTabIndex]==appSelectCountry){
    countryListFilteredData=searchItemData?.countryList;
  }else if(selectedTabIndex==1&&filterTypeLabelList[selectedTabIndex]==appSelectIndustry){
    filteredData=searchItemData?.industryList;
  }else if(selectedTabIndex==2&&filterTypeLabelList[selectedTabIndex]==appSelectDepartment){
    filteredData=searchItemData?.departmentList;
  }else if(selectedTabIndex==3&&filterTypeLabelList[selectedTabIndex]==appSelectSalary){
    filteredData=searchItemData?.salaryList;
  }else if(selectedTabIndex==4&&filterTypeLabelList[selectedTabIndex]==appSelectRole){
    filteredData=searchItemData?.roleTypeList;
  }else if(selectedTabIndex==5&&filterTypeLabelList[selectedTabIndex]==appSelectExperience){
    filteredData=searchItemData?.jobExperienceList;
  }else if(selectedTabIndex==6&&filterTypeLabelList[selectedTabIndex]==appSelectSkill){
    filteredData=searchItemData?.skillList;
  }else if(selectedTabIndex==7&&filterTypeLabelList[selectedTabIndex]==appSelectMode){
    filteredData=searchItemData?.jobModeList;
  }else if(selectedTabIndex==8&&filterTypeLabelList[selectedTabIndex]==appSelectDesignation){
    filteredData=searchItemData?.designationList;
  }



  int companyFilteredListData = companyListFilteredData?.length ?? 0;
  int countryFilteredListData = countryListFilteredData?.length ?? 0;
  int filteredListData = filteredData?.length ?? 0;
  print("nsdjsdjskkjdfsjkjkdfsdfshdfshdkskkjfsdfjsjf");
  print(selectedTabIndex);
  print(companyFilteredListData);
  print(countryFilteredListData);
  print(filteredListData);



  return Wrap(
    runSpacing: 10,
    children:  List.generate(companyFilteredListData!=0?companyFilteredListData:countryFilteredListData!=0?countryFilteredListData:filteredListData!=0?filteredListData:0, (index) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: SizedBox(
              height: 12,
              width: 12,
              child: Checkbox(
                activeColor: appPrimaryColor,
                checkColor: appWhiteColor,
                side: BorderSide(color: appGreyBlackColor, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // Set border radius to 4
                ),
                value: isCheckedCheckboxValue[index],
                onChanged: (value) {
                  isCheckedCheckboxValue[index] = value ?? false; //
                  if(companyFilteredListData!=0){
                    onVoidCallBack(index, isCheckedCheckboxValue[index], companyListFilteredData![index].id.toString());
                  }else if(countryFilteredListData!=0){
                    onVoidCallBack(index, isCheckedCheckboxValue[index], countryListFilteredData![index].id.toString());
                  }else if(filteredListData!=0){
                    onVoidCallBack(index, isCheckedCheckboxValue[index], filteredData![index].id.toString());
                  }else{
                    onVoidCallBack(index, isCheckedCheckboxValue[index],"");
                  }

                },
              ),
            ),
          ),
          SizedBox(width: 15,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(
              companyFilteredListData!=0?companyListFilteredData![index].name.toString():countryFilteredListData!=0?countryListFilteredData![index].name.toString():filteredListData!=0?filteredData![index].name.toString():"",
              style: AppTextStyles.font14W500.copyWith(color: appBlackColor),
            ),
          ),
        ],
      );
    }),
  );
}
