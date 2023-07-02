// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskou_pro/sdk/sdk.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../app.dart';

part 'update_price_state.dart';

class UpdatePriceCubit extends Cubit<UpdatePriceState> {
  UpdatePriceCubit(
    this.context,
  ) : super(const UpdatePriceState()) {
    rateController = TextEditingController();
    _userApi = UserApi();
    _userStorage = UserStorage();
  }

  final BuildContext context;
  late TextEditingController rateController;
  late UserApi _userApi;
  late UserStorage _userStorage;

  void back() => Navigator.pop(context);

  Future<void> update() async {
    if (rateController.text.isNotEmpty) {
      try {
        emit(
          state.copyWith(
            loading: true,
          ),
        );

        var isConnected = await NetworkService().getConnectivity();
        if (isConnected) {
          var userToken = _userStorage.getUserToken();
          var userId = _userStorage.getUserId();

          if (userToken != null && userId != null) {
            var response = await _userApi.updateRatePerHour(
              userToken: userToken,
              userId: userId,
              price: rateController.text,
            );

            if (response?.statusCode == 200 && response?.data != null) {
              _userStorage.setUserPricePerHour(rateController.text);

              DialogUtil.showDialogWithOKButton(
                context,
                message: response?.message ?? Res.string.success,
              );
            } else {
              emit(
                state.copyWith(
                  apiResponseStatus: ApiResponseStatus.failure,
                  message: response?.message ?? Res.string.apiErrorMessage,
                ),
              );
            }
          } else {
            emit(
              state.copyWith(
                apiResponseStatus: ApiResponseStatus.failure,
                message: Res.string.userAuthFailedLoginAgain,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.failure,
              message: Res.string.youAreInOfflineMode,
            ),
          );
        }
      } on NetworkException catch (e) {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: e.toString(),
          ),
        );
      } on ResponseException catch (e) {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: e.toString(),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            apiResponseStatus: ApiResponseStatus.failure,
            message: Res.string.apiErrorMessage,
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
    } else {
      DialogUtil.showDialogWithOKButton(
        context,
        message: Res.string.pleaseEnterRatePerHour,
        isError: true,
      );
    }
  }
}
