import 'package:flutter/cupertino.dart';

import '../app_strings.dart';
import '../font_styles.dart';
import '../image_path.dart';

commonScreenHeader({required String headerName}){
  return Column(
    children: <Widget>[
      Image.asset(appLoginLogo),
      Text(headerName,style: AppTextStyles.font20,textAlign: TextAlign.center,),
      SizedBox(height: 20,),
    ],
  );
}