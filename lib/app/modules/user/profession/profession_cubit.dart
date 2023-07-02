// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../db/db.dart';
import '../../../../resources/resources.dart';
import '../../../../sdk/sdk.dart';
import '../../../app.dart';

part 'profession_state.dart';

class ProfessionCubit extends Cubit<ProfessionState> {
  ProfessionCubit(
    this.context, {
    this.professionsData,
  }) : super(const ProfessionState()) {
    _userStorage = UserStorage();

    pageController = PageController(
      initialPage: state.page,
    );

    professionsList = [];
    _categoriesApi = CategoriesApi();
    _userApi = UserApi();
    getCategories();

    _getProfessionData();
    // if (professionsData != null && professionsData?['profile_mode'] == true) {
    //   profileMode = true;
    //   _getProfessionData();
    // } else {
    //   profileMode = false;
    //   getProfessionsFromStorage();
    // }
  }

  final BuildContext context;
  late UserStorage _userStorage;
  late PageController pageController;
  late final CategoriesApi _categoriesApi;
  late final UserApi _userApi;
  late List<Map<String, dynamic>> professionsList;
  final Map? professionsData;
  bool profileMode = true;

  void setTitle() {
    emit(
      state.copyWith(
        title: Res.string.addProfession,
        appBarTitle: Res.string.addProfession,
      ),
    );
  }

