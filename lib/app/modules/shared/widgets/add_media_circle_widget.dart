import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class AddMediaCircleWidget extends StatelessWidget {
  const AddMediaCircleWidget({
    super.key,
    this.radius,
    this.backgroundImage,
    this.child,
  });

  final double? radius;
  final ImageProvider<Object>? backgroundImage;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Res.colors.ghostGreyColor,
            spreadRadius: 5,
          )
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: darkMode
            ? Res.colors.backgroundColorDark
            : Res.colors.backgroundColorLight,
        backgroundImage: backgroundImage,
        child: child,
      ),
    );
  }
}
