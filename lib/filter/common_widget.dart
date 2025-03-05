import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../utills/app_strings.dart';
import '../utills/font_styles.dart';

commonFilterWidgetForSelectCompany(context,{
  required String filterTypeLabel,
  required TextEditingController controller,
  required List<String> searchItemData,
  required RxList<bool> isCheckedCheckboxValue,
  required Function(int, bool) onVoidCallBack,
}) {
  return Container(
    height: MediaQuery.of(context).size.height*0.3,
    margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
    padding: EdgeInsets.only(left: 15,right: 15,top: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: appWhiteColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(filterTypeLabel, style: AppTextStyles.font16W600.copyWith(color: appBlackColor)),
        SizedBox(height: 10),
        commonTextField(controller: controller, hintText: appSearch),
        SizedBox(height: 10),
        Obx(() => Container(
          margin: EdgeInsets.only(left: 10),
          child: _searchOptionList(
            searchItemData: searchItemData,
            isCheckedCheckboxValue: isCheckedCheckboxValue,
            onVoidCallBack: onVoidCallBack,
          ),
        )),
      ],
    ),
  );
}

_searchOptionList({
  required List<String> searchItemData,
  required RxList<bool> isCheckedCheckboxValue,  // ✅ Expect a reactive list
  required Function(int, bool) onVoidCallBack,
}) {
  return Wrap(
    runSpacing: 10,
    children:  List.generate(searchItemData.length, (index) {
      return Row(
        children: [
          SizedBox(
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
                isCheckedCheckboxValue[index] = value ?? false; // ✅ Update state reactively
                onVoidCallBack(index, isCheckedCheckboxValue[index]); // ✅ Pass index & value
              },
            ),
          ),
          SizedBox(width: 15,),
          Text(
            searchItemData[index],
            style: AppTextStyles.font14W500.copyWith(color: appBlackColor),
          ),
        ],
      );
    }),
  );
}
