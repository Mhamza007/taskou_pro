import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.cubit,
    required this.state,
    this.themeMode,
  });

  final ProfileCubit cubit;
  final ProfileState state;
  final ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    bool darkMode = themeMode == ThemeMode.dark;
    double profileAvatarRadius = 60.0;

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(
        overscroll: false,
      ),
      child: ListView(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: profileAvatarRadius,
                child: state.profileImage != null &&
                        state.profileImage!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: state.profileImage.toString().isURL
                            ? CachedNetworkImage(
                                imageUrl: state.profileImage!,
                                height: 120,
                                width: 120,
                                errorWidget: (context, url, error) =>
                                    const SizedBox.shrink(),
                              )
                            : Image.file(
                                File(state.profileImage!),
                                height: 120,
                                width: 120,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox.shrink(),
                              ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: SizedBox(
                  height: profileAvatarRadius * 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.userName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state.phoneNumber ?? '',
                      ),
                      const Spacer(),
                      Text(
                        state.address ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingAll(16.0),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Res.string.description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                state.description ?? '',
              ),
            ],
          ).paddingAll(16.0),

          ListTile(
            title: Text(Res.string.profession),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            onTap: cubit.professionCallback,
          ),
          const Divider(height: 0),
          ListTile(
            title: Text(Res.string.workPhotos),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            onTap: cubit.workPhotosCallback,
          ),
          const Divider(height: 0),
          ListTile(
            title: Text(Res.string.documents),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            onTap: cubit.documentsCallback,
          ),
          const Divider(height: 0),
          ListTile(
            title: Text(Res.string.pricePerHour),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            onTap: cubit.pricePerHourCallback,
          ),

          // /// Phone Number field
          // ReactivePhoneNumberField(
          //   countryCodeControlName: ProfileForms.countryCodeControl,
          //   phoneNumberControlName: ProfileForms.mobileNumberControl,
          //   flag: state.flag,
          //   hint: Res.string.phoneNumber,
          //   maxLength: state.maxLength,
          //   title: Res.string.phoneNumber,
          //   readOnly: !editMode,
          //   pickCountry: editMode
          //       ? (p0) {
          //           cubit.selectCountry(context);
          //         }
          //       : null,
          //   showSuffix: false,
          //   darkMode: darkMode,
          // ).paddingOnly(bottom: 16),

          // /// Last Name field
          // ReactiveTextField(
          //   formControlName: ProfileForms.lastNameControl,
          //   hint: Res.string.enterLastName,
          //   keyboardType: TextInputType.name,
          //   inputAction: TextInputAction.next,
          //   readOnly: !editMode,
          //   validationMessages: {
          //     forms.ValidationMessage.required: (_) =>
          //         Res.string.thisFieldIsRequired,
          //   },
          //   inputFormatters: [
          //     FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
          //   ],
          //   widgetAboveField: Text(
          //     Res.string.lastName,
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       color: darkMode
          //           ? Res.colors.textColorDark
          //           : Res.colors.textColor,
          //     ),
          //   ).marginOnly(bottom: 8.0),
          //   suffixWidget: const SizedBox.shrink(),
          //   darkMode: darkMode,
          // ).paddingOnly(bottom: 16),

          // /// First Name field
          // ReactiveTextField(
          //   formControlName: ProfileForms.firstNameControl,
          //   hint: Res.string.enterFirstName,
          //   keyboardType: TextInputType.name,
          //   inputAction: TextInputAction.next,
          //   readOnly: !editMode,
          //   validationMessages: {
          //     forms.ValidationMessage.required: (_) =>
          //         Res.string.thisFieldIsRequired,
          //   },
          //   inputFormatters: [
          //     FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
          //   ],
          //   widgetAboveField: Text(
          //     Res.string.firstName,
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       color: darkMode
          //           ? Res.colors.textColorDark
          //           : Res.colors.textColor,
          //     ),
          //   ).marginOnly(bottom: 8.0),
          //   suffixWidget: const SizedBox.shrink(),
          //   darkMode: darkMode,
          // ).paddingOnly(bottom: 16),

          // /// Email field
          // ReactiveTextField(
          //   formControlName: ProfileForms.emailControl,
          //   hint: Res.string.enterEmail,
          //   keyboardType: TextInputType.emailAddress,
          //   inputAction: TextInputAction.next,
          //   readOnly: !editMode,
          //   validationMessages: {
          //     forms.ValidationMessage.email: (_) => 'Invalid Email Address',
          //   },
          //   widgetAboveField: Text(
          //     Res.string.email,
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       color: darkMode
          //           ? Res.colors.textColorDark
          //           : Res.colors.textColor,
          //     ),
          //   ).marginOnly(bottom: 8.0),
          //   suffixWidget: const SizedBox.shrink(),
          //   darkMode: darkMode,
          // ).paddingOnly(bottom: 16),

          // /// City field
          // ReactiveTextField(
          //   formControlName: ProfileForms.cityControl,
          //   hint: Res.string.enterCity,
          //   keyboardType: TextInputType.text,
          //   inputAction: TextInputAction.next,
          //   readOnly: !editMode,
          //   validationMessages: {
          //     forms.ValidationMessage.required: (_) =>
          //         Res.string.thisFieldIsRequired,
          //   },
          //   widgetAboveField: Text(
          //     Res.string.city,
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       color: darkMode
          //           ? Res.colors.textColorDark
          //           : Res.colors.textColor,
          //     ),
          //   ).marginOnly(bottom: 8.0),
          //   suffixWidget: const SizedBox.shrink(),
          //   darkMode: darkMode,
          // ).paddingOnly(bottom: 16),

          // /// Province field
          // ReactiveTextField(
          //   formControlName: ProfileForms.provinceControl,
          //   hint: Res.string.enterProvince,
          //   keyboardType: TextInputType.text,
          //   inputAction: TextInputAction.next,
          //   readOnly: !editMode,
          //   validationMessages: {
          //     forms.ValidationMessage.required: (_) =>
          //         Res.string.thisFieldIsRequired,
          //   },
          //   widgetAboveField: Text(
          //     Res.string.province,
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       color: darkMode
          //           ? Res.colors.textColorDark
          //           : Res.colors.textColor,
          //     ),
          //   ).marginOnly(bottom: 8.0),
          //   suffixWidget: const SizedBox.shrink(),
          //   darkMode: darkMode,
          // ).paddingOnly(bottom: 16),

          // /// Zip Code field
          // ReactiveTextField(
          //   formControlName: ProfileForms.zipCodeControl,
          //   hint: Res.string.enterZipCode,
          //   keyboardType: TextInputType.text,
          //   inputAction: TextInputAction.next,
          //   readOnly: !editMode,
          //   validationMessages: {
          //     forms.ValidationMessage.required: (_) =>
          //         Res.string.thisFieldIsRequired,
          //   },
          //   widgetAboveField: Text(
          //     Res.string.zipCode,
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       color: darkMode
          //           ? Res.colors.textColorDark
          //           : Res.colors.textColor,
          //     ),
          //   ).marginOnly(bottom: 8.0),
          //   suffixWidget: const SizedBox.shrink(),
          //   darkMode: darkMode,
          // ).paddingOnly(bottom: 16),

          // /// Save Button
          // if (editMode)
          //   ElevatedButton(
          //     onPressed: saveProfile,
          //     child: state.loading
          //         ? Center(
          //             child: CircularProgressIndicator(
          //               color: Res.colors.whiteColor,
          //             ),
          //           ).marginSymmetric(
          //             vertical: 6.0,
          //           )
          //         : Text(
          //             Res.string.save,
          //           ).marginSymmetric(
          //             vertical: 16.0,
          //           ),
          //   ),
        ],
      ),
    );
  }
}
