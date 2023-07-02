import 'package:reactive_forms/reactive_forms.dart';

class ProfileForms {
  static String lastNameControl = 'last_name';
  static String firstNameControl = 'first_name';
  static String descriptionControl = 'description';
  static String emailControl = 'email';
  static String cityControl = 'city';
  static String provinceControl = 'province';
  static String zipCodeControl = 'zip_code';
  static String deviceTokenControl = 'device_token';

  static FormGroup get profileForm => fb.group(
        {
          lastNameControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          firstNameControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          descriptionControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          emailControl: FormControl<String>(
            validators: [
              Validators.email,
            ],
          ),
          cityControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          provinceControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          zipCodeControl: FormControl<String>(
            validators: [
              Validators.required,
            ],
          ),
          deviceTokenControl: FormControl<String>(),
        },
      );
}
