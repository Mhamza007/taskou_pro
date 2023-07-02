import 'package:dio/dio.dart';

import '../../../sdk.dart';
import '../../../../app/app.dart';

class UserApi {
  UserApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(),
    );
  }

  DioBase? dioBase;

  Future<LoginResponse?> loginUser({
    required Map<String, dynamic> userData,
  }) async {
    try {
      var formData = FormData.fromMap(userData);

      var response = await dioBase?.post(
        'handyman_login',
        data: formData,
      );
      if (response != null) {
        return LoginResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SignupResponse?> signUpUser({
    required Map<String, dynamic> userData,
  }) async {
    try {
      var formData = FormData.fromMap(userData);
      var response = await dioBase?.post(
        'handyman_signup',
        data: formData,
      );
      if (response != null) {
        return SignupResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse?> verifyOtp({
    required Map<String, dynamic> userData,
  }) async {
    try {
      var response = await dioBase?.post(
        'verify_mobile',
        data: userData,
      );
      if (response != null) {
        return LoginResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ChangePasswordResponse> changePassword({
    required String userToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'change_password',
        data: data,
      );
      if (response != null) {
        return ChangePasswordResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileUpdateResponse> updateProfile({
    required String userToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'user_update',
        data: data,
      );
      if (response != null) {
        return ProfileUpdateResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetHandymanProfessionsResponse?> getUserProfessions({
    required String userToken,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var response = await dioBase?.post(
        'getHandyprofession',
      );

      if (response != null) {
        return GetHandymanProfessionsResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> setUserProfession({
    required String userToken,
    required Map<String, dynamic> profession,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var formData = FormData.fromMap(profession);
      var response = await dioBase?.post(
        'setProfession',
        data: formData,
      );

      if (response != null) {
        return StatusMessageResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> deleteUserProfession({
    required String userToken,
    required String professionId,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var response = await dioBase?.post(
        'deleteProfession',
        data: FormData.fromMap(
          {
            'id': professionId,
          },
        ),
      );

      if (response != null) {
        return StatusMessageResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetWorkPhotosResponse?> getWorkPhotos({
    required String userToken,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var response = await dioBase?.post(
        'getWork',
      );

      if (response != null) {
        return GetWorkPhotosResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> uploadWorkPhoto({
    required String userToken,
    required String filePath,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var formData = FormData.fromMap({
        'image': MultipartFile.fromFileSync(filePath),
      });
      var response = await dioBase?.post(
        'addWork',
        data: formData,
      );

      if (response != null) {
        return StatusMessageResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> deleteWorkPhoto({
    required String userToken,
    required String workId,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var formData = FormData.fromMap({
        'id': workId,
      });
      var response = await dioBase?.post(
        'deleteWork',
        data: formData,
      );

      if (response != null) {
        return StatusMessageResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetDocumentsResponse?> getDocuments({
    required String userToken,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var response = await dioBase?.post(
        'getDocuments',
      );

      if (response != null) {
        return GetDocumentsResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> uploadDocument({
    required String userToken,
    required String key,
    required String filePath,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var formData = FormData.fromMap({
        key: MultipartFile.fromFileSync(filePath),
      });
      var response = await dioBase?.post(
        'addDocuments',
        data: formData,
      );

      if (response != null) {
        return StatusMessageResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> submitforApproval({
    required String userToken,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var response = await dioBase?.post(
        'submitforApproval',
      );

      if (response != null) {
        return StatusMessageResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdatePricePerHourResponse?> updateRatePerHour({
    required String userToken,
    required String userId,
    required String price,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var response = await dioBase?.post(
        'handyman_update',
        data: FormData.fromMap(
          {
            'user_id': userId,
            'price': price,
          },
        ),
      );

      if (response != null) {
        return UpdatePricePerHourResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordResponse?> forgotPassword({
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dioBase?.post(
        'forget_pass',
        data: data,
      );

      if (response != null) {
        return ForgotPasswordResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifyForgotPasswordOTPResponse?> verifyForgotPasswordOTPResponse({
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dioBase?.post(
        'verify_forget_pass_otp',
        data: data,
      );

      if (response != null) {
        return VerifyForgotPasswordOTPResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> updatePassword({
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dioBase?.post(
        'update_password',
        data: data,
      );

      if (response != null) {
        return StatusMessageResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
