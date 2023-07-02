// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit(
    this.context,
  ) : super(const CompleteProfileState()) {
    _userStorage = UserStorage();
    _picker = ImagePicker();
    _userApi = UserApi();

    _loadDataFromStorage();
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late ImagePicker _picker;
  late UserApi _userApi;

  void _checkProfileImage() {
    var profileImage = _userStorage.getUserProfileImagePath();
    if (profileImage != null &&
        profileImage.isNotEmpty &&
        File(profileImage).existsSync()) {
      emit(
        state.copyWith(
          profileImage: File(profileImage),
        ),
      );
    }
  }

  void _checkProfessions() {
    var professions = _userStorage.getUserProfessions();
    if (professions != null && professions.isNotEmpty) {
      emit(
        state.copyWith(
          professionsCompleted: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          professionsCompleted: false,
        ),
      );
    }
  }

  void _checkWorkPhotos() {
    List? workPhotos = _userStorage.getUserWorkPhotos();
    if (workPhotos != null && workPhotos.isNotEmpty) {
      emit(
        state.copyWith(
          workPhotosCompleted: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          workPhotosCompleted: false,
        ),
      );
    }
  }

  void _checkDocuments() {
    String? idFront = _userStorage.getUserIdFront();
    String? idBack = _userStorage.getUserIdBack();
    if (idFront != null &&
        idFront.isNotEmpty &&
        File(idFront).existsSync() &&
        idBack != null &&
        idBack.isNotEmpty &&
        File(idBack).existsSync()) {
      emit(
        state.copyWith(
          documentsCompleted: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          documentsCompleted: false,
        ),
      );
    }
  }

  void _loadDataFromStorage() {
    _checkProfileImage();
    _checkProfessions();
    _checkWorkPhotos();
    _checkDocuments();
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
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
        galleryCallback: () async {
          pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
      );
      if (pickedFile != null) {
        emit(
          state.copyWith(
            photoLoading: true,
          ),
        );
        var dir = await path_provider.getApplicationDocumentsDirectory();
        var savedFile = await File(pickedFile!.path).copy(
          '${dir.path}/${pickedFile!.name}',
        );
        debugPrint('savedFile ${savedFile.path}');

        await _userStorage.setUserProfileImagePath(
          savedFile.path,
        );

        emit(
          state.copyWith(
            profileImage: File(
              savedFile.path,
            ),
          ),
        );
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
          photoLoading: false,
        ),
      );
    }
  }

  Future<void> goToProfession() async {
    await Navigator.pushNamed(
      context,
      Routes.profession,
    );
    _checkProfessions();
  }

  Future<void> goToWorkPhotos() async {
    await Navigator.pushNamed(
      context,
      Routes.workPhotos,
    );
    _checkWorkPhotos();
  }

  Future<void> goToDocuments() async {
    await Navigator.pushNamed(
      context,
      Routes.documents,
    );
    _checkDocuments();
  }

  bool isFormCompleted() {
    // return state.profileImage != null &&
    return state.professionsCompleted &&
        state.workPhotosCompleted &&
        state.documentsCompleted;
  }

  Future<void> uploadUserProfessions(
    String userToken,
    List professions,
  ) async {
    for (var profession in professions) {
      try {
        var setProfession = await _userApi.setUserProfession(
          userToken: userToken,
          profession: profession,
        );

        debugPrint('setProfession: ${setProfession?.message}');
        if (setProfession?.statusCode == 200) {
        } else {
          debugPrint('setProfession: ${setProfession?.message}');
          throw ProfessionException(
            setProfession?.message ?? Res.string.professionExceptionMessage,
          );
        }
      } catch (e) {
        throw ProfessionException(Res.string.professionExceptionMessage);
      }
    }
  }

  Future<void> uploadWorkPhotos(
    String userToken,
    List workPhotos,
  ) async {
    for (var workPhoto in workPhotos) {
      try {
        var uploadWorkPhoto = await _userApi.uploadWorkPhoto(
          userToken: userToken,
          filePath: workPhoto,
        );

        debugPrint('uploadWorkPhoto: ${uploadWorkPhoto?.message}');

        if (uploadWorkPhoto?.statusCode == 200) {
        } else {
          debugPrint('uploadWorkPhoto: ${uploadWorkPhoto?.message}');
          throw WorkPhotosException(
            uploadWorkPhoto?.message ?? Res.string.workPhotosExceptionMessage,
          );
        }
      } catch (e) {
        throw WorkPhotosException(Res.string.workPhotosExceptionMessage);
      }
    }
  }

  Future<void> uploadDocuments(
    String userToken,
    String idFront,
    String idBack,
    String? certFront,
    String? certBack,
  ) async {
    try {
      var uploadIdFront = await _userApi.uploadDocument(
        userToken: userToken,
        key: 'id_front',
        filePath: idFront,
      );

      debugPrint('uploadIdFront: ${uploadIdFront?.message}');

      if (uploadIdFront?.statusCode == 200) {
      } else {
        throw DocumentsException(
          uploadIdFront?.message ?? Res.string.documentsExceptionMessage,
        );
      }

      var uploadIdBack = await _userApi.uploadDocument(
        userToken: userToken,
        key: 'id_back',
        filePath: idBack,
      );

      debugPrint('uploadIdBack: ${uploadIdBack?.message}');

      if (uploadIdBack?.statusCode == 200) {
      } else {
        throw DocumentsException(
          uploadIdBack?.message ?? Res.string.documentsExceptionMessage,
        );
      }

      if (certFront != null && certFront.isNotEmpty) {
        var uploadCertFront = await _userApi.uploadDocument(
          userToken: userToken,
          key: 'cert_front',
          filePath: certFront,
        );

        debugPrint('uploadCertFront: ${uploadCertFront?.message}');

        if (uploadCertFront?.statusCode == 200) {
        } else {
          throw DocumentsException(
            uploadCertFront?.message ?? Res.string.documentsExceptionMessage,
          );
        }
      }

      if (certBack != null && certBack.isNotEmpty) {
        var uploadCertBack = await _userApi.uploadDocument(
          userToken: userToken,
          key: 'cert_back',
          filePath: certBack,
        );

        debugPrint('uploadCertBack: ${uploadCertBack?.message}');

        if (uploadCertBack?.statusCode == 200) {
        } else {
          throw DocumentsException(
            uploadCertBack?.message ?? Res.string.documentsExceptionMessage,
          );
        }
      }
    } catch (e) {
      throw DocumentsException(
        Res.string.documentsExceptionMessage,
      );
    }
  }

  Future<Map<String, dynamic>> submitforApproval(
    String userToken,
  ) async {
    try {
      var submitforApproval = await _userApi.submitforApproval(
        userToken: userToken,
      );

      if (submitforApproval?.statusCode == 200) {
        return {
          'status': true,
          'message': submitforApproval?.message ??
              Res.string.submitForApprovalSuccessMessage,
        };
      } else {
        return {
          'status': false,
          'message': submitforApproval?.message ?? Res.string.apiErrorMessage,
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': Res.string.apiErrorMessage,
      };
    }
  }

  Future<void> submitForApprovalTapped() async {
    var userToken = _userStorage.getUserToken();

    if (userToken != null && userToken.isNotEmpty) {
      try {
        emit(
          state.copyWith(
            loading: true,
          ),
        );

        // // Professions
        // var professions = _userStorage.getUserProfessions();
        // debugPrint('professions = $professions');

        // await uploadUserProfessions(
        //   userToken,
        //   professions!,
        // );

        // // Work Photos
        // List? workPhotos = _userStorage.getUserWorkPhotos();
        // debugPrint('workPhotos = $workPhotos');

        // await uploadWorkPhotos(
        //   userToken,
        //   workPhotos!,
        // );

        // // Documents
        // String? idFront = _userStorage.getUserIdFront();
        // String? idBack = _userStorage.getUserIdBack();
        // String? certFront = _userStorage.getUserCertificateFront();
        // String? certBack = _userStorage.getUserCertificateBack();

        // await uploadDocuments(
        //   userToken,
        //   idFront!,
        //   idBack!,
        //   certFront,
        //   certBack,
        // );

        var submit = await submitforApproval(userToken);
        if (submit['status'] == true) {
          DialogUtil.showDialogWithOKButton(
            context,
            message: submit['message'],
            barrierDismissible: false,
            callback: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.signIn,
                (route) => false,
              );
            },
          );
        } else {
          DialogUtil.showDialogWithOKButton(
            context,
            message: submit['message'],
            isError: true,
          );
        }
      } on ProfessionException catch (e) {
        Helpers.errorSnackBar(
          context: context,
          title: e.toString(),
        );
      } on WorkPhotosException catch (e) {
        Helpers.errorSnackBar(
          context: context,
          title: e.toString(),
        );
      } on DocumentsException catch (e) {
        Helpers.errorSnackBar(
          context: context,
          title: e.toString(),
        );
      } catch (e) {
        debugPrint('$e');
        Helpers.errorSnackBar(
          context: context,
          title: Res.string.apiErrorMessage,
        );
      } finally {
        emit(
          state.copyWith(
            loading: false,
          ),
        );
      }
    } else {
      Helpers.errorSnackBar(
        context: context,
        title: Res.string.userAuthFailedLoginAgain,
      );
    }
  }
}
