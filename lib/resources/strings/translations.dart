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

  Future<void> initLocale() async {
    final box = GetStorage();
    String? locale = box.read(LANGUAGE);
    if (locale == null) {
      Get.updateLocale(const Locale('en'));
      await box.write(LANGUAGE, 'en');
    } else {
      Get.updateLocale(Locale(locale));
    }
  }

  Locale getLocale() {
    final box = GetStorage();
    String? locale = box.read(LANGUAGE);
    return Locale(locale ?? 'en');
  }

  Future<void> updateLocale({required String langCode}) async {
    final box = GetStorage();
    Get.updateLocale(Locale(langCode));
    await box.write(LANGUAGE, langCode);
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
          'are_you_arrived': 'Have you arrived?',
          'are_you_sure_you_want_to_start_tracking':
              'Are you sure you want to start tracking?',
          'is_task_completed': 'Is the task completed?',
          'error_sending_message': 'Error sending message',
          'please_enable_location_all_times':
              'Please enable location all times to continue',
          'please_update_app_to_latest_version':
              'Please update app to latest version',
          'start_task': 'Start Task',
          'change_language': 'Change Language',
          'bg_location_dialog_title': 'Background Location Disclosure',
          'bg_location_dialog_description':
              'Taskou Pro will use the location of the app in background while the user is in tracking mode, even if the app is not in focus',
        },
        'fr': {
          'app_title': 'Taskou Pro',
          'you_are_in_offline_mode': 'Vous êtes hors ligne',
          'error_signing_in': 'Erreur de connexion ',
          'signed_in_successfully': 'Connexion réussie',
          'phone_number': 'Numéro de téléphone',
          'password': 'Mot de passe',
          'forgot_password': 'Mot de passe oublié?',
          'login': 'Se connecter',
          'child_mode': 'Mode enfant',
          'dont_have_an_account': 'Pas de compte?',
          'signup': 'S’inscrire',
          'this_field_is_required': 'Champ requis',
          'invalid_phone_number': 'Numéro invalide',
          'last_name': 'Nom',
          'enter_last_name': 'Entrer le nom',
          'first_name': 'Prénom',
          'enter_first_name': 'Entrer le prénom',
          'enter_password': 'Mot de passe',
          'email': 'E-mail',
          'email_optional': 'E-mail (Opt)',
          'enter_email': 'Entrer e-mail',
          'city': 'Ville',
          'enter_city': 'Entrer votre ville ',
          'province': 'Wilaya',
          'enter_province': 'Wilaya',
          'zip_code': 'code postal',
          'enter_zip_code': 'Code postal',
          'price_per_hour_dollar': 'Tarif par heure',
          'price': 'Prix',
          'by_signing_up_you_agree_to_our':
              'En vous inscrivant vous acceptez nos ',
          'terms_conditions': 'Termes & Conditions',
          'and': 'et',
          'privacy_policy': 'Privacy Policy',
          'register': 'Enregistrer',
          'already_have_an_account': 'vous avez déjà un compte?',
          'signin': 's’identifier',
          'send': 'envoyer',
          'enter_your_mobile_number': 'Entrer votre numéro de téléphone',
          'sign_up_successful': 'inscription réussie',
          'error_signing_up': 'Erreur d’inscription',
          'otp': 'OTP',
          'otp_sent_to': 'OTP envoyé ',
          'verify': 'Vérifier',
          'error_verifying_otp': 'Erreur de vérification OTP',
          'otp_verified_successfully': 'OTP vérifié avec succès',
          'user_not_verified': 'Utilisateur non vérifié',
          'find_serviceman': 'Prestataires',
          'bookings': 'Réservations',
          'profile': 'Profil',
          'home': 'Accueil',
          'support': 'Support',
          'help': 'Centre d’aide',
          'logout': 'Se déconnecter',
          'what_do_you_need': 'De quoi avez-vous besoin?',
          'unknown_error_occurred': 'Une erreur inconnue s’est produite',
          'browse_service': 'Prestataires ',
          'post_work': 'Post Work',
          'light': 'Light',
          'dark': 'Dark',
          'edit': 'Modifier',
          'save': 'Sauvegarder',
          'resend': 'Renvoyer',
          'current': 'En cours',
          'past': 'Terminées',
          'upcoming': 'Futur',
          'available_servicemen': 'Disponible',
          'certified': 'Certifié',
          'jobs': 'Métier',
          'user_auth_failed_login_again':
              'L’identification de l’utilisateur a échoué. Veuillez vous reconnecter',
          'no_data_found': 'Aucune donnée disponible',
          'view_profile': 'Voir le profil',
          'book': 'Réserver',
          'advertising_communaction': 'Publicité & Communication',
          'email_address': 'Adresse e-mail',
          'enter_your_message': 'Entrer votre message',
          'book_serviceman': 'Réserver',
          'am': 'AM',
          'pm': 'PM',
          'jan': 'Jan',
          'feb': 'Fev',
          'mar': 'Mar',
          'apr': 'Avr',
          'may': 'Mai',
          'jun': 'Jui',
          'jul': 'Jul',
          'aug': 'Aoû',
          'sep': 'Sep',
          'oct': 'Oct',
          'nov': 'Nov',
          'dec': 'Dec',
          'description': 'Description',
          'task_accepted': 'Demande acceptée',
          'handyman_arrived': 'Prestataire arrivé',
          'task_start': 'Service commencé',
          'task_completed': 'Service terminé',
          'past_task': 'Terminées',
          'current_task': 'En cours',
          'upcoming_task': 'Futur',
          'review': 'Avis',
          'success': 'Succés',
          'please_assign_ratings': 'Atribuer une note',
          'please_enter_your_message': 'Entrer votre message',
          'ok': 'Ok',
          'enter_address': 'Adresse',
          'search': 'Recherche',
          'share_code': 'Partager le code',
          'delete': 'Supprimer',
          'tracking': 'Tracking',
          'add': 'Ajouter',
          'child_name': 'Nom de l’enfant',
          'enter_child_name': 'Nom de l’anfant',
          'relation': 'Relation',
          'enter_relation': 'Relation',
          'child': 'Enfant',
          'employee': 'Employé',
          'cancel': 'Annuler',
          'error_logging_out':
              'Une erreur s’est produite lors de la déconnexion',
          'submit': 'Envoyer',
          'enter_code_here': 'Entrer votre code ici',
          'tracking_question':
              'Partager votre position et votre Vitesse avec vos parents?',
          'yes': 'Oui',
          'no': 'Non',
          'off': 'Off',
          'stop': 'Stop',
          'not_found': 'Incorrect',
          'location_background_notification_message':
              'Taskou exécute votre géolocalisation en arrière-plan',
          'last_updated': 'Dernière mis à jour:',
          'when_you_need_serviceman': 'Quand avez-vous besoin du prestataire?',
          'now': 'Maintenant ',
          'later': 'Plus tard',
          'error_while_getting_location':
              'Erreur lors de l’obtention de l’emplacement',
          'book_handyman_alert_message': 'Reserver?',
          'enter_time': 'Entrer l’heure',
          'let_us_know_what_you_think': 'De quoi avez-vous besoin!',
          'settings': 'Paramètres',
          'change_password': 'Changer le mot de passe',
          'faq': 'QFP',
          'old_password': 'Ancien mot de passe',
          'enter_old_password': 'Entrer l’ancien mot de passe',
          'new_password': 'Nouveau mot de passe',
          'enter_new_password': 'Entrer le nouveau mot de passe',
          'confirm_password': 'Confirmer le mot de passe',
          're_enter_password': 'Ressaisir le mot de passe',
          'new_and_confirm_passwords_not_matched':
              'Les mots de passe ne correspond pas',
          'password_must_be_6_characters':
              'Le mot de passe doit comporter 6 caractères',
          'rate': 'Avis',
          'on_duty': 'Disponible',
          'new_request': 'Demandes',
          'running': 'En cours ',
          'accept': 'Accepter',
          'reject': 'Rejeter',
          'schedule_for': 'Programmer pour',
          'accepted': 'Demande acceptée',
          'arrived': 'Prestataire arrivé',
          'work_started': 'Service commencé',
          'completed': 'Service terminé',
          'profession': 'Métier',
          'work_photos': 'Photos',
          'documents': 'Documents',
          'price_per_hour': 'Tarif par heure',
          'subscription': 'Abonnement',
          'my_review': 'Mes avis',
          'about': 'À propos',
          'logout_message': 'Déconnecter?',
          'enter_the_description': 'Entrer la description',
          'complete_your_profile': 'Compléter votre Profil',
          'you_are_few_steps_away_complete_profile':
              'Vous êtes a quelques secondes de compléter votre profil ',
          'upload_your_work_photos': 'Télécharger vos  Photos',
          'upload_your_documents': 'Télécharger vos documents',
          'submit_for_approval': 'Soumettre',
          'choose_a_source': 'Choisir la source',
          'camera': 'Camera',
          'gallery': 'Galerie',
          'add_profession': 'Ajouter un métier',
          'empty_professions_message': 'Pas de métier. Veuillez ajouter',
          'choose_main_category': 'Choisisser la catégorie',
          'profession_added_successfully': 'Métier ajouté avec succès',
          'profession_already_exists': 'Métier existe déjà',
          'do_you_want_to_delete_profession': 'Supprimer ce métier?',
          'error_getting_image': 'Erreur image',
          'photos_': 'Photos*',
          'video_optional': 'Video (Optionnel)',
          'error_getting_video': 'Erreur video',
          'do_you_want_to_delete_video': 'Supprimer cette video?',
          'video_deleted_successfully': 'Video supprimée avec succés',
          'unable_to_delete_video': 'Impossible de supprimer la video',
          'do_you_want_to_delete_photo': 'Supprimer la photo?',
          'photo_deleted_successfully': 'Photo supprimé avec succés',
          'unable_to_delete_photo': 'Impossible de supprimer la photo',
          'loading': 'Téléchargement',
          'identity_proof_': 'Preuve d’identité*',
          'certificate_if_any': 'Diplôme (opt)',
          'front': 'Recto',
          'back': 'Verso',
          'add_documents': 'Ajouter documents',
          'update_your_price': 'Mettre à jour votre tarif',
          'rate_per_hour': 'Tarif par heure',
          'update': 'Mise à jour',
          'please_enter_rate_per_hour': 'Tarif par heure',
          'invalid_email_address': 'Adresse e-mail invalide',
          'current_pack': 'Pack actuel',
          'all_packs': 'Tous les packs',
          'dzd': 'DZD',
          'free_for_now': 'Gratuit pour le moment',
          'monthly': 'Mensuel',
          'six_months': '6 Mois',
          'yearly': 'Annuel',
          'card': 'Carte',
          'cash': 'Espèces',
          'start_tracking': 'Lancer le tracking',
          'direction': 'Direction',
          'profession_exception_message': 'Erreur de téléchargement du métier',
          'work_photos_exception_message':
              'Erreur de téléchargement des photos',
          'documents_exception_message':
              'Erreur de téléchargement des documents',
          'submit_for_approval_success_message':
              'Demande envoyée pour approbation',
          'complete_task': 'Terminer le service',
          'are_you_arrived': 'Arrivé?',
          'are_you_sure_you_want_to_start_tracking': 'Commencer le service?',
          'is_task_completed': 'Service terminé?',
          'error_sending_message': 'Erreur d’envoi de message',
          'please_enable_location_all_times':
              'Veuillez activer la localization à tout le temps pour continuer',
          'please_update_app_to_latest_version': 'Mettre à jour l’application',
          'start_task': 'Commencer le service',
          'change_language': 'Changer de langue',
          'bg_location_dialog_title':
              'Divulgation de l\'emplacement en arrière-plan',
          'bg_location_dialog_description':
              'Taskou Pro utilisera l\'emplacement de l\'application en arrière-plan pendant que l\'utilisateur est en mode suivi, même si l\'application n\'est pas au point',
        }
      };
}
