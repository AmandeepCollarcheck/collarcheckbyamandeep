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
import 'package:collarchek/about/about_bindings.dart';
import 'package:collarchek/about/about_page.dart';
import 'package:collarchek/account_verification/account_verification.dart';
import 'package:collarchek/account_verification/account_verification_bindings.dart';
import 'package:collarchek/add_gallery/add_gallery_bindings.dart';
import 'package:collarchek/add_gallery/add_gallery_page.dart';
import 'package:collarchek/all_review/all_review_bindings.dart';
import 'package:collarchek/all_review/all_review_page.dart';
import 'package:collarchek/all_review/user_specific_review/user_specific_review_bindings.dart';
import 'package:collarchek/all_review/user_specific_review/user_specific_review_page.dart';
import 'package:collarchek/applicants/applicants_bindings.dart';
import 'package:collarchek/applicants/applicants_page.dart';
import 'package:collarchek/bottom_nav_bar/Bottom_nav_bar_binding.dart';
import 'package:collarchek/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:collarchek/certificates/certificated_bindings.dart';
import 'package:collarchek/certificates/certificated_page.dart';
import 'package:collarchek/company_dashboard/company_dashboard_bindings.dart';
import 'package:collarchek/company_dashboard/company_dashboard_page.dart';
import 'package:collarchek/company_employment_request/company_employment_request_bindings.dart';
import 'package:collarchek/company_employment_request/company_employment_request_page.dart';
import 'package:collarchek/company_job/company_job_bindings.dart';
import 'package:collarchek/company_job/company_job_page.dart';
import 'package:collarchek/company_profile/company_profile_bindings.dart';
import 'package:collarchek/company_profile/company_profile_page.dart';
import 'package:collarchek/company_recently_joined_people/company_recently_joined_people_bindings.dart';
import 'package:collarchek/company_recently_joined_people/company_recently_joined_people_page.dart';
import 'package:collarchek/company_recommended_employee/company_recommended_employee_bindings.dart';
import 'package:collarchek/company_recommended_employee/company_recommended_employee_page.dart';
import 'package:collarchek/company_update_profile/company_update_profile_bindings.dart';
import 'package:collarchek/connections/connection_bindings.dart';
import 'package:collarchek/connections/connection_page.dart';
import 'package:collarchek/dashboard/dashboard_bindings.dart';
import 'package:collarchek/dashboard/dashboard_page.dart';

import 'package:collarchek/edit_benefit/edit_benefir_bindings.dart';
import 'package:collarchek/edit_benefit/edit_benefir_page.dart';
import 'package:collarchek/edit_benefit/edit_benefit_controllers.dart';
import 'package:collarchek/educations/education_bindings.dart';
import 'package:collarchek/educations/education_page.dart';
import 'package:collarchek/employees/employees_bindings.dart';
import 'package:collarchek/employees/employees_page.dart';
import 'package:collarchek/employment_history/employment_history_bindings.dart';
import 'package:collarchek/employment_history/employment_history_page.dart';
import 'package:collarchek/filter/filter_screen.dart';
import 'package:collarchek/job_details/job_details_bindinds.dart';
import 'package:collarchek/job_details/job_details_page.dart';
import 'package:collarchek/jobs/jobs_bindings.dart';
import 'package:collarchek/jobs/jobs_page.dart';
import 'package:collarchek/languages/language_binding.dart';
import 'package:collarchek/languages/language_page.dart';
import 'package:collarchek/messages/chat_screen/chat_bindings.dart';
import 'package:collarchek/messages/chat_screen/chat_page.dart';
import 'package:collarchek/messages/message_bindings.dart';
import 'package:collarchek/messages/message_page.dart';
import 'package:collarchek/notifications/notification_binding.dart';
import 'package:collarchek/notifications/notification_page.dart';
import 'package:collarchek/other_company_profile/other_company_profile_bindings.dart';
import 'package:collarchek/other_company_profile/other_company_profile_page.dart';
import 'package:collarchek/other_individual_profile/other_individual_profile_bindings.dart';
import 'package:collarchek/other_individual_profile/other_individual_profile_page.dart';
import 'package:collarchek/portfolio/portfolio_bindings.dart';
import 'package:collarchek/profile_details/profile_details.dart';
import 'package:collarchek/profile_details/profile_details_bindings.dart';
import 'package:collarchek/profiles/profile_bindings.dart';
import 'package:collarchek/profiles/profile_dart.dart';
import 'package:collarchek/recommendJobs/recommend_job.dart';
import 'package:collarchek/recommendJobs/recommend_job_bindings.dart';
import 'package:collarchek/request/request_bindings.dart';
import 'package:collarchek/request/request_page.dart';
import 'package:collarchek/reviews/review_bindings.dart';
import 'package:collarchek/reviews/review_page.dart';
import 'package:collarchek/search/search_bindings.dart';
import 'package:collarchek/search/search_page.dart';
import 'package:collarchek/skills/skills_bindings.dart';
import 'package:collarchek/skills/skills_page.dart';
import 'package:collarchek/topCompanies/top_companies_bindings.dart';
import 'package:collarchek/topCompanies/top_companies_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Splash/splash_binding.dart';
import '../Splash/splash_page.dart';
import '../company_update_profile/company_update_profile_page.dart';

