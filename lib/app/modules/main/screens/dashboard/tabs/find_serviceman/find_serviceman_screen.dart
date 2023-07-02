import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../app.dart';

class FindServicemanScreen extends StatelessWidget {
  const FindServicemanScreen({
    super.key,
    required this.cubit,
    required this.state,
    this.onDuty = false,
    this.onDutyCallback,
    this.themeMode,
  });

  final FindServicemanCubit cubit;
  final FindServicemanState state;
  final bool onDuty;
  final Function(bool)? onDutyCallback;
  final ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: state.initialCameraPosition,
          onMapCreated: cubit.onMapCreated,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        ),
        Container(
          decoration: BoxDecoration(
            color: Res.colors.materialColor.withOpacity(0.8),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  Res.string.onDuty,
                  style: TextStyle(
                    color: Res.colors.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),
              CupertinoSwitch(
                value: onDuty,
                onChanged: onDutyCallback,
                thumbColor: onDuty
                    ? Res.colors.materialColor
                    : Res.colors.chestnutRedColor,
                trackColor: themeMode == ThemeMode.dark
                    ? Res.colors.backgroundColorDark
                    : Res.colors.backgroundColorLight,
                activeColor: themeMode == ThemeMode.dark
                    ? Res.colors.backgroundColorDark
                    : Res.colors.backgroundColorLight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
