import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'my_reviews_state.dart';

class MyReviewsCubit extends Cubit<MyReviewsState> {
  MyReviewsCubit(
    this.context,
  ) : super(const MyReviewsState()) {
    _userStorage = UserStorage();
    _userApi = UserApi();

    getHandymanReviews();
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late UserApi _userApi;

  Future<void> getHandymanReviews() async {
    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var userToken = _userStorage.getUserToken();
        var handymanId = _userStorage.getUserId();

        if (userToken != null) {
          var response = await _userApi.getHandymanReviews(
            userToken: userToken,
            handymanId: handymanId ?? '',
          );

          if (response?.statusCode == 200 && response?.data != null) {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.success,
                message: response?.message ?? Res.string.success,
                handymanReviews: response?.data,
              ),
            );
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: response?.message ?? Res.string.apiErrorMessage,
                handymanReviews: [],
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.userAuthFailedLoginAgain,
              handymanReviews: [],
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.youAreInOfflineMode,
            handymanReviews: [],
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          handymanReviews: [],
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: e.toString(),
          handymanReviews: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiResponseStatus: ApiResponseStatus.failure,
          message: Res.string.apiErrorMessage,
          handymanReviews: [],
        ),
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
          apiResponseStatus: ApiResponseStatus.none,
        ),
      );
    }
  }

  double getRating(String? rating) {
    try {
      return double.parse(rating ?? '0');
    } catch (_) {
      return 0;
    }
  }
}
