import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../app.dart';

class WorkPhotosScreen extends StatelessWidget {
  const WorkPhotosScreen({
    super.key,
    this.workPhotosData,
  });

  final Map? workPhotosData;

  int _getPhotosCount(List? photos) {
    if (photos == null) {
      return 1;
    }
    if (photos.length == 10) {
      return 10;
    }
    return photos.length + 1;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    return BlocProvider(
      create: (context) => WorkPhotosCubit(
        context,
        workPhotosData: workPhotosData,
      ),
      child: BlocBuilder<WorkPhotosCubit, WorkPhotosState>(
        builder: (context, state) {
          var cubit = context.read<WorkPhotosCubit>();

          var photosCount = _getPhotosCount(state.photos);

          return WillPopScope(
            onWillPop: () async => !state.loading,
            child: AbsorbPointer(
              absorbing: state.loading,
              child: Scaffold(
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
                    Res.string.workPhotos,
                  ),
                ),
                body: Stack(
                  children: [
                    ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Text(
                          Res.string.photos_,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ).marginSymmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            itemCount: photosCount,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 20.0);
                            },
                            itemBuilder: (context, index) {
                              if (index == photosCount - 1 &&
                                  (state.photos == null ||
                                      state.photos!.length < 10)) {
                                return AddMediaCircleWidget(
                                  radius: 48.0,
                                  child: Icon(
                                    Icons.add_rounded,
                                    size: 60.0,
                                    color: darkMode
                                        ? Res.colors.backgroundColorLight
                                        : Res.colors.backgroundColorDark,
                                  ),
                                ).onTap(cubit.pickImage);
                              }
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: state.photos![index]
                                                      ['image_url'] !=
                                                  null &&
                                              state.photos![index]['image_url']
                                                  .toString()
                                                  .isNotEmpty
                                          ? Image.network(
                                              state.photos![index]['image_url'],
                                              fit: BoxFit.fill,
                                            )
                                          : state.photos![index]
                                                          ['image_path'] !=
                                                      null &&
                                                  state.photos![index]
                                                          ['image_path']
                                                      .toString()
                                                      .isNotEmpty
                                              ? Image.file(
                                                  File(state.photos![index]
                                                      ['image_path']),
                                                  fit: BoxFit.fill,
                                                )
                                              : Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Res
                                                        .colors.failureRedColor,
                                                  ),
                                                ),
                                    ),
                                    Positioned(
                                      right: 4.0,
                                      top: 4.0,
                                      child: CircleAvatar(
                                        backgroundColor: Res.colors.redColor,
                                        radius: 12.0,
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: 20.0,
                                          color: Res.colors.whiteColor,
                                        ),
                                      ).onTap(
                                        () => cubit.deletePhoto(index),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // Text(
                        //   Res.string.videoOptional,
                        //   style: const TextStyle(
                        //     fontSize: 18.0,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ).marginSymmetric(
                        //   horizontal: 20.0,
                        //   vertical: 16.0,
                        // ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: state.video != null && state.video!.isNotEmpty
                        //       ? SizedBox(
                        //           height: 96.0,
                        //           width: 96.0,
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(12.0),
                        //             child: Stack(
                        //               children: [
                        //                 AspectRatio(
                        //                   aspectRatio: 1.0,
                        //                   child: state.videoThumbnail != null &&
                        //                           state.videoThumbnail!
                        //                               .isNotEmpty
                        //                       ? Stack(
                        //                           children: [
                        //                             Image.file(
                        //                               File(state
                        //                                   .videoThumbnail!),
                        //                               fit: BoxFit.fill,
                        //                               width: 96.0,
                        //                               height: 96.0,
                        //                             ),
                        //                             Center(
                        //                               child: CircleAvatar(
                        //                                 backgroundColor: Res
                        //                                     .colors
                        //                                     .materialColor[300],
                        //                                 child: Icon(
                        //                                   Icons.play_arrow,
                        //                                   size: 40.0,
                        //                                   color: Res.colors
                        //                                       .materialColor,
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         )
                        //                       : Container(
                        //                           color:
                        //                               Res.colors.materialColor,
                        //                           padding:
                        //                               const EdgeInsets.all(4.0),
                        //                           child: Container(
                        //                             decoration: BoxDecoration(
                        //                               color: darkMode
                        //                                   ? Res.colors
                        //                                       .backgroundColorDark
                        //                                   : Res.colors
                        //                                       .whiteColor,
                        //                               borderRadius:
                        //                                   BorderRadius.circular(
                        //                                       8.0),
                        //                             ),
                        //                             child: Center(
                        //                               child: CircleAvatar(
                        //                                 backgroundColor: Res
                        //                                     .colors
                        //                                     .materialColor[300],
                        //                                 child: Icon(
                        //                                   Icons.play_arrow,
                        //                                   size: 40.0,
                        //                                   color: Res.colors
                        //                                       .materialColor,
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                 ),
                        //                 Positioned(
                        //                   right: 4.0,
                        //                   top: 4.0,
                        //                   child: CircleAvatar(
                        //                     backgroundColor:
                        //                         Res.colors.redColor,
                        //                     radius: 12.0,
                        //                     child: Icon(
                        //                       Icons.close_rounded,
                        //                       size: 20.0,
                        //                       color: Res.colors.whiteColor,
                        //                     ),
                        //                   ).onTap(cubit.deleteVideo),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ).onTap(cubit.openVideoPlayer)
                        //       : AddMediaCircleWidget(
                        //           radius: 48.0,
                        //           child: Icon(
                        //             Icons.add_rounded,
                        //             size: 60.0,
                        //             color: darkMode
                        //                 ? Res.colors.backgroundColorLight
                        //                 : Res.colors.backgroundColorDark,
                        //           ),
                        //         ).onTap(cubit.pickVideo),
                        // ).marginSymmetric(
                        //   horizontal: 20.0,
                        // ),
                      ],
                    ),
                    if (state.loading)
                      CupertinoAlertDialog(
                        title: const CupertinoActivityIndicator(),
                        content: Text(Res.string.loading),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
