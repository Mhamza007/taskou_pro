import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppTranslations extends Translations {
  // Default locale
  final locale = const Locale('en');

  // fallbackLocale saves the day when the locale gets in trouble
  final fallbackLocale = const Locale('en');

  // Key
  static const String LANGUAGE = 'LANGUAGE';

  Future<void> init() async {
    final box = GetStorage();
    String? locale = box.read(LANGUAGE);
    if (locale == null) {
      Get.updateLocale(const Locale('en'));
      await box.write(LANGUAGE, 'en');
    } else {
      Get.updateLocale(Locale(locale));
    }
  }

  static void updateLocale({required String langCode}) {
    final box = GetStorage();
    Get.updateLocale(Locale(langCode));
    box.write(LANGUAGE, langCode);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'app_title': 'Taskou Pro',
          'you_are_in_offline_mode':
              'You are in offline mode. Please check your connection',
          'error_signing_in': 'There was an error in signing in',
          'signed_in_successfully': 'Signed in successfully',
          'phone_number': 'Phone Number',
          'password': 'Password',
          'forgot_password': 'Forgot Password?',
          'login': 'Login',
          'child_mode': 'Child Mode',
          'dont_have_an_account': 'Don\'t have an account?',
          'signup': 'SignUp',
          'this_field_is_required': 'This field is required',
          'invalid_phone_number': 'Invalid Phone Number',
          'last_name': 'Last Name',
          'enter_last_name': 'Enter Last Name',
          'first_name': 'First Name',
          'enter_first_name': 'Enter First Name',
          'enter_password': 'Enter Password',
          'email': 'Email',
          'email_optional': 'Email (Optional)',
          'enter_email': 'Enter Email',
          'city': 'City',
          'enter_city': 'Enter City',
          'province': 'Province',
          'enter_province': 'Enter Province',
          'zip_code': 'Zip Code',
          'enter_zip_code': 'Enter Zip Code',
          'price_per_hour_dollar': 'Price Per Hour (\$)',
          'price': 'Price',
          'by_signing_up_you_agree_to_our': 'By Signing up you agree to our',
          'terms_conditions': 'Terms & Conditions',
          'and': 'and',
          'privacy_policy': 'Privacy Policy',
          'register': 'Register',
          'already_have_an_account': 'Already have an account?',
          'signin': 'SignIn',
          'send': 'Send',
          'enter_your_mobile_number': 'Enter your Mobile Number',
          'sign_up_successful': 'Sign Up Successful',
          'error_signing_up': 'Error Signing Up',
          'otp': 'OTP',
          'otp_sent_to': 'OTP sent to',
          'verify': 'Verify',
          'error_verifying_otp': 'Error verifying OTP',
          'otp_verified_successfully': 'OTP Verified Successfully',
          'user_not_verified': 'User Not Verified',
          'find_serviceman': 'Find Serviceman',
          'bookings': 'Bookings',
          'profile': 'Profile',
          'home': 'Home',
          'support': 'Support',
          'help': 'Help',
          'logout': 'Logout',
          'what_do_you_need': 'What do you need?',
          'unknown_error_occurred': 'Unknown error occurred',
          'browse_service': 'Browse Service',
          'post_work': 'Post Work',
          'light': 'Light',
          'dark': 'Dark',
          'edit': 'Edit',
          'save': 'Save',
          'resend': 'Resend',
          'current': 'Current',
          'past': 'Past',
          'upcoming': 'Upcoming',
          'available_servicemen': 'Available Servicemen',
          'certified': 'Certified',
          'jobs': 'Jobs',
          'user_auth_failed_login_again':
              'User Authentication Failed. Please login again',
          'no_data_found': 'No data found',
          'view_profile': 'View Profile',
          'book': 'Book',
          'advertising_communaction': 'Advertising & Communaction',
          'email_address': 'Email Address',
          'enter_your_message': 'Enter Your Message',
          'book_serviceman': 'Book Serviceman',
          'am': 'AM',
          'pm': 'PM',
          'jan': 'Jan',
          'feb': 'Feb',
          'mar': 'Mar',
          'apr': 'Apr',
          'may': 'May',
          'jun': 'Jun',
          'jul': 'Jul',
          'aug': 'Aug',
          'sep': 'Sep',
          'oct': 'Oct',
          'nov': 'Nov',
          'dec': 'Dec',
          'description': 'Description',
          'task_accepted': 'Task Accepted',
          'handyman_arrived': 'Handyman Arrived',
          'task_start': 'Task Start',
          'task_completed': 'Task Completed',
          'past_task': 'Past Task',
          'current_task': 'Current Task',
          'upcoming_task': 'Upcoming Task',
          'review': 'Review',
          'success': 'Success',
          'please_assign_ratings': 'Please assign ratings',
          'please_enter_your_message': 'Please enter your message',
          'ok': 'Ok',
          'enter_address': 'Enter Address',
          'search': 'Search',
          'share_code': 'Share Code',
          'delete': 'Delete',
          'tracking': 'Tracking',
          'add': 'Add',
          'child_name': 'Child Name',
          'enter_child_name': 'Enter Child Name',
          'relation': 'Relation',
          'enter_relation': 'Enter Relation',
          'child': 'Child',
          'employee': 'Employee',
          'cancel': 'Cancel',
          'error_logging_out': 'An error occurred while logging out',
          'submit': 'Submit',
          'enter_code_here': 'Enter your code here',
          'tracking_question':
              'Do you want to track your Location and speed with your relative?',
          'yes': 'Yes',
          'no': 'No',
          'of': 'of',
          'stop': 'Stop',
          'not_found': 'not found',
          'location_background_notification_message':
              'Taskou is listening location in background',
          'last_updated': 'Last updated:',
          'when_you_need_serviceman': 'When do you need serviceman?',
          'now': 'Now',
          'later': 'Later',
          'error_while_getting_location': 'Error while getting location',
          'book_handyman_alert_message': 'Are you sure to book this handyman?',
          'enter_time': 'Enter time',
          'let_us_know_what_you_think': 'Let us know what you think!',
          'settings': 'Settings',
          'change_password': 'Change Passsword',
          'faq': 'FAQ',
          'old_password': 'Old Password',
          'enter_old_password': 'Enter old password',
          'new_password': 'New Password',
          'enter_new_password': 'Enter new password',
          'confirm_password': 'Confirm Password',
          're_enter_password': 'Re-enter password',
          'new_and_confirm_passwords_not_matched':
              'New Password and confirm Password did not match',
          'password_must_be_6_characters':
              'Password must be at least 6 characters',
          'rate': 'Rate',
          'on_duty': 'On Duty',
          'new_request': 'New Request',
          'running': 'Running',
          'accept': 'Accept',
          'reject': 'Reject',
          'schedule_for': 'Schedule for',
          'accepted': 'Accepted',
          'arrived': 'Arrived',
          'work_started': 'Work Started',
          'completed': 'Completed',
          'profession': 'Profession',
          'work_photos': 'Work Photos',
          'documents': 'Documents',
          'price_per_hour': 'Price per hour',
          'subscription': 'Subscription',
          'my_review': 'My Review',
          'about': 'About',
          'logout_message': 'Do you want to Logout?',
          'enter_the_description': 'Enter the description',
          'complete_your_profile': 'Complete your Profile',
          'you_are_few_steps_away_complete_profile':
              'You are few steps away from Complete Profile',
          'upload_your_work_photos': 'Upload your Work Photos',
          'upload_your_documents': 'Upload your Documents',
          'submit_for_approval': 'Submit for Approval',
          'choose_a_source': 'Choose Source',
          'camera': 'Camera',
          'gallery': 'Gallery',
          'add_profession': 'Add Profession',
          'empty_professions_message':
              'There are no professions yet. Please add',
          'choose_main_category': 'Choose Main Category',
          'profession_added_successfully': 'Profession added successfully',
          'profession_already_exists': 'Profession already exists',
          'do_you_want_to_delete_profession':
              'Do you want to delete this profession?',
          'error_getting_image': 'Error getting image',
          'photos_': 'Photos*',
          'video_optional': 'Video (Optional)',
          'error_getting_video': 'Error getting video',
          'do_you_want_to_delete_video': 'Do you want to delete the video?',
          'video_deleted_successfully': 'Video deleted successfully',
          'unable_to_delete_video': 'Unable to delete video',
          'do_you_want_to_delete_photo': 'Do you want to delete the photo?',
          'photo_deleted_successfully': 'Photo deleted successfully',
          'unable_to_delete_photo': 'Unable to delete photo',
          'loading': 'Loading',
          'identity_proof_': 'Identity Proof*',
          'certificate_if_any': 'Certificate (if any)',
          'front': 'Front',
          'back': 'Back',
          'add_documents': 'Add Documents',
          'update_your_price': 'Update your price',
          'rate_per_hour': 'Rate per Hour',
          'update': 'Update',
          'please_enter_rate_per_hour':
              'Please enter your Rate per Hour amount',
          'invalid_email_address': 'Invalid Email Address',
          'current_pack': 'Current Pack',
          'all_packs': 'All Packs',
          'dzd': 'DZD',
          'free_for_now': 'Free for now',
          'monthly': 'Monthly',
          'six_months': '6 Months',
          'yearly': 'Yearly',
          'card': 'Card',
          'cash': 'Cash',
          'start_tracking': 'Start Tracking',
          'direction': 'Direction',
          'profession_exception_message':
              'Error occurred while uploading profession',
          'work_photos_exception_message':
              'Error occurred while uploading Work Photos',
          'documents_exception_message':
              'Error occurred while uploading Documents',
          'submit_for_approval_success_message':
              'Request Submitted for approval to admin',
          'complete_task': 'Complete Task',
          'are_you_arrived': 'Are you arrived?',
          'are_you_sure_you_want_to_start_tracking':
              'Are you sure you want to start tracking?',
          'is_task_completed': 'Is the task completed?',
          'error_sending_message': 'Error sending message',
          'please_enable_location_all_times':
              'Please enable location all times to continue',
          'please_update_app_to_latest_version':
              'Please update app to latest version',
          'start_task': 'Start Task',
        },
      };
}
