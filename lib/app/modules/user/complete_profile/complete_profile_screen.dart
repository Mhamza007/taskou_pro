import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;
    double profileImageRadius = 48.0;

    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider(
        create: (context) => CompleteProfileCubit(context),
        child: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
          builder: (context, state) {
            var cubit = context.read<CompleteProfileCubit>();

            return Scaffold(
              appBar: AppBar(
                leading: null,
                title: Text(
                  Res.string.completeYourProfile,
                ),
              ),
              body: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        AddMediaCircleWidget(
                          radius: profileImageRadius,
                          backgroundImage: state.profileImage != null
                              ? FileImage(state.profileImage!)
                              : null,
                          child: state.profileImage == null
                              ? Icon(
                                  Icons.add_rounded,
                                  size: 60.0,
                                  color: darkMode
                                      ? Res.colors.backgroundColorLight
                                      : Res.colors.backgroundColorDark,
                                )
                              : null,
                        ).onTap(cubit.pickImage),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: SizedBox(
                            height: profileImageRadius * 1.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi ${state.userName ?? ''}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  Res.string.youAreFewStepsCompleteYourProfile,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).paddingAll(24.0),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 16.0,
                        child: CircleAvatar(
                          radius: 14.0,
                          backgroundColor: state.professionsCompleted
                              ? Res.colors.materialColor
                              : Res.colors.lightGreyColor,
                          child: state.professionsCompleted
                              ? Center(
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Res.colors.whiteColor,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      title: Text(Res.string.profession),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      onTap: cubit.goToProfession,
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 16.0,
                        child: CircleAvatar(
                          radius: 14.0,
                          backgroundColor: state.workPhotosCompleted
                              ? Res.colors.materialColor
                              : Res.colors.lightGreyColor,
                          child: state.workPhotosCompleted
                              ? Center(
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Res.colors.whiteColor,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      title: Text(Res.string.uploadYourWorkPhotos),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      onTap: cubit.goToWorkPhotos,
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 16.0,
                        child: CircleAvatar(
                          radius: 14.0,
                          backgroundColor: state.documentsCompleted
                              ? Res.colors.materialColor
                              : Res.colors.lightGreyColor,
                          child: state.documentsCompleted
                              ? Center(
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Res.colors.whiteColor,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      title: Text(Res.string.uploadYourDocuments),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      onTap: cubit.goToDocuments,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      // onPressed: cubit.submitForApproval,
                      onPressed: cubit.isFormCompleted()
                          ? cubit.submitForApprovalTapped
                          : null,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: state.loading
                          ? const SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ).paddingSymmetric(
                              vertical: 12,
                              horizontal: 64,
                            )
                          : Text(
                              Res.string.submitForApproval,
                              style: TextStyle(
                                color: Res.colors.whiteColor,
                                fontSize: 20.0,
                              ),
                            ).paddingSymmetric(
                              vertical: 12,
                              horizontal: 32,
                            ),
                    ).paddingAll(16.0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
