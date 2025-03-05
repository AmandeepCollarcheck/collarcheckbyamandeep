import 'package:collarchek/Login/login_bindings.dart';
import 'package:collarchek/Login/login_page.dart';
import 'package:collarchek/OtpScreen/otp_binding.dart';
import 'package:collarchek/OtpScreen/otp_page.dart';
import 'package:collarchek/SignUp/signup_bindings.dart';
import 'package:collarchek/SignUp/signup_page.dart';
import 'package:collarchek/StartSignUp/start_signup_bindings.dart';
import 'package:collarchek/StartSignUp/start_signup_page.dart';
import 'package:collarchek/StartUp/startup_bindings.dart';
import 'package:collarchek/StartUp/startup_screen.dart';
import 'package:collarchek/bottom_nav_bar/Bottom_nav_bar_binding.dart';
import 'package:collarchek/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:collarchek/connections/connection_bindings.dart';
import 'package:collarchek/connections/connection_page.dart';
import 'package:collarchek/dashboard/dashboard_bindings.dart';
import 'package:collarchek/dashboard/dashboard_page.dart';
import 'package:collarchek/filter/filter_screen.dart';
import 'package:collarchek/job_details/job_details_bindinds.dart';
import 'package:collarchek/job_details/job_details_page.dart';
import 'package:collarchek/profile_details/profile_details.dart';
import 'package:collarchek/profile_details/profile_details_bindings.dart';
import 'package:collarchek/profiles/profile_bindings.dart';
import 'package:collarchek/profiles/profile_dart.dart';
import 'package:collarchek/recommendJobs/recommend_job.dart';
import 'package:collarchek/recommendJobs/recommend_job_bindings.dart';
import 'package:collarchek/topCompanies/top_companies_bindings.dart';
import 'package:collarchek/topCompanies/top_companies_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Splash/splash_binding.dart';
import '../Splash/splash_page.dart';
import '../filter/filter_bindings.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String startup = '/startup';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String startUpSignup = '/startUpSignup';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String bottomNavBar = '/bottomNavBar';
  static const String recommendJob = '/recommendJob';
  static const String topCompanies = '/topCompanies';
  static const String allFilter = '/allFilter';
  static const String jobDetails = '/jobDetails';
  static const String profile = '/profile';
  static const String profileDetails = '/profileDetails';
  static const String connection = '/connection';

  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: startup,
      page: () => StartUpScreen(),
      binding: StartUpBindings(),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: otp,
      page: () => OtpPage(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: startUpSignup,
      page: () => StartSignUpPage(),
      binding: StartSignUpBinding(),
    ),
    GetPage(
      name: signup,
      page: () => SignUpPage(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: dashboard,
      page: () => DashboardPage(),
      binding: DashboardBindings(),
    ),
    GetPage(
      name: bottomNavBar,
      page: () => BottomNavBarPage(),
      binding: BottomNavBarBindings(),
    ),
    GetPage(
      name: recommendJob,
      page: () => RecommendJobPage(),
      binding: RecommendJobBinding(),
    ),
    GetPage(
      name: topCompanies,
      page: () => TopCompaniesPage(),
      binding: TopCompaniesBindings(),
    ),
    GetPage(
      name: allFilter,
      page: () => FilterPage(),
      binding: FilterBindings(),
    ),
    GetPage(
      name: jobDetails,
      page: () => JobDetailesPage(),
      binding: JobDetailsBindings(),
    ),
    GetPage(
      name: profile,
      page: () => ProfilePage(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: profileDetails,
      page: () => ProfileDetailsPage(),
      binding: ProfileDetailsBindings(),
    ),
    GetPage(
      name: connection,
      page: () => ConnectionPage(),
      binding: ConnectionBindings(),
    ),
  ];
}