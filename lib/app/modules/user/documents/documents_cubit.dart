// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:taskou_pro/configs/configs.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'documents_state.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit(
    this.context, {
    this.documentsData,
  }) : super(const DocumentsState()) {
    _userStorage = UserStorage();
    _picker = ImagePicker();
    _userApi = UserApi();

    _getDocumentsFromServer();
    // if (documentsData != null && documentsData?['profile_mode'] == true) {
    //   profileMode = true;
    //   _getDocumentsFromServer();
    // } else {
    //   profileMode = false;
    //   getDocumentsFromStorage();
    // }
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late ImagePicker _picker;
  late UserApi _userApi;
  final Map? documentsData;
  bool profileMode = true;

  void back() => Navigator.pop(context);

  Future<void> _getDocumentsFromServer() async {
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
          var response = await _userApi.getDocuments(
            userToken: userToken,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            emit(
              state.copyWith(
                idProofFront: response?.data?.idFront != null &&
                        response?.data?.idFront?.isNotEmpty == true
                    ? '${HTTPConfig.imageBaseURL}${response?.data?.idFront}'
                    : null,
                idProofBack: response?.data?.idBack != null &&
                        response?.data?.idBack?.isNotEmpty == true
                    ? '${HTTPConfig.imageBaseURL}${response?.data?.idBack}'
                    : null,
                certificateFront: response?.data?.certFront != null &&
                        response?.data?.certFront?.isNotEmpty == true
                    ? '${HTTPConfig.imageBaseURL}${response?.data?.certFront}'
                    : null,
                certificateBack: response?.data?.certBack != null &&
                        response?.data?.certBack?.isNotEmpty == true
                    ? '${HTTPConfig.imageBaseURL}${response?.data?.certBack}'
                    : null,
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

  void getDocumentsFromStorage() {
    String? idFront = _userStorage.getUserIdFront();
    String? idBack = _userStorage.getUserIdBack();
    String? certificateFront = _userStorage.getUserCertificateFront();
    String? certificateBack = _userStorage.getUserCertificateBack();

    emit(
      state.copyWith(
        idProofFront: idFront != null &&
                idFront.isNotEmpty &&
                File(
                  idFront,
                ).existsSync()
            ? idFront
            : null,
        idProofBack: idBack != null &&
                idBack.isNotEmpty &&
                File(
                  idBack,
                ).existsSync()
            ? idBack
            : null,
        certificateFront: certificateFront != null &&
                certificateFront.isNotEmpty &&
                File(certificateFront).existsSync()
            ? certificateFront
            : null,
        certificateBack: certificateBack != null &&
                certificateBack.isNotEmpty &&
                File(certificateBack).existsSync()
            ? certificateBack
            : null,
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

  Future<void> _pickImage(
    String imageName,
    Function(File file) onSaveCallback,
  ) async {
    XFile? pickedFile;
    try {
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
          '${dir.path}/$imageName.png',
        );
        debugPrint('savedFile ${savedFile.path}');
        onSaveCallback(savedFile);
      }
    } catch (e) {
      debugPrint('e $e');
      DialogUtil.showDialogWithOKButton(
        context,
        message: Res.string.errorGettingImage,
      );
    }
  }

  Future<void> idFrontCallback() async {
    await _pickImage(
      'id_proof_front_${DateTime.now().millisecondsSinceEpoch}',
      (File file) async {
        if (profileMode) {
          var uploadDocumentResponse = await uploadDocument(
            documentType: 'id_front',
            filePath: file.path,
          );

          if (uploadDocumentResponse?.statusCode == 200) {
            await _userStorage.setUserIdFront(file.path);
            emit(
              state.copyWith(
                loading: false,
                idProofFront: file.path,
              ),
            );

            DialogUtil.showDialogWithOKButton(
              context,
              message: uploadDocumentResponse?.message ?? Res.string.success,
            );
          } else {
            DialogUtil.showDialogWithOKButton(
              context,
              isError: true,
              message:
                  uploadDocumentResponse?.message ?? Res.string.apiErrorMessage,
            );
          }
        } else {
          await _userStorage.setUserIdFront(file.path);
          emit(
            state.copyWith(
              loading: false,
              idProofFront: file.path,
            ),
          );
        }
      },
    );
  }

  Future<void> idBackCallback() async {
    await _pickImage(
      'id_proof_back_${DateTime.now().millisecondsSinceEpoch}',
      (File file) async {
        if (profileMode) {
          var uploadDocumentResponse = await uploadDocument(
            documentType: 'id_back',
            filePath: file.path,
          );

          if (uploadDocumentResponse?.statusCode == 200) {
            await _userStorage.setUserIdBack(file.path);
            emit(
              state.copyWith(
                loading: false,
                idProofBack: file.path,
              ),
            );

            DialogUtil.showDialogWithOKButton(
              context,
              message: uploadDocumentResponse?.message ?? Res.string.success,
            );
          } else {
            DialogUtil.showDialogWithOKButton(
              context,
              isError: true,
              message:
                  uploadDocumentResponse?.message ?? Res.string.apiErrorMessage,
            );
          }
        } else {
          await _userStorage.setUserIdBack(file.path);
          emit(
            state.copyWith(
              loading: false,
              idProofBack: file.path,
            ),
          );
        }
      },
    );
  }

  Future<void> certificateFrontCallback() async {
    await _pickImage(
      'certificate_front_${DateTime.now().millisecondsSinceEpoch}',
      (File file) async {
        if (profileMode) {
          var uploadDocumentResponse = await uploadDocument(
            documentType: 'cert_front',
            filePath: file.path,
          );

          if (uploadDocumentResponse?.statusCode == 200) {
            await _userStorage.setUserCertificateFront(file.path);
            emit(
              state.copyWith(
                loading: false,
                certificateFront: file.path,
              ),
            );

            DialogUtil.showDialogWithOKButton(
              context,
              message: uploadDocumentResponse?.message ?? Res.string.success,
            );
          } else {
            DialogUtil.showDialogWithOKButton(
              context,
              isError: true,
              message:
                  uploadDocumentResponse?.message ?? Res.string.apiErrorMessage,
            );
          }
        } else {
          await _userStorage.setUserCertificateFront(file.path);
          emit(
            state.copyWith(
              loading: false,
              certificateFront: file.path,
            ),
          );
        }
      },
    );
  }

  Future<void> certificateBackCallback() async {
    await _pickImage(
      'certificate_back_${DateTime.now().millisecondsSinceEpoch}',
      (File file) async {
        if (profileMode) {
          var uploadDocumentResponse = await uploadDocument(
            documentType: 'cert_back',
            filePath: file.path,
          );

          if (uploadDocumentResponse?.statusCode == 200) {
            await _userStorage.setUserCertificateBack(file.path);
            emit(
              state.copyWith(
                loading: false,
                certificateBack: file.path,
              ),
            );

            DialogUtil.showDialogWithOKButton(
              context,
              message: uploadDocumentResponse?.message ?? Res.string.success,
            );
          } else {
            DialogUtil.showDialogWithOKButton(
              context,
              isError: true,
              message:
                  uploadDocumentResponse?.message ?? Res.string.apiErrorMessage,
            );
          }
        } else {
          await _userStorage.setUserCertificateBack(file.path);
          emit(
            state.copyWith(
              loading: false,
              certificateBack: file.path,
            ),
          );
        }
      },
    );
  }

  Future<StatusMessageResponse?> uploadDocument({
    required String documentType,
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
          statusMessageResponse = await _userApi.uploadDocument(
            userToken: userToken,
            key: documentType,
            filePath: filePath,
          );
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
}
