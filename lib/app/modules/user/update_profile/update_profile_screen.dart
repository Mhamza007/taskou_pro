import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart' as forms;

import '../../../../resources/resources.dart';
import '../../../app.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => UpdateProfileCubit(context),
      child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) {
          var cubit = context.read<UpdateProfileCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: cubit.back,
                child: SvgPicture.asset(
                  Res.drawable.back,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(
                Res.string.update,
              ),
            ),
            body: forms.ReactiveForm(
              formGroup: cubit.profileForm,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: state.profileImage != null &&
                              state.profileImage!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: state.profileImage!,
                              height: 120,
                              width: 120,
                              errorWidget: (context, url, error) =>
                                  const SizedBox.shrink(),
                            )
                          : state.profileImagePath != null &&
                                  state.profileImagePath!.isNotEmpty
                              ? Image.file(
                                  File(state.profileImagePath!),
                                  height: 120,
                                  width: 120,
                                )
                              : const SizedBox.shrink(),
                    ),
                  ),

                  /// Last Name field
                  ReactiveTextField(
                    formControlName: ProfileForms.lastNameControl,
                    hint: Res.string.enterLastName,
                    keyboardType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
                    ],
                    widgetAboveField: Text(
                      Res.string.lastName,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                    ).marginOnly(bottom: 8.0),
                    suffixWidget: const SizedBox.shrink(),
                    darkMode: darkMode,
                  ).paddingOnly(bottom: 16),

                  /// First Name field
                  ReactiveTextField(
                    formControlName: ProfileForms.firstNameControl,
                    hint: Res.string.enterFirstName,
                    keyboardType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
                    ],
                    widgetAboveField: Text(
                      Res.string.firstName,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                    ).marginOnly(bottom: 8.0),
                    suffixWidget: const SizedBox.shrink(),
                    darkMode: darkMode,
                  ).paddingOnly(bottom: 16),

                  /// Description field
                  ReactiveTextField(
                    formControlName: ProfileForms.descriptionControl,
                    hint: Res.string.enterTheDescription,
                    keyboardType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ]'))
                    ],
                    widgetAboveField: Text(
                      Res.string.description,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                    ).marginOnly(bottom: 8.0),
                    suffixWidget: const SizedBox.shrink(),
                    darkMode: darkMode,
                  ).paddingOnly(bottom: 16),

                  /// Email field
                  ReactiveTextField(
                    formControlName: ProfileForms.emailControl,
                    hint: Res.string.enterEmail,
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    validationMessages: {
                      forms.ValidationMessage.email: (_) =>
                          Res.string.invalidEmailAddress,
                    },
                    widgetAboveField: Text(
                      Res.string.emailOptional,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                    ).marginOnly(bottom: 8.0),
                    suffixWidget: const SizedBox.shrink(),
                    darkMode: darkMode,
                  ).paddingOnly(bottom: 16),

                  /// City field
                  ReactiveTextField(
                    formControlName: ProfileForms.cityControl,
                    hint: Res.string.enterCity,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                    widgetAboveField: Text(
                      Res.string.city,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                    ).marginOnly(bottom: 8.0),
                    suffixWidget: const SizedBox.shrink(),
                    darkMode: darkMode,
                  ).paddingOnly(bottom: 16),

                  /// Province field
                  ReactiveTextField(
                    formControlName: ProfileForms.provinceControl,
                    hint: Res.string.enterProvince,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                    widgetAboveField: Text(
                      Res.string.province,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                    ).marginOnly(bottom: 8.0),
                    suffixWidget: const SizedBox.shrink(),
                    darkMode: darkMode,
                  ).paddingOnly(bottom: 16),

                  /// Zip Code field
                  ReactiveTextField(
                    formControlName: ProfileForms.zipCodeControl,
                    hint: Res.string.enterZipCode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validationMessages: {
                      forms.ValidationMessage.required: (_) =>
                          Res.string.thisFieldIsRequired,
                    },
                    widgetAboveField: Text(
                      Res.string.zipCode,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: darkMode
                            ? Res.colors.textColorDark
                            : Res.colors.textColor,
                      ),
                    ).marginOnly(bottom: 8.0),
                    suffixWidget: const SizedBox.shrink(),
                    darkMode: darkMode,
                  ).paddingOnly(bottom: 16),

                  ElevatedButton(
                    onPressed: cubit.updateProfile,
                    child: state.loading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Res.colors.whiteColor,
                            ),
                          ).marginSymmetric(
                            vertical: 6.0,
                          )
                        : Text(
                            Res.string.update,
                          ).marginSymmetric(
                            vertical: 16.0,
                          ),
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