  Future<void> _getProfessionData() async {
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
          var response = await _userApi.getUserProfessions(
            userToken: userToken,
          );

          if (response?.statusCode == 200 && response?.data != null) {
            response?.data?.forEach(
              (element) {
                var profession = {
                  'id': element.id,
                  'handyman_id': element.handymanId,
                  'cat_id': element.catId,
                  'cat_name': element.categoryName,
                  'sub1_id': element.sub1Id,
                  'sub1_name': element.subCategory,
                  'sub2_id': element.sub2Id,
                  'sub2_name': element.subSubCatName,
                  'sub3_id': element.sub3Id,
                  'sub3_name': element.subSubSubCatName,
                };
                professionsList.add(profession);
              },
            );

            emit(
              state.copyWith(
                professions: professionsList,
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

  void getProfessionsFromStorage() {
    var professions = _userStorage.getUserProfessions();
    if (professions != null && professions.isNotEmpty) {
      for (var profession in professions) {
        professionsList.add(profession);
      }
      emit(
        state.copyWith(
          professions: professionsList,
        ),
      );
    }
  }

  Future<void> addProfession() async {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  Future<void> getCategories() async {
    setTitle();

    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );
      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var response = await _categoriesApi.getCategories();

        if (response?.statusCode == 200 && response?.data != null) {
          var categoriesList = response!.data!;
          categoriesList.removeWhere(
            // Remove Speedometer
            (element) => element.catId == '19',
          );
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.success,
              categories: categoriesList,
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
          loading: false,
        ),
      );
    }
  }

  Future<void> getSubCategories(
    String categoryId,
    String categoryName,
  ) async {
    debugPrint(
      'categoryId: $categoryId\ncategoryName: $categoryName',
    );

    Map<String, dynamic> categoryData = {
      'cat_id': categoryId,
    };
    try {
      emit(
        state.copyWith(
          loading: true,
          categoryName: categoryName,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        var response = await _categoriesApi.getSubCategories(
          categoryData: categoryData,
        );

        if (response?.statusCode == 200 && response?.data != null) {
          if (response!.data!.isNotEmpty) {
            emit(
              state.copyWith(
                subCategoriesList: response.data,
              ),
            );
            pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          } else {
            var profession = {
              'cat_id': categoryId,
              'cat_name': categoryName,
            };
            if (professionsList.contains(profession)) {
              DialogUtil.showDialogWithOKButton(
                context,
                message: Res.string.professionAlreadyExists,
              );
            } else {
              if (profileMode) {
                var uploadProfessionResponse =
                    await uploadUserProfession(profession);
                if (uploadProfessionResponse?.statusCode == 200) {
                  professionsList.add(profession);
                  await saveProfessionsToStorage(professionsList);

                  emit(
                    state.copyWith(
                      professions: professionsList,
                    ),
                  );
                  DialogUtil.showDialogWithOKButton(
                    context,
                    message: uploadProfessionResponse?.message ??
                        Res.string.professionAddedSuccessfully,
                  );
                } else {
                  DialogUtil.showDialogWithOKButton(
                    context,
                    isError: true,
                    message: uploadProfessionResponse?.message ??
                        Res.string.apiErrorMessage,
                  );
                }
              } else {
                professionsList.add(profession);
                await saveProfessionsToStorage(professionsList);

                emit(
                  state.copyWith(
                    professions: professionsList,
                  ),
                );
                DialogUtil.showDialogWithOKButton(
                  context,
                  message: Res.string.professionAddedSuccessfully,
                );
              }
            }
            pageController.jumpToPage(0);
          }
          emit(
            state.copyWith(
              apiResponseStatus: ApiResponseStatus.success,
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
          loading: false,
        ),
      );
    }
  }

  Future<void> onSubCategoryClicked(
    SubCategoriesData subCatData,
  ) async {
    debugPrint('${subCatData.toJson()}');
    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        Sub2CategoriesResponse? response =
            await _categoriesApi.getSub2Categories(
          subCategoryData: {
            'cat_id': '${subCatData.categoryId}',
            'sub_id': '${subCatData.subCatId}',
          },
        );
        if (response?.statusCode == 200 && response?.data != null) {
          debugPrint('${response?.data}');
          if (response!.data!.isNotEmpty) {
            emit(
              state.copyWith(
                subCategoryName: subCatData.subCategory,
                sub2CategoriesList: response.data,
              ),
            );
            pageController.animateToPage(
              3,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          } else {
            // var profession = '${state.title}>${subCatData.subCategory}';
            var profession = {
              'cat_id': subCatData.categoryId,
              'cat_name': state.title,
              'sub1_id': subCatData.subCatId,
              'sub1_name': subCatData.subCategory,
            };
            if (professionsList.contains(profession)) {
              DialogUtil.showDialogWithOKButton(
                context,
                message: Res.string.professionAlreadyExists,
              );
            } else {
              if (profileMode) {
                var uploadProfessionResponse =
                    await uploadUserProfession(profession);
                if (uploadProfessionResponse?.statusCode == 200) {
                  professionsList.add(profession);
                  await saveProfessionsToStorage(professionsList);

                  emit(
                    state.copyWith(
                      professions: professionsList,
                    ),
                  );
                  DialogUtil.showDialogWithOKButton(
                    context,
                    message: uploadProfessionResponse?.message ??
                        Res.string.professionAddedSuccessfully,
                  );
                } else {
                  DialogUtil.showDialogWithOKButton(
                    context,
                    isError: true,
                    message: uploadProfessionResponse?.message ??
                        Res.string.apiErrorMessage,
                  );
                }
              } else {
                professionsList.add(profession);
                await saveProfessionsToStorage(professionsList);

                emit(
                  state.copyWith(
                    professions: professionsList,
                  ),
                );
                DialogUtil.showDialogWithOKButton(
                  context,
                  message: Res.string.professionAddedSuccessfully,
                );
              }
            }
            pageController.jumpToPage(0);
          }
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
          loading: false,
        ),
      );
    }
  }

  Future<void> onSub2CategoryClicked(
    Sub2CategoriesData sub2CatData,
  ) async {
    debugPrint('${sub2CatData.toJson()}');

    try {
      emit(
        state.copyWith(
          loading: true,
        ),
      );

      var isConnected = await NetworkService().getConnectivity();
      if (isConnected) {
        Sub3CategoriesResponse? response =
            await _categoriesApi.getSub3Categories(
          sub2CategoryData: {
            'cat_id': '${sub2CatData.catId}',
            'sub_id': '${sub2CatData.subcatId}',
            'sub2_id': '${sub2CatData.id}',
          },
        );
        if (response?.statusCode == 200 && response?.data != null) {
          if (response!.data!.isNotEmpty) {
            emit(
              state.copyWith(
                sub2CategoryName: sub2CatData.subSubCatName,
                sub3CategoriesList: response.data,
              ),
            );
            pageController.animateToPage(
              4,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          } else {
            // var profession = '${state.title}>${sub2CatData.subSubCatName}';
            var profession = {
              'cat_id': sub2CatData.catId,
              'cat_name': state.title.split('>')[0],
              'sub1_id': sub2CatData.subcatId,
              'sub1_name': state.title.split('>')[1],
              'sub2_id': sub2CatData.id,
              'sub2_name': sub2CatData.subSubCatName,
            };
            if (professionsList.contains(profession)) {
              DialogUtil.showDialogWithOKButton(
                context,
                message: Res.string.professionAlreadyExists,
              );
            } else {
              if (profileMode) {
                var uploadProfessionResponse =
                    await uploadUserProfession(profession);
                if (uploadProfessionResponse?.statusCode == 200) {
                  professionsList.add(profession);
                  await saveProfessionsToStorage(professionsList);

                  emit(
                    state.copyWith(
                      professions: professionsList,
                    ),
                  );
                  DialogUtil.showDialogWithOKButton(
                    context,
                    message: uploadProfessionResponse?.message ??
                        Res.string.professionAddedSuccessfully,
                  );
                } else {
                  DialogUtil.showDialogWithOKButton(
                    context,
                    isError: true,
                    message: uploadProfessionResponse?.message ??
                        Res.string.apiErrorMessage,
                  );
                }
              } else {
                professionsList.add(profession);
                await saveProfessionsToStorage(professionsList);

                emit(
                  state.copyWith(
                    professions: professionsList,
                  ),
                );
                DialogUtil.showDialogWithOKButton(
                  context,
                  message: Res.string.professionAddedSuccessfully,
                );
              }
            }
            pageController.jumpToPage(0);
          }
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
          loading: false,
        ),
      );
    }
  }

  Future<void> onSub3CategoryClicked(
    Sub3CategoriesData sub3CatData,
  ) async {
    var profession = {
      'cat_id': sub3CatData.catId,
      'cat_name': state.title.split('>')[0],
      'sub1_id': sub3CatData.subId,
      'sub1_name': state.title.split('>')[1],
      'sub2_id': sub3CatData.subSubId,
      'sub2_name': state.title.split('>')[2],
      'sub3_id': sub3CatData.id,
      'sub3_name': sub3CatData.subSubSubCatName,
    };
    if (professionsList.contains(profession)) {
      DialogUtil.showDialogWithOKButton(
        context,
        message: Res.string.professionAlreadyExists,
      );
    } else {
      if (profileMode) {
        var uploadProfessionResponse = await uploadUserProfession(profession);
        if (uploadProfessionResponse?.statusCode == 200) {
          professionsList.add(profession);
          await saveProfessionsToStorage(professionsList);

          emit(
            state.copyWith(
              professions: professionsList,
            ),
          );
          DialogUtil.showDialogWithOKButton(
            context,
            message: uploadProfessionResponse?.message ??
                Res.string.professionAddedSuccessfully,
          );
        } else {
          DialogUtil.showDialogWithOKButton(
            context,
            isError: true,
            message:
                uploadProfessionResponse?.message ?? Res.string.apiErrorMessage,
          );
        }
      } else {
        professionsList.add(profession);
        await saveProfessionsToStorage(professionsList);

        emit(
          state.copyWith(
            professions: professionsList,
          ),
        );
        DialogUtil.showDialogWithOKButton(
          context,
          message: Res.string.professionAddedSuccessfully,
        );
      }
    }
    pageController.jumpToPage(0);
  }

  Future<StatusMessageResponse?> uploadUserProfession(
    Map<String, dynamic> profession,
  ) async {
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
          var setProfession = await _userApi.setUserProfession(
            userToken: userToken,
            profession: profession,
          );
          debugPrint('setProfession: ${setProfession?.message}');

          statusMessageResponse = setProfession;
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

  void onPageChanged(int page) {
    emit(
      state.copyWith(
        page: page,
      ),
    );
    switch (page) {
      case 0:
        emit(
          state.copyWith(
            title: Res.string.addProfession,
            appBarTitle: Res.string.addProfession,
            categoryName: '',
            subCategoryName: '',
            sub2CategoryName: '',
            sub3CategoryName: '',
          ),
        );
        break;
      case 1:
        emit(
          state.copyWith(
            title: Res.string.chooseMainCategory,
            appBarTitle: Res.string.chooseMainCategory,
            categoryName: '',
            subCategoryName: '',
            sub2CategoryName: '',
            sub3CategoryName: '',
          ),
        );
        break;
      case 2:
        emit(
          state.copyWith(
            subCategoryName: '',
            sub2CategoryName: '',
            sub3CategoryName: '',
          ),
        );
        break;
      case 3:
        emit(
          state.copyWith(
            sub2CategoryName: '',
            sub3CategoryName: '',
          ),
        );
        break;
      default:
        break;
    }

    if (state.sub3CategoryName.isNotEmpty) {
      emit(
        state.copyWith(
          title:
              '${state.categoryName}>${state.subCategoryName}>${state.sub2CategoryName}>${state.sub3CategoryName}',
          appBarTitle: state.sub3CategoryName,
        ),
      );
    } else if (state.sub2CategoryName.isNotEmpty) {
      emit(
        state.copyWith(
          title:
              '${state.categoryName}>${state.subCategoryName}>${state.sub2CategoryName}',
          appBarTitle: state.sub2CategoryName,
        ),
      );
    } else if (state.subCategoryName.isNotEmpty) {
      emit(
        state.copyWith(
          title: '${state.categoryName}>${state.subCategoryName}',
          appBarTitle: state.subCategoryName,
        ),
      );
    } else if (state.categoryName.isNotEmpty) {
      emit(
        state.copyWith(
          title: state.categoryName,
          appBarTitle: state.categoryName,
        ),
      );
    } else {
      emit(
        state.copyWith(
          title: page == 1
              ? Res.string.chooseMainCategory
              : Res.string.addProfession,
          appBarTitle: page == 1
              ? Res.string.chooseMainCategory
              : Res.string.addProfession,
        ),
      );
    }
  }

  void deleteProfession(Map<String, dynamic> item) async {
    await DialogUtil.showDialogWithYesNoButton(
      context,
      yesBtnText: Res.string.delete,
      yesBtnColor: Res.colors.redColor,
      message: Res.string.doYouWantToDeleteProfession,
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
                var response = await _userApi.deleteUserProfession(
                  userToken: userToken,
                  professionId: item['id'],
                );

                if (response?.statusCode == 200) {
                  professionsList.removeWhere(
                    (element) => element == item,
                  );
                  await saveProfessionsToStorage(professionsList);

                  Navigator.pop(context);
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
        } else {
          professionsList.removeWhere(
            (element) => element == item,
          );
          await saveProfessionsToStorage(professionsList);

          Navigator.pop(context);
        }
      },
    );
    emit(
      state.copyWith(
        professions: professionsList,
        loading: false,
      ),
    );
  }

  void back() {
    if (state.page > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> saveProfessionsToStorage(
    List<Map<String, dynamic>> professions,
  ) async {
    await _userStorage.setUserProfessions(professions);
  }
}
