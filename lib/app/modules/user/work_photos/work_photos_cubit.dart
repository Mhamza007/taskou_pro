// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:taskou_pro/configs/configs.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'work_photos_state.dart';

const videoDurationSeconds = 60 * 5; // 5 minutes

class WorkPhotosCubit extends Cubit<WorkPhotosState> {
  WorkPhotosCubit(
    this.context, {
    this.workPhotosData,
  }) : super(const WorkPhotosState()) {
    _userStorage = UserStorage();
    _picker = ImagePicker();
    _userApi = UserApi();

    workPhotosPaths = [];

    _getWorkMediaFromServer();
    // if (workPhotosData != null && workPhotosData?['profile_mode'] == true) {
    //   profileMode = true;
    //   _getWorkMediaFromServer();
    // } else {
    //   profileMode = false;
    //   getWorkMediaFromStorage();
    // }
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late final UserApi _userApi;
  late ImagePicker _picker;
  late List<Map<String, dynamic>> workPhotosPaths;
  final Map? workPhotosData;
  bool profileMode = true;

  @override
  Future<void> close() {
    workPhotosPaths.clear();
    return super.close();
  }

  void back() => Navigator.pop(context);

  Future<void> _getWorkMediaFromServer() async {
    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var userToken = _userStorage.getUserToken();
        if (userToken != null && userToken.isNotEmpty) {
          var response = await _userApi.getWorkPhotos(
            userToken: userToken,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            response?.data?.forEach(
              (element) {
                workPhotosPaths.add({
                  'id': element.id,
                  'image_url': '${HTTPConfig.imageBaseURL}${element.image}',
                });
              },
            );

            emit(
              state.copyWith(
                photos: workPhotosPaths,
              ),
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
          apiResponseStatus: ApiResponseStatus.none,
          loading: false,
        ),
      );
    }
  }

  void getWorkMediaFromStorage() {
    List? workPhotos = _userStorage.getUserWorkPhotos();
    if (workPhotos != null && workPhotos.isNotEmpty) {
      for (var workPhoto in workPhotos) {
        workPhotosPaths.add(workPhoto);
      }
      emit(
        state.copyWith(
          photos: workPhotosPaths,
        ),
      );
    }
    String? workVideo = _userStorage.getUserWorkVideo();
    emit(
      state.copyWith(
        video: workVideo,
      ),
    );

    String? workVideoThumbnail = _userStorage.getUserWorkVideoThumbnail();
    emit(
      state.copyWith(
        videoThumbnail: workVideoThumbnail,
      ),
    );
  }

  Future _pickImageSheet({
    required Function() cameraCallback,
    required Function() galleryCallback,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text(Res.string.chooseASource),
          actions: [
            CupertinoActionSheetAction(
              onPressed: cameraCallback,
              child: Text(Res.string.camera),
            ),
            CupertinoActionSheetAction(
              onPressed: galleryCallback,
              child: Text(Res.string.gallery),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDefaultAction: true,
            child: Text(
              Res.string.cancel,
              style: TextStyle(
                color: Res.colors.redColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImage() async {
    try {
      XFile? pickedFile;
      await _pickImageSheet(
        cameraCallback: () async {
          pickedFile = await _picker.pickImage(
            source: ImageSource.camera,
          );
          Navigator.pop(context);
        },
        galleryCallback: () async {
          pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          Navigator.pop(context);
        },
      );
      if (pickedFile != null) {
        emit(
          state.copyWith(
            loading: true,
          ),
        );
        var dir = await path_provider.getApplicationDocumentsDirectory();
        var savedFile = await File(pickedFile!.path).copy(
          '${dir.path}/${pickedFile!.name}',
        );
        debugPrint('savedFile ${savedFile.path}');

        if (profileMode) {
          var uploadWorkResponse = await uploadWork(
            filePath: savedFile.path,
          );

          if (uploadWorkResponse?.statusCode == 200) {
            workPhotosPaths.add(
              {
                'image_path': savedFile.path,
              },
            );

            await _userStorage.setUserWorkPhotos(workPhotosPaths);

            emit(
              state.copyWith(
                photos: workPhotosPaths,
              ),
            );
          } else {
            DialogUtil.showDialogWithOKButton(
              context,
              isError: true,
              message:
                  uploadWorkResponse?.message ?? Res.string.apiErrorMessage,
            );
          }
        } else {
          workPhotosPaths.add({'image_path': savedFile.path});

          await _userStorage.setUserWorkPhotos(workPhotosPaths);

          emit(
            state.copyWith(
              photos: workPhotosPaths,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('e $e');
      DialogUtil.showDialogWithOKButton(
        context,
        message: Res.string.errorGettingImage,
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }

  Future<void> pickVideo() async {
    try {
      XFile? pickedFile;
      await _pickImageSheet(
        cameraCallback: () async {
          pickedFile = await _picker.pickVideo(
            source: ImageSource.camera,
            maxDuration: const Duration(seconds: videoDurationSeconds),
          );
          Navigator.pop(context);
        },
        galleryCallback: () async {
          pickedFile = await _picker.pickVideo(
            source: ImageSource.gallery,
            maxDuration: const Duration(seconds: videoDurationSeconds),
          );
          Navigator.pop(context);
        },
      );
      if (pickedFile != null) {
        emit(
          state.copyWith(
            loading: true,
          ),
        );
        var fileSize = await pickedFile!.length() / 1024 / 1024;
        File? savedFile;
        MediaInfo? mediaInfo = await VideoCompress.compressVideo(
          pickedFile!.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: true,
          frameRate: 25,
        );
        File? compressedFile = mediaInfo?.file;
        if (mediaInfo != null && compressedFile != null) {
          debugPrint('compressedFile size ${mediaInfo.filesize}');

          var dir = await path_provider.getApplicationDocumentsDirectory();
          savedFile = await File(compressedFile.path).copy(
            '${dir.path}/${pickedFile!.name}',
          );
          debugPrint('savedFile ${savedFile.path}');

          await _userStorage.setUserWorkVideo(savedFile.path);

          var thumbnailFile = await VideoCompress.getFileThumbnail(
            savedFile.path,
            quality: 80,
            position: -1,
          );
          var newThumbnailFile = await thumbnailFile.copy(
            '${dir.path}/video_thumbnail_${DateTime.now().millisecondsSinceEpoch}.png',
          );

          await _userStorage.setUserWorkVideoThumbnail(newThumbnailFile.path);
          emit(
            state.copyWith(
              video: savedFile.path,
              videoThumbnail: newThumbnailFile.path,
            ),
          );
          try {
            File(pickedFile!.path).delete();
            compressedFile.delete();
            thumbnailFile.delete();
          } catch (_) {}
        } else {
          if (fileSize <= 30) {
            var dir = await path_provider.getApplicationDocumentsDirectory();
            savedFile = await File(pickedFile!.path).copy(
              '${dir.path}/${pickedFile!.name}',
            );
            debugPrint('savedFile ${savedFile.path}');

            await _userStorage.setUserWorkVideo(savedFile.path);

            final uint8list = await VideoThumbnail.thumbnailData(
              video: savedFile.path,
              imageFormat: ImageFormat.JPEG,
              maxWidth: 100,
              quality: 50,
            );

            if (uint8list != null) {
              File file = await File('${dir.path}/video_thumbnail.png').create(
                recursive: true,
              );
              var thumbnailFile = await file.writeAsBytes(uint8list);

              await _userStorage.setUserWorkVideoThumbnail(thumbnailFile.path);
              emit(
                state.copyWith(
                  videoThumbnail: thumbnailFile.path,
                ),
              );
            }

            try {
              File(pickedFile!.path).delete();
            } catch (_) {}

            emit(
              state.copyWith(
                video: savedFile.path,
              ),
            );
          } else {
            try {
              File(pickedFile!.path).delete();
            } catch (_) {}
            DialogUtil.showDialogWithOKButton(
              context,
              message: 'The video size must be less than 30MB',
            );
          }
        }
      }
    } catch (e) {
      debugPrint('e $e');
      await _userStorage.setUserWorkVideo(null);
      await _userStorage.setUserWorkVideoThumbnail(null);
      DialogUtil.showDialogWithOKButton(
        context,
        message: Res.string.errorGettingVideo,
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }

  Future<StatusMessageResponse?> uploadWork({
    required String filePath,
  }) async {
    StatusMessageResponse? statusMessageResponse;

    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var userToken = _userStorage.getUserToken();
        if (userToken != null && userToken.isNotEmpty) {
          statusMessageResponse = await _userApi.uploadWorkPhoto(
            userToken: userToken,
            filePath: filePath,
          );
          debugPrint('uploadWork: ${statusMessageResponse?.message}');
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
          apiResponseStatus: ApiResponseStatus.none,
          loading: false,
        ),
      );
    }

    return statusMessageResponse;
  }

  void openVideoPlayer() {
    // state.video
  }

  void deletePhoto(int index) async {
    try {
      await DialogUtil.showDialogWithYesNoButton(
        context,
        message: Res.string.doYouWantToDeletePhoto,
        yesBtnColor: Res.colors.redColor,
        yesBtnText: Res.string.delete,
        noBtnText: Res.string.cancel,
        yesBtnCallback: () async {
          emit(
            state.copyWith(
              loading: true,
            ),
          );

          if (profileMode) {
            // Delete from server
            try {
              emit(
                state.copyWith(
                  loading: true,
                ),
              );

              var isConnected = await NetworkService().getConnectivity();
              if (isConnected) {
                var userToken = _userStorage.getUserToken();
                if (userToken != null && userToken.isNotEmpty) {
                  var response = await _userApi.deleteWorkPhoto(
                    userToken: userToken,
                    workId: workPhotosPaths[index]['id'],
                  );

                  if (response?.statusCode == 200) {
                    try {
                      if (File(state.photos![index]['image_path'])
                          .existsSync()) {
                        await File(state.photos![index]['image_path'])
                            .delete(recursive: true);
                      }
                    } catch (_) {}

                    workPhotosPaths.removeAt(index);

                    await _userStorage.setUserWorkPhotos(workPhotosPaths);

                    emit(
                      state.copyWith(
                        photos: workPhotosPaths,
                      ),
                    );

                    Navigator.pop(context);

                    DialogUtil.showDialogWithOKButton(
                      context,
                      message: Res.string.photoDeletedSuccessfully,
                    );
                  } else {
                    emit(
                      state.copyWith(
                        apiResponseStatus: ApiResponseStatus.failure,
                        message:
                            response?.message ?? Res.string.apiErrorMessage,
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
                  apiResponseStatus: ApiResponseStatus.none,
                  loading: false,
                ),
              );
            }
          } else {
            if (File(state.photos![index]['image_path']).existsSync()) {
              await File(state.photos![index]['image_path'])
                  .delete(recursive: true);
            }

            workPhotosPaths.removeAt(index);

            await _userStorage.setUserWorkPhotos(workPhotosPaths);

            emit(
              state.copyWith(
                photos: workPhotosPaths,
              ),
            );

            Navigator.pop(context);

            DialogUtil.showDialogWithOKButton(
              context,
              message: Res.string.photoDeletedSuccessfully,
            );
          }
        },
      );
    } catch (e) {
      DialogUtil.showDialogWithOKButton(
        context,
        message: Res.string.unableToDeletePhoto,
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }

  void deleteVideo() async {
    try {
      await DialogUtil.showDialogWithYesNoButton(
        context,
        message: Res.string.doYouWantToDeleteVideo,
        yesBtnColor: Res.colors.redColor,
        yesBtnText: Res.string.delete,
        noBtnText: Res.string.cancel,
        yesBtnCallback: () async {
          emit(
            state.copyWith(
              loading: true,
            ),
          );
          if (state.video != null &&
              state.video!.isNotEmpty &&
              File(state.video!).existsSync()) {
            await File(state.video!).delete(recursive: true);
          }
          if (state.videoThumbnail != null &&
              state.videoThumbnail!.isNotEmpty &&
              File(state.videoThumbnail!).existsSync()) {
            await File(state.videoThumbnail!).delete(recursive: true);
          }

          await _userStorage.setUserWorkVideo(null);
          await _userStorage.setUserWorkVideoThumbnail(null);

          emit(
            state.copyWith(
              video: '',
              videoThumbnail: '',
            ),
          );

          Navigator.pop(context);

          DialogUtil.showDialogWithOKButton(
            context,
            message: Res.string.videoDeletedSuccessfully,
          );
        },
      );
    } catch (e) {
      DialogUtil.showDialogWithOKButton(
        context,
        message: Res.string.unableToDeleteVideo,
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }
}
