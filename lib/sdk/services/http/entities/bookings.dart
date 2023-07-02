import 'package:dio/dio.dart';

import '../../../../configs/configs.dart';
import '../../../sdk.dart';
import '../../../../app/app.dart';

class BookingsApi {
  BookingsApi({
    this.dioBase,
  }) {
    dioBase ??= DioBase(
      options: BaseOptions(
        baseUrl: HTTPConfig.handymanbaseURL,
      ),
    );
  }

  DioBase? dioBase;

  Future<GetBookingsResponse?> getBookings({
    required String userToken,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.get(
        'get_Bookings',
      );

      if (response != null) {
        return GetBookingsResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AcceptRejectBookingResponse?> acceptBooking({
    required String userToken,
    required String bookingId,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'accept_Request',
        data: {
          'booking_id': bookingId,
        },
      );

      if (response != null) {
        return AcceptRejectBookingResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AcceptRejectBookingResponse?> rejectBooking({
    required String userToken,
    required String bookingId,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'reject_Request',
        data: {
          'booking_id': bookingId,
        },
      );

      if (response != null) {
        return AcceptRejectBookingResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ScheduleBookingsResponse?> getScheduleBookings({
    required String userToken,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.get(
        'getScheduleBook',
      );

      if (response != null) {
        return ScheduleBookingsResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<BookingStatusResponse?> getBookingStatus({
    required String userToken,
    required Map bookingData,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'getbookingStatus',
        data: bookingData,
      );

      if (response != null) {
        return BookingStatusResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusMessageResponse?> postReview({
    required String userToken,
    required Map reviewData,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'add_ratings',
        data: reviewData,
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

  Future<AcceptRejectBookingResponse?> arrived({
    required String userToken,
    required String bookingId,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'arrived',
        data: {
          'booking_id': bookingId,
        },
      );

      if (response != null) {
        return AcceptRejectBookingResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AcceptRejectBookingResponse?> startTask({
    required String userToken,
    required String bookingId,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'startTask',
        data: {
          'booking_id': bookingId,
        },
      );

      if (response != null) {
        return AcceptRejectBookingResponse.fromJson(response);
      } else {
        throw NetworkException(
          'No response data from server',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AcceptRejectBookingResponse?> completeTask({
    required String userToken,
    required String bookingId,
  }) async {
    try {
      dioBase?.options.headers.addAll({
        'user_token': userToken,
      });
      var response = await dioBase?.post(
        'CompleteTask',
        data: {
          'booking_id': bookingId,
        },
      );

      if (response != null) {
        return AcceptRejectBookingResponse.fromJson(response);
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
