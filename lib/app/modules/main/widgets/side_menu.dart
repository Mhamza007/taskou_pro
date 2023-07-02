import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.userName,
    required this.phoneNumber,
    this.imageUrl,
    this.homeCallback,
    this.settingsCallback,
    this.helpCallback,
    this.subscriptionCallback,
    this.myReviewCallback,
    this.aboutCallback,
    this.logoutCallback,
  });

  final String userName;
  final String phoneNumber;
  final String? imageUrl;
  final Function()? homeCallback;
  final Function()? settingsCallback;
  final Function()? helpCallback;
  final Function()? subscriptionCallback;
  final Function()? myReviewCallback;
  final Function()? aboutCallback;
  final Function()? logoutCallback;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Res.colors.materialColor,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          overscroll: false,
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            physics: const ClampingScrollPhysics(),
            children: [
              CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.white54,
                backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                    ? CachedNetworkImageProvider(
                        imageUrl!,
                      )
                    : null,
              ),
              const SizedBox(height: 16.0),
              Text(
                userName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                phoneNumber,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 16.0),
              _drawerItem(
                title: Res.string.home,
                onTap: homeCallback,
              ),
              _drawerItem(
                title: Res.string.settings,
                onTap: settingsCallback,
              ),
              _drawerItem(
                title: Res.string.help,
                onTap: helpCallback,
              ),
              _drawerItem(
                title: Res.string.subscription,
                onTap: subscriptionCallback,
              ),
              _drawerItem(
                title: Res.string.myReview,
                onTap: myReviewCallback,
              ),
              _drawerItem(
                title: Res.string.about,
                onTap: aboutCallback,
              ),
              _drawerItem(
                title: Res.string.logout,
                onTap: logoutCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem({
    required String title,
    Function()? onTap,
  }) =>
      Container(
        color: Res.colors.materialColor,
        child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: Res.colors.whiteColor,
            ),
          ),
        ),
      );
}
