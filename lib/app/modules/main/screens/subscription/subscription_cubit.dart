import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../resources/resources.dart';
import '../../../../app.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit(
    this.context,
  ) : super(const SubscriptionState());

  final BuildContext context;

  void back() => Navigator.pop(context);

  void itemCallback() {
    DialogUtil.showDialogWithYesNoButton(
      context,
      message: 'Select one',
      noBtnText: Res.string.cash,
      yesBtnText: Res.string.card,
      noBtnCallback: () {
        // Cash Callback
      },
      yesBtnCallback: () {
        // Card Callback
      },
    );
  }
}
