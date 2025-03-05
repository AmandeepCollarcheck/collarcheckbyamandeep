import 'dart:io';

import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_text_field.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../app_key_constent.dart';
import '../app_strings.dart';
import '../font_styles.dart';



enum ProgressDialogType { Normal, Download }


bool _isShowing = false;
bool _barrierDismissible = true, _showLogs = false;

double _borderRadius = 8.0;
Color _backgroundColor = Colors.transparent;
Curve _insetAnimCurve = Curves.easeInOut;

Widget _progressWidget = Lottie.asset('assets/images/loader.json');


class ProgressDialog {
  late _Body _dialog;
  ProgressDialog(
      {  bool isDismissible = false,  bool showLogs = false}) {
    _barrierDismissible = true;
    _showLogs = showLogs ;
  }

  bool isShowing() {
    return _isShowing;
  }



  Future<bool> dismissLoader() {
    if (_isShowing) {
      try {
        _isShowing = false;
        Get.back();
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      if (_showLogs) debugPrint('ProgressDialog already dismissed');
      return Future.value(false);
    }
  }

  void show() {
    if (!_isShowing) {
      _dialog = new _Body();
      _isShowing = true;
      if (_showLogs) debugPrint('ProgressDialog shown');
      Get.dialog(
        Material(
          type: MaterialType.transparency,
          child: WillPopScope(
            onWillPop: () {
              return Future.value(_barrierDismissible);
            },
            child: Dialog(
                backgroundColor: _backgroundColor,
                insetAnimationCurve: _insetAnimCurve,
                insetAnimationDuration: Duration(milliseconds: 100),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(_borderRadius))),
                child: _dialog),
          ),
        ),
        barrierDismissible: false,
      );
    } else {
      if (_showLogs) debugPrint("ProgressDialog already shown/showing");
    }
  }
}

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  final _BodyState _dialog = _BodyState();

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _BodyState extends State<_Body> {
  @override
  void dispose() {
    _isShowing = false;
    if (_showLogs) debugPrint('ProgressDialog dismissed by back button');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var padding = width/3.2;

    return Container(

      margin: EdgeInsets.all(padding),

      child: _progressWidget,
    );
  }
}


showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: appPrimaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}


keyboardDismiss(context){
  FocusManager.instance.primaryFocus?.unfocus();
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

writeStorageData({required String key,required String value})async{
  await GetStorage().write(key, value);
}
readStorageData({required String key})async{
  return GetStorage().read(key);
}

String calculateTimeDifference({required String createDate}) {
  if (createDate == null || createDate.isEmpty) {
    return noDataAvailable; // Handle null or empty case
  }

  DateTime? createdAt = DateTime.tryParse(createDate); // Convert string to DateTime safely
  if (createdAt == null) {
    return invalidData; // Handle invalid date format
  }

  DateTime now = DateTime.now(); // Get current date and time
  Duration diff = now.difference(createdAt); // Get difference

  if (diff.inSeconds < 60) {
    return "${diff.inSeconds} $appSecAgo${diff.inSeconds > 1 ? 's' : ''} $appAgo";
  } else if (diff.inMinutes < 60) {
    return "${diff.inMinutes} $appMinutsAgo${diff.inMinutes > 1 ? 's' : ''} $appAgo";
  } else if (diff.inHours < 24) {
    return "${diff.inHours} $appHoursAgo${diff.inHours > 1 ? 's' : ''} $appAgo";
  } else if (diff.inDays < 30) {
    return "${diff.inDays} $appDayAgo${diff.inDays > 1 ? 's' : ''} $appAgo";
  } else {
    int years = now.year - createdAt.year;
    int months = now.month - createdAt.month;

    if (months < 0) {
      years--;  // Adjust year if months are negative
      months += 12;
    }

    if (years > 0) {
      return "$years $appYearAgo${years > 1 ? 's' : ''} $appAgo";
    } else {
      return "$months $appMonthAgo${months > 1 ? 's' : ''} $appAgo";
    }
  }
}


String generateLocation({
  required String? cityName,
  required String? stateName,
  required String? countryName,
}) {
  List<String> parts = [];

  if (cityName != null && cityName.isNotEmpty) parts.add(cityName);
  if (stateName != null && stateName.isNotEmpty) parts.add(stateName);
  if (countryName != null && countryName.isNotEmpty) parts.add(countryName);

  return parts.join(', ');
}


String getInitialsWithSpace({required String input}) {
  return input.split(' ').map((word) => word.isNotEmpty ? word[0] : '').join(' ').toUpperCase();
}

jonInfoCard(context,{required String icon1,required String header1,required String description1,required String icon2,required String header2,required String description2}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width*0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              icon1.isEmpty?Container():icon1.contains(".svg")?SvgPicture.asset(icon1,height: 16,width: 16,):Image.asset(icon1,height: 16,width: 16,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(header1,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.35,
                      child: Text(description1,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)),
                ],
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            icon2.isEmpty?Container():icon2.contains(".svg")?SvgPicture.asset(icon2,height: 16,width: 16,):Image.asset(icon2,height: 16,width: 16,),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(header2,style: AppTextStyles.font14.copyWith(color: appBlackColor),),
                SizedBox(
                    width: MediaQuery.of(context).size.width*0.35,
                    child: Text(description2,style: AppTextStyles.font14.copyWith(color: appPrimaryColor),)),
              ],
            )
          ],
        )
      ],
    ),
  );
}

