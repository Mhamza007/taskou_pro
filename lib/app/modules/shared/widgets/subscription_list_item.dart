import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class SubscriptionListItem extends StatelessWidget {
  SubscriptionListItem({
    super.key,
    this.titleWidget,
    this.title,
    this.subTitleWidget,
    this.subtitle,
    this.points,
    this.callback,
  }) {
    assert(titleWidget != null || title != null);
  }

  final Widget? titleWidget;
  final String? title;
  final Widget? subTitleWidget;
  final String? subtitle;
  final String? points;
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return Container(
      decoration: BoxDecoration(
        color: Res.colors.tabIndicatorColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        onTap: callback,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
        title: titleWidget ??
            Text(
              title!,
              style: subtitle == null && subTitleWidget == null
                  ? TextStyle(
                      color: darkMode
                          ? Res.colors.blackColor
                          : Res.colors.whiteColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    )
                  : null,
            ),
        subtitle: subTitleWidget ??
            (subtitle != null
                ? Text(
                    subtitle!,
                    style: TextStyle(
                      color: darkMode
                          ? Res.colors.blackColor
                          : Res.colors.whiteColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null),
        trailing: points != null
            ? CircleAvatar(
                radius: 24.0,
                backgroundColor: Res.colors.coinBorderColor,
                child: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Res.colors.coinColor,
                  child: Text(
                    points!,
                    style: TextStyle(
                      color: Res.colors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
