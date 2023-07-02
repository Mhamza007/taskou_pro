import 'package:dio/dio.dart';

import '../../../../configs/configs.dart';
import '../../../sdk.dart';
import '../../../../app/app.dart';

class DashboardApi {
  DashboardApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(
        baseUrl: HTTPConfig.handymanbaseURL,
      ),
    );
  }

  DioBase? dioBase;

  Future<StatusMessageResponse?> updateAvailability({
    required String userToken,
    required int availability,
  }) async {
    try {
      dioBase?.options.headers = {
        'user_token': userToken,
      };
      var response = await dioBase?.post(
        'availability_status',
        data: {
          'is_available': availability,
        },
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
