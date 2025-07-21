import 'dart:convert';

import 'package:collarchek/utills/font_styles.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../app_colors.dart';

Widget commonTextField({
  required TextEditingController controller,
  required String hintText,
  bool obscureText = false,
  IconData? icon,
  int maxLine=1,
  String? suffixIcon,
  bool isRealOnly=false,
  VoidCallback? onTap,
  TextInputType keyboardType = TextInputType.text,
  FormFieldValidator<String>? validator,
  List<TextInputFormatter>? inputFormatter,
  TextInputAction textInputAction = TextInputAction.done,
  Function()? onSearchClick,
  Function(String)? onChanged
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText, // Controls if the text is hidden (for password fields)
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    validator: validator,
    readOnly: isRealOnly,
    maxLines: maxLine,
    onTap: onTap,
    onChanged: onChanged,
    style: AppTextStyles.font16.copyWith(color: appBlackColor),
    inputFormatters: inputFormatter ?? [FilteringTextInputFormatter.deny(RegExp(r'^\s+'))],

    textCapitalization: keyboardType==TextInputType.emailAddress?TextCapitalization.none: TextCapitalization.sentences,
    decoration: InputDecoration(
      fillColor: appWhiteColor,
      filled: true,
      suffixIcon: suffixIcon!=null?GestureDetector(
        onTap: (){
          onSearchClick!();
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SvgPicture.asset(suffixIcon,height: 20,width: 20,),
        ),
      ):null,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      hintText: hintText,
      hintStyle: AppTextStyles.font16.copyWith(color: appGreyBlackColor),
      prefixIcon: icon != null ? Icon(icon) : null, // Optional: Add icon if provided
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: appGreyBlackColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: appGreyBlackColor), // Focused border color
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: appGreyBlackColor), // Enabled border color
      ),
      errorStyle:AppTextStyles.font14.copyWith(color: Colors.red,)
    ),
  );
}



Widget commonTextFieldWithCountryCode(context,{
  required String countryFlag,
  required TextEditingController controller,
  required String hintText,
  FormFieldValidator<String>? validator,
  required final Function(Map<String, String>) selectedCountryFlag,
}){
  return Row(
    children: <Widget>[
      GestureDetector(
        onTap: (){
          showCountryPicker(
            context: context,
            countryListTheme: CountryListThemeData(
              flagSize: 25,
              backgroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
              bottomSheetHeight: 500, // Optional. Country list modal height
              //Optional. Sets the border radius for the bottomsheet.
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              //Optional. Styles the search field.
              inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Start typing to search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ),
                ),
              ),
            ),
            onSelect: (Country country) async {
              String data = await rootBundle.loadString('assets/country/country_code.json');
              List<dynamic> countryList = jsonDecode(data);
              var result = countryList.firstWhere(
                      (element) => element["isoCode"] == country.countryCode,
                  orElse: () => null);
              selectedCountryFlag({'countryFlag':result['flag'],'countryCode':country.phoneCode});
            },
          );

        },
        child: Container(
          alignment: Alignment.center,
          height: 45,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: appGreyBlackColor,width: 1.0)
          ),
          child: SvgPicture.network(countryFlag??appGoogleIcon,height: 18,width: 26,),
        ),
      ),
      SizedBox(width: 10,),
      Flexible(
        child: commonMobileNumberTextField(controller: controller, hintText: hintText,validator: validator),
      )
    ],
  );
}

Widget commonMobileNumberTextField({
  required TextEditingController controller,
  required String hintText,
  bool obscureText = false,
  IconData? icon,
  TextInputType keyboardType = TextInputType.text,
  FormFieldValidator<String>? validator,
  TextInputAction textInputAction = TextInputAction.done,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText, // Controls if the text is hidden (for password fields)
    keyboardType: TextInputType.number,
    textInputAction: textInputAction,
    inputFormatters:  [
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*$')),
      FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
    ],
    maxLength: 10,
    validator: validator,
    style: AppTextStyles.font16.copyWith(color: appBlackColor),
    decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        hintText: hintText,
        hintStyle: AppTextStyles.font16.copyWith(color: appGreyBlackColor),
        prefixIcon: icon != null ? Icon(icon) : null, // Optional: Add icon if provided
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: appGreyBlackColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: appGreyBlackColor), // Focused border color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: appGreyBlackColor), // Enabled border color
        ),
        errorStyle:AppTextStyles.font14.copyWith(color: Colors.red,)
    ),
  );
}

customDropDown({
  required String hintText,
  required  List<Map<String, dynamic>> item,
  required Map<String, dynamic>? selectedValue,
  required ValueChanged<Map<String, dynamic>?> onChanged,
  required String? icon,
}){

  return DropdownButtonFormField<Map<String, dynamic>>(
    isExpanded: true,
    style: AppTextStyles.font16.copyWith(color: appBlackColor),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      hintText: hintText,
      hintStyle: AppTextStyles.font16.copyWith(color: appGreyBlackColor),
      suffixIcon: icon != null
          ? Padding(
        padding: EdgeInsets.all(18),
        child: SvgPicture.asset(icon, color: appGreyBlackColor, height: 4, width: 8),
      )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: appGreyBlackColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: appGreyBlackColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: appGreyBlackColor),
      ),
      errorStyle: TextStyle(fontSize: 14, color: Colors.red),
    ),
    value: item.firstWhere((e) => e["id"] == selectedValue?["id"] ),
    items: item.map((itemData) {
      return DropdownMenuItem<Map<String, dynamic>>(
        value: itemData, // Assign the whole map
        child: Text(
          itemData['name'] ?? "Unknown",
          style: AppTextStyles.font14W500.copyWith(color: appBlackColor),
        ),
      );
    }).toList(),
    onChanged: onChanged,
    icon: SizedBox.shrink(),
  );

}



