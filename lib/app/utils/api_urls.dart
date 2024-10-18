import 'package:flutter/foundation.dart';

class ApiUrls {
  static const String PRODUCTION_URL =
      'https://ticketsolutions.kerala.gov.in/public/index.php/api';

  static const String LOCAL_URL =
      // 'http://192.168.4.21/ticket_appadmin/public/index.php/api';
      'http://10.0.2.2/ticketappadmin/public/index.php/api';
  // 'http://103.10.168.31/eticketing/public/index.php/api';
  // static const String PRODUCTION_IMAGE_URL =
  //     'https://ticketsolutions.kerala.gov.in/';

  // static const String LOCAL_IMAGE_URL =
  //     'http://192.168.7.98/e_ticketing/storage/app/public';

  // static const String IMGURL = LOCAL_IMAGE_URL;

  static const String APIURL = LOCAL_URL;

  // static const String APIURL = kDebugMode ? LOCAL_URL : PRODUCTION_URL;

  // User Operations
  static const String LOGIN = '$APIURL/devicelogin';
  static const String USER = '$APIURL/user';
  static const String REFRESH_TOKEN = '$APIURL/refresh_token';
  static const String LOGOUT = '$APIURL/logout';

  static const String FACILITIES = '$APIURL/facilities';

//   // MAster data
//   static const String DISTRICT = '$APIURL/district';
//   static const String ACTIVITY_TYPES = '$APIURL/activity_types';

//   // Intern services
//   static const String INTERN_PROGRESS = '$APIURL/intern_progress';
//   static const String INTERN_RANK = '$APIURL/ranks';
//   static const String MARK_ACTIVITY = '$APIURL/mark_activity';
//   static const String PROFILE_UPDATE = '$APIURL/update_intern_profile';
//   static const String APPLICATION_LISTS = '$APIURL/get_applications';
//   static const String ACTIVITY_LISTS = '$APIURL/get_activity';
//   static const String VISITORSCOUNT_UPDATE = '$APIURL/save_visit_count';
//   static const String VISITORSCOUNT_LISTS = '$APIURL/get_visit_count_data';
//   static const String NEWAPPLICATION = '$APIURL/check_mobile_number_exists';

//   // Other Operations
//   static const String POST_FEEDBACK = '$APIURL/post_feedback';
//   static const String UPDATE_FCM_TOKEN = '$APIURL/update_fcm_token';
//   static const String GET_NOTIFICATIONS = '$APIURL/get_notifications';
//   static const String SEND_TEST_NOTIFICATION = '$APIURL/send_test_notification';
//   static const String GET_USER_NOTIFICATIONS = '$APIURL/get_user_notifications';
//   static const String GET_USERTYPE_NOTIFICATIONS =
//       '$APIURL/get_usertype_notifications';

//   //applicationdetailsservices
//   //basic
//   static const String APPLICATIONBASICDETAILS_UPDATE =
//       '$APIURL/update_basicdata';
//   static const String DISTRICTS = '$APIURL/get_districts';
//   static const String GENDER = '$APIURL/get_genders';
//   static const String SOCIALCATEGORY = '$APIURL/get_categories';
//   static const String QUALIFICATIONS = '$APIURL/get_qualifications';
//   static const String ENTERPRISES = '$APIURL/get_enterprises';
//   static const String SECTORS = '$APIURL/get_sectors';
//   static const String TALUKS = '$APIURL/get_taluks';
//   static const String BLOCKS = '$APIURL/get_blocks';
//   static const String PANCHAYATH = '$APIURL/get_Panchayaths';
//   static const String GETAPPLICATION_BASICDETAILS =
//       '$APIURL/get_applicant_data';
//   static const String SPECIALCATEGORIES = '$APIURL/get_special_cat';

//   //grooming
//   static const String PROGRAMMETYPES = '$APIURL/get_training_type';
//   static const String GETAPPLICATION_GROOMINGDETAILS =
//       '$APIURL/get_grooming_data';
//   static const String AGENCYLIST = '$APIURL/get_agencies';
//   static const String SCHEMES = '$APIURL/get_scheme_type';
//   static const String BANKLIST = '$APIURL/get_banks';
//   static const String BRANCH = '$APIURL/get_branch';
//   static const String LICENSEDETAILS = '$APIURL/get_licences';
//   static const String ASSEMBLY = '$APIURL/get_la_name';
//   static const String UPDATE_GROOMING_STAGE_DETAILS =
//       '$APIURL/update_grooming_data';

//   //establishmentdetails
//   static const String GETAPPLICATION_ESTABLISHMENTDETAILS =
//       '$APIURL/get_establishment_data';
//   static const String APPLICATIONESTABLISHMENTDETAILS_UPDATE =
//       '$APIURL/update_establishment_data';

// //commencement
//   static const String GETAPPLICATION_COMMENCEMEENTDETAILS =
//       '$APIURL/get_commencememnt_data';
//   static const String UNITLIST = '$APIURL/get_units';
//   static const String APPLICATIONCOMMENCEMENT_UPDATE =
//       '$APIURL/update_commencement_data';

// //postproduction
//   static const String GETAPPLICATION_POSTPRODUCTIONDETAILS =
//       '$APIURL/get_postproduction_data';
//   static const String APPLICATIONPOSTPRODUCTIONDETAILS_UPDATE =
//       '$APIURL/update_postproduction_data';

//   //dashboard
//   static const String DASHBOARD_PROGRESS =
//       '$APIURL/get_usertype_wise_dashboard';
}