import '../dumy/dumy_bindings.dart';
import '../dumy/dumy_page.dart';
import '../filter/filter_bindings.dart';
import '../portfolio/portfolio_page.dart';

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
  static const String employmentHistory = '/employmentHistory';
  static const String skills = '/skills';
  static const String language = '/language';
  static const String addPortfolio = '/addPortfolio';
  static const String jobs = '/jobs';
  static const String educations = '/educations';
  static const String addCertificates = '/addCertificates';
  static const String review = '/review';
  static const String about = '/about';
  static const String request = '/request';
  static const String message = '/message';
  static const String chat = '/chat';
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String accountVerification = '/accountVerification';
  static const String companyEmployees = '/companyEmployees';
  static const String companyJobs = '/companyJobs';
  static const String applicants = '/applicants';
  static const String companyProfile = '/companyProfile';
  static const String companyEmploymentRequest = '/companyEmploymentRequest';
  static const String companyDashboard = '/companyDashboard';
  static const String companyBenefit = '/companyBenefit';
  static const String addGallery = '/addGallery';
  static const String companyAllReview = '/companyAllReview';
  static const String userSpecificReview = '/userSpecificReview';
  static const String companyUpdateProfile = '/companyUpdateProfile';
  static const String companyRecommendedEmployee = '/companyRecommendedEmployee';
  static const String recentlyJoinedPeople = '/recentlyJoinedPeople';
  static const String otherCompanyProfilePage = '/otherCompanyProfilePage';
  static const String otherIndividualProfilePage = '/otherIndividualProfilePage';
  static const String dumy = '/dumy';
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
    GetPage(
      name: employmentHistory,
      page: () => EmploymentHistoryPage(),
      binding: EmploymentHistoryBindings(),
    ),
    GetPage(
      name: skills,
      page: () => SkilldPage(),
      binding: SkillBindings(),
    ),
    GetPage(
      name: language,
      page: () => LanguagePage(),
      binding: LanguageBindings(),
    ),
    GetPage(
      name: addPortfolio,
      page: () => PortfolioPage(),
      binding: PortfolioBindings(),
    ),
    GetPage(
      name: jobs,
      page: () => JobsPage(),
      binding: JobsBindings(),
    ),
    GetPage(
      name: educations,
      page: () => EducationPage(),
      binding: EducationBindings(),
    ),
    GetPage(
      name: addCertificates,
      page: () => CertificatesPage(),
      binding: CertificatesBindings(),
    ),
    GetPage(
      name: review,
      page: () => ReviewPage(),
      binding: ReviewBindings(),
    ),
    GetPage(
      name: about,
      page: () => AboutPage(),
      binding: AboutBindings(),
    ),
    GetPage(
      name: accountVerification,
      page: () => AccountVerificationPage(),
      binding: AccountVerificationBindings(),
    ),
    GetPage(
      name: request,
      page: () => RequestPage(),
      binding: RequestBindings(),
    ),
    GetPage(
      name: message,
      page: () => MessagePage(),
      binding: MessageBindings(),
    ),
    GetPage(
      name: chat,
      page: () => ChatPage(),
      binding: ChatBindings(),
    ),
    GetPage(
      name: search,
      page: () => SearchPage(),
      binding: SearchBindings(),
    ),
    GetPage(
      name: notifications,
      page: () => NotificationPage(),
      binding: NotificationBindings(),
    ),
    GetPage(
      name: companyEmployees,
      page: () => EmployeesPage(),
      binding: EmployeesBindings(),
    ),
    GetPage(
      name: companyJobs,
      page: () => CompanyJobPage(),
      binding: CompanyJobBindings(),
    ),
    GetPage(
      name: applicants,
      page: () => ApplicantsPage(),
      binding: ApplicantsBindings(),
    ),
    GetPage(
      name: companyEmploymentRequest,
      page: () => CompanyEmploymentRequestPage(),
      binding: CompanyEmploymentRequestBindings(),
    ),
    GetPage(
      name: companyProfile,
      page: () => CompanyProfilePage(),
      binding: CompanyProfileBindings(),
    ),
    GetPage(
      name: companyDashboard,
      page: () => CompanyDashboardPage(),
      binding: CompanyDashboardBindings(),
    ),
    GetPage(
      name: companyBenefit,
      page: () => EditBenefitPage(),
      binding: EditBenefitBindings(),
    ),
    GetPage(
      name: addGallery,
      page: () => AddGalleryPage(),
      binding: AddGalleryBindings(),
    ),
    GetPage(
      name: companyAllReview,
      page: () => AllReviewPage(),
      binding: AllReviewBindings(),
    ),
    GetPage(
      name: userSpecificReview,
      page: () => UserSpecificReviewPage(),
      binding: UserSpecificReviewBindings(),
    ),
    GetPage(
      name: companyUpdateProfile,
      page: () => CompanyUpdateProfilePage(),
      binding: CompanyUpdateProfileBindings(),
    ),
    GetPage(
      name: companyRecommendedEmployee,
      page: () => CompanyRecommendedEmployeePage(),
      binding: CompanyRecommendedEmployeeBindings(),
    ),
    GetPage(
      name: recentlyJoinedPeople,
      page: () => CompanyRecentlyJoinedPeoplePage(),
      binding: CompanyRecentlyJoinedPeopleBindings(),
    ),
    GetPage(
      name: otherCompanyProfilePage,
      page: () => OtherCompanyProfilePage(),
      binding: OtherCompanyProfileBindings(),
    ),
    GetPage(
      name: otherIndividualProfilePage,
      page: () => OtherIndividualProfilePage(),
      binding: OtherIndividualProfileBindings(),
    ),
    GetPage(
      name: dumy,
      page: () => TabBarPage(),
      binding: DumyBindings(),
    ),

  ];
}