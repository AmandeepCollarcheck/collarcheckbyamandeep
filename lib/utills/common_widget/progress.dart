import 'dart:io';

import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_route.dart';
import 'package:collarchek/utills/common_widget/common_button.dart';
import 'package:collarchek/utills/common_widget/common_text_field.dart';
import 'package:collarchek/utills/image_path.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

import '../../models/employment_list_model.dart';
import '../app_key_constent.dart';
import '../app_strings.dart';
import '../font_styles.dart';
import 'common_appbar.dart';
import 'common_methods.dart';



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
    return ""; // Handle null or empty case
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


String getInitialsWithSpace({required String? input}) {
  if (input == null || input.trim().isEmpty) {
    return "";
  }

  List<String> words = input.trim().split(RegExp(r'\s+'));

  if (words.length == 1) {
    return words[0][0].toUpperCase(); // Return single initial if only one word
  }

  return '${words[0][0]} ${words[1][0]}'.toUpperCase();
}


Widget jonInfoCard(
    BuildContext context, {
      required String icon1,
      required String header1,
      required String description1,
      required String icon2,
      required String header2,
      required String description2,
    }) {
  List<Widget> infoItems = [];

  Widget buildInfoBlock(String icon, String header, String description) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon.isNotEmpty)
            icon.contains(".svg")
                ? SvgPicture.asset(icon, height: 16, width: 16)
                : Image.asset(icon, height: 16, width: 16),
          if (icon.isNotEmpty) SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: AppTextStyles.font14.copyWith(color: appBlackColor),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.font14.copyWith(color: appPrimaryColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Only add non-empty descriptions
  if (description1.trim().isNotEmpty) {
    infoItems.add(buildInfoBlock(icon1, header1, description1));
  }
  if (description2.trim().isNotEmpty) {
    infoItems.add(buildInfoBlock(icon2, header2, description2));
  }

  if (infoItems.isEmpty) {
    return SizedBox.shrink();
  }

  // Show 2 per row
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoItems[0],
          if (infoItems.length > 1) SizedBox(width: 16),
          if (infoItems.length > 1) infoItems[1],
        ],
      ),
    ],
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

      onFilePickedData(file.path.toString());
    } else {
      // User canceled file picker
    }
  }catch (e){
    print("Pdf not picked $e");
  }

}

Future<void> selectDate(
    context,{
      required Function(String) onSelectedDate,
      bool isEndDate=false,
      DateTime? firstDateData
    }) async {
  DateTime? selectedDate;
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: isEndDate?firstDateData!:DateTime(1910),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != selectedDate) {
    final DateFormat dateFormatter = DateFormat('dd-MM-yyyy'); // Change format if needed
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



commonRattingBar(context,{int itemCount=5,required double initialRating,required Function(double) updatedRating,double size=24,double padding=4.0,bool ignoreGesture=false}){
  return RatingBar.builder(
    initialRating: initialRating,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: false,
    itemCount: itemCount,
    ignoreGestures: ignoreGesture,
    unratedColor: appRateUnSelectedColor,
    itemSize: size,
    itemPadding: EdgeInsets.symmetric(horizontal: padding),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rating) {
      updatedRating(rating);
    },
  );
}



Future<void> getPortfolioTypeFromGallery(context,{required Function(String) onFilePickedData,required String portfolioType})async{
  int maxFileSize = 25 * 1024 * 1024;
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: portfolioType=="Upload Image"?FileType.image:portfolioType=="Upload Video"?FileType.video:FileType.custom,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // Check file size limit
      if (file.size > maxFileSize) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File size should be less than 25MB")),
        );
        return;
      }

      onFilePickedData(file.path.toString());
    } else {
      // User canceled file picker
    }
  }catch (e){
    print("Pdf not picked $e");
  }

}


String dateTimeYear({required String? date}) {
  if (date == null || date.isEmpty) {
    print("Invalid date input: $date"); // Debugging statement
    return "N/A"; // Return a default value or handle accordingly
  }

  try {
    DateTime dateTime = DateTime.parse(date);
    return dateTime.year.toString();
  } catch (e) {
    print("Error parsing date: $e");
    return "Invalid Date"; // Return fallback value
  }
}


String convertDateFormat(String inputDate) {
  final inputFormat = DateFormat('dd-MM-yyyy');
  final outputFormat = DateFormat('yyyy-MM-dd');
  final dateTime = inputFormat.parse(inputDate);
  return outputFormat.format(dateTime);
}

void main() {
  String originalDate = "09-04-2025";
  String formattedDate = convertDateFormat(originalDate);
  print(formattedDate); // Output: 2025-04-09
}


String formatDate({required String date}) {
  DateTime dateTime = DateTime.parse(date);
  String day = DateFormat('d').format(dateTime); // Get day without leading zero
  String suffix = getDaySuffix(int.parse(day)); // Get suffix (st, nd, rd, th)
  String formattedDate = "$day$suffix ${DateFormat('MMM yyyy').format(dateTime)}";

  return formattedDate;
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "th"; // Special case for 11th, 12th, 13th
  }
  switch (day % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}


handleIndecaterPercentage({required String devident,required String devider}){

  double verbal = double.tryParse(devident ?? '') ?? 0.0;
  double language = double.tryParse(devider ?? '') ?? 1.0; // Avoid division by zero

   return verbal / language;
}

