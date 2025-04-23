import 'package:collarchek/utills/common_widget/progress.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetChecker{
  onInit(){
    final listener = InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          showToast("Internet Connected");
        // The internet is now connected
          break;
        case InternetStatus.disconnected:
          showToast("Internet Disconnected");
          break;
      }
    });
  }
}