openCameraOrGallery(context,{bool isCameraOptionEnable=false,bool isGalleryOptionEnable=false,required Function(File) onCameraCapturedData,required Function(File) onGalleryCapturedData}){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      alignment: Alignment.center,
      content: SizedBox(
        height: MediaQuery.of(context).size.height*0.1,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Get.back();
                _openCamera(onCameraCapturedData: onCameraCapturedData);
              },
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(appCameraSvgIcon),
                  SizedBox(width: 20,),
                  Text(appCamera,style: AppTextStyles.font16W600.copyWith(color: appPrimaryColor),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Get.back();
                _openGallery(onGalleryCapturedData: onGalleryCapturedData);
              },
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(appCameraSvgIcon),
                  SizedBox(width: 20,),
                  Text(appGallery,style: AppTextStyles.font16W600.copyWith(color: appPrimaryColor),),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  });
}

Future<void> _openGallery({required Function(File) onGalleryCapturedData}) async {
  final ImagePicker picker = ImagePicker();
  try{
    final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      imageQuality: 100, // Maintain high image quality
      requestFullMetadata: false, // Optimize performance
    );
    if (pickedImage != null) {
      onGalleryCapturedData(File(pickedImage.path));
    }
  }catch (e){
    if (kDebugMode) {
      print("Gallery Not captured$e");
    }
  }

}

Future<void> _openCamera({required Function(File) onCameraCapturedData}) async {
  final ImagePicker picker = ImagePicker();
  try{
    final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.camera,
      imageQuality: 100, // Maintain high image quality
      requestFullMetadata: false, // Optimize performance
    );
    if (pickedImage != null) {
      onCameraCapturedData(File(pickedImage.path));
    }
  }catch (e){
    if (kDebugMode) {
      print("Image Not captured$e");
    }
  }

}

Future<void> getFileFromGallery(context,{required Function(String) onFilePickedData})async{
  int maxFileSize = 2 * 1024 * 1024;
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx', 'ppt', 'pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // Check file size limit
      if (file.size > maxFileSize) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File size should be less than 2MB")),
        );
        return;
      }

      onFilePickedData(file.name);
    } else {
      // User canceled file picker
    }
  }catch (e){
    print("Pdf not picked $e");
  }

}

Future<void> selectDate( context,{ required Function(String) onSelectedDate}) async {
  DateTime? selectedDate;
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != selectedDate) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd'); // Change format if needed
    onSelectedDate(dateFormatter.format(picked));
  }
}


showVerifyEmailWidget(context,{required TextEditingController controller,required String hintText,required Function(String) onClickVerified}){
   showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height*0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(appVerifyEmail,style: AppTextStyles.font20W700.copyWith(color: appBlackColor),),
                SizedBox(height: 10,),
                commonTextField(controller: controller, hintText: hintText),
                SizedBox(height: 20,),
                commonButton(context, buttonName: appVerifyEmail, buttonBackgroundColor: appPrimaryColor, textColor: appWhiteColor, buttonBorderColor: appPrimaryColor, onClick: (){
                  Get.back();
                  onClickVerified(controller.text);
                })
              ],
            ),
          ),
        );
      }
  );
}