DateTime convertStringDateTime({required String date}) {
  try {
    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime dateTime = format.parse(date);
    return dateTime;
  } catch (e) {
    throw FormatException("Invalid date format: $date");
  }
}
convertDateTimeString({required String dateTimeString}){
  DateTime dateTime = DateTime.parse(dateTimeString);

  String formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);
  return formattedDate;
}
convertDateInMonthYear({required String date}){
  try {
    DateTime parsedDate = DateTime.parse(date); // Parses YYYY-MM-DD format
    return DateFormat('MMM yyyy').format(parsedDate); // Returns "Mar 2025"
  } catch (e) {
    return "Invalid Date"; // Handle invalid input
  }
}


checkEmploymentIsPresentOfNot({
  required String joiningDate,
  required String tillEmploymentDate,
  required String isStillWorking,
}) {
  try {
    String joiningDateData = formatDate(date: joiningDate);
    if (isStillWorking == "1") {
      return "$joiningDateData $appTo $appPresent";
    } else {
      String endDate = formatDate(date: tillEmploymentDate);
      return "$joiningDateData $appTo $endDate";
    }
  } catch (e) {
    return "Invalid date";
  }
}


String getRatingText(int rating) {
  return rating <= 1 ? appStar : appStars;
}


completeSalaryPackage({required String salaryType,required String salaryAmount,required String salaryMode}){
  return "$salaryType $salaryAmount $salaryMode";
}

openShortItemFilter(context,{required Function(int) onShort}){
  shortedDataFilter(
    context,
    menuItem: [{'id':1,'name':appMostRelevent},{'id':2,'name':appHighestSalary},{'id':3,'name':appLowestSalary},{'id':4,'name':appNewlyPosted}],
    onVoidCallBack: (Map<String, dynamic> value ) {
      onShort(value['id']);
    },
  );
}


String formatTimestampInAmPm({required String timestamp}) {
  DateTime dateTime = DateTime.parse(timestamp);
  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(Duration(days: 1));
  DateTime lastWeek = now.subtract(Duration(days: 7));

  String timeFormat = DateFormat('hh:mm a').format(dateTime); // Format time (e.g., 08:48 AM)
  String fullDateFormat = DateFormat('yyyy-MM-dd hh:mm a').format(dateTime); // Full date

  if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(now)) {
    return timeFormat; // If today, return only time
  } else if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(yesterday)) {
    return 'Yesterday $timeFormat'; // If yesterday, return "Yesterday + time"
  } else if (dateTime.isAfter(lastWeek)) {
    return '${DateFormat('EEEE').format(dateTime)} $timeFormat'; // If within last week, return day name + time
  } else {
    return fullDateFormat; // If older than 7 days, return full date
  }
}


noDataAvailableFoundWidget(context,{required String header,required String details}){
  return Container(
    height: MediaQuery.of(context).size.height*0.1,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.all(10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: appPrimaryColor,width: 1)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(header,style: AppTextStyles.font16W600.copyWith(color: appBlackColor),),
        Text(details,style: AppTextStyles.font12w500.copyWith(color: appPrimaryColor),),

      ],
    ),
  );
}


///Back desabe
DateTime? lastBackPressTime; // Track last back press time
DateTime? lastSwipeTime;
Future<bool> onWillPop() async {
  if (_shouldExitApp()) {
    _exitApp();
  } else {
    _showToast(appPressBackAGainToExit);
  }
  return false; // Prevent default back action
}

// Handle swipe gestures
void onSwipeBack() {
  if (_shouldExitApp()) {
    _exitApp();
  } else {
    _showToast(appSwipeAgainToExit);
  }
}

// Check if app should exit
bool _shouldExitApp() {
  DateTime now = DateTime.now();
  if (lastBackPressTime == null || now.difference(lastBackPressTime!) > Duration(seconds: 2)) {
    lastBackPressTime = now;
    return false;
  }
  return true;
}

// Show toast message
void _showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}

// Exit app
void _exitApp() {
  exit(0); // Force close the app
}

String formatRating(dynamic rating) {
  final double value = double.tryParse(rating.toString()) ?? 0.0;
  return value.toStringAsFixed(1); // Always 1 digit after decimal
}

commonUserNameWidget(context,{required String userName,required bool isProfileVerified,required double width,Color textColor=appBlackColor}){
  return Container(
    width: width,
    //color: appRedColor,
    child: RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: userName,
            style: AppTextStyles.font16W700.copyWith(color: textColor),
          ),
          if (isProfileVerified)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: SvgPicture.asset(
                  appVerifiedIcon,
                  height: 16,
                  width: 16,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}


commonReadMoreWidget(context,{required  String message,required TextStyle textStyle,int trimLine=2}){
  return ReadMoreText(
    message,
    trimMode: TrimMode.Line,
    trimLines: trimLine,
    colorClickableText:appPrimaryColor,
    trimCollapsedText: '$appReadMode',
    style: textStyle,
    trimExpandedText: '...$appReadLess',
    moreStyle: AppTextStyles.font12.copyWith(color: appPrimaryColor),
    lessStyle: AppTextStyles.font12.copyWith(color: appPrimaryColor),
  );
}

String commonEmployementDataPosted({context, required String joiningData, required String employementTillDate, required String stillWorking,}) {
  print("?????????????????????????????");
  print(joiningData);
  print(employementTillDate);
  print(stillWorking);
  String getMonthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String formatDate(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return '';
    final day = date.day;
    final month = getMonthName(date.month); // now safe to call
    final year = date.year;
    return "$day${getDaySuffix(day)}, $month $year";
  }

  final joining = formatDate(joiningData);
  final till = stillWorking == "1" ? appToPresent : formatDate(employementTillDate);

  return "$joining-$till";
}



void openLoginPageWhenTokenUnauthorize() {
  print("Navigating to login page...");
  Future.microtask(() => Get.offAllNamed(AppRoutes.login));
}
