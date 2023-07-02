// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:get_storage/get_storage.dart';

const String USER_BOX = 'user';
const String USER_ID = 'user_id';
const String USER_MOBILE = 'user_mobile';
const String USER_TOKEN = 'user_token';
const String USER_TYPE = 'user_type';
const String USER_FIRST_NAME = 'first_name';
const String USER_LAST_NAME = 'last_name';
const String USER_DEVICE_TOKEN = 'device_token';
const String USER_IS_AVAILABLE = 'is_available';
const String USER_DATA = 'user_data';
const String USER_PROFILE_IMAGE_PATH = 'profile_image_path';
const String USER_PROFESSIONS = 'professions';
const String USER_WORK_PHOTOS = 'work_photos';
const String USER_WORK_VIDEO = 'work_video';
const String USER_WORK_VIDEO_THUMBNAIL = 'work_video_thumbnail';
const String USER_ID_FRONT = 'id_front';
const String USER_ID_BACK = 'id_back';
const String USER_CERTIFICATE_FRONT = 'certificate_front';
const String USER_CERTIFICATE_BACK = 'certificate_back';
const String USER_PRICE_PER_HOUR = 'price_per_hour';

class UserStorage {
  UserStorage() {
    box = GetStorage(USER_BOX);
  }

  GetStorage? box;

  Future<void> setUserId(String? userId) async {
    await box?.write(USER_ID, userId);
  }

  String? getUserId() {
    return box?.read(USER_ID);
  }

  Future<void> setUserMobile(String? userMobile) async {
    await box?.write(USER_MOBILE, userMobile);
  }

  String? getUserMobile() {
    return box?.read(USER_MOBILE);
  }

  Future<void> setUserToken(String? userToken) async {
    await box?.write(USER_TOKEN, userToken);
  }

  String? getUserToken() {
    return box?.read(USER_TOKEN);
  }

  Future<void> setUserType(String? userType) async {
    await box?.write(USER_TYPE, userType);
  }

  String? getUserType() {
    return box?.read(USER_TYPE);
  }

  Future<void> setUserFirstName(String? userFirstName) async {
    await box?.write(USER_FIRST_NAME, userFirstName);
  }

  String? getUserFirstName() {
    return box?.read(USER_FIRST_NAME);
  }

  Future<void> setUserLastName(String? userLastName) async {
    await box?.write(USER_LAST_NAME, userLastName);
  }

  String? getUserLastName() {
    return box?.read(USER_LAST_NAME);
  }

  Future<void> setUserDeviceToken(String? deviceToken) async {
    await box?.write(USER_DEVICE_TOKEN, deviceToken);
  }

  String? getDeviceToken() {
    return box?.read(USER_DEVICE_TOKEN);
  }

  Future<void> setUserIsAvailable(String? isAvailable) async {
    await box?.write(USER_IS_AVAILABLE, isAvailable);
  }

  String? getUserIsAvailable() {
    return box?.read(USER_IS_AVAILABLE);
  }

  Future<void> setUserData(String? userData) async {
    await box?.write(USER_DATA, userData);
  }

  String? getUserData() {
    return box?.read(USER_DATA);
  }

  Future<void> setUserProfileImagePath(String? profileImagePath) async {
    await box?.write(USER_PROFILE_IMAGE_PATH, profileImagePath);
  }

  String? getUserProfileImagePath() {
    return box?.read(USER_PROFILE_IMAGE_PATH);
  }

  Future<void> setUserProfessions(
    List<Map<String, dynamic>>? professions,
  ) async {
    await box?.write(USER_PROFESSIONS, jsonEncode(professions));
  }

  List? getUserProfessions() {
    var professions = box?.read(USER_PROFESSIONS);
    return professions != null ? jsonDecode(professions) : null;
  }

  Future<void> setUserWorkPhotos(List<Map<String, dynamic>>? workPhotos) async {
    await box?.write(USER_WORK_PHOTOS, jsonEncode(workPhotos));
  }

  List? getUserWorkPhotos() {
    var workPhotos = box?.read(USER_WORK_PHOTOS);
    return workPhotos != null ? jsonDecode(workPhotos) : null;
  }

  Future<void> setUserWorkVideo(String? workVideoPath) async {
    await box?.write(USER_WORK_VIDEO, workVideoPath);
  }

  String? getUserWorkVideo() {
    return box?.read(USER_WORK_VIDEO);
  }

  Future<void> setUserWorkVideoThumbnail(String? workVideoThumbnailPath) async {
    await box?.write(USER_WORK_VIDEO_THUMBNAIL, workVideoThumbnailPath);
  }

  String? getUserWorkVideoThumbnail() {
    return box?.read(USER_WORK_VIDEO_THUMBNAIL);
  }

  Future<void> setUserIdFront(String? idFront) async {
    await box?.write(USER_ID_FRONT, idFront);
  }

  String? getUserIdFront() {
    return box?.read(USER_ID_FRONT);
  }

  Future<void> setUserIdBack(String? idBack) async {
    await box?.write(USER_ID_BACK, idBack);
  }

  String? getUserIdBack() {
    return box?.read(USER_ID_BACK);
  }

  Future<void> setUserCertificateFront(String? certificateFront) async {
    await box?.write(USER_CERTIFICATE_FRONT, certificateFront);
  }

  String? getUserCertificateFront() {
    return box?.read(USER_CERTIFICATE_FRONT);
  }

  Future<void> setUserCertificateBack(String? certificateBack) async {
    await box?.write(USER_CERTIFICATE_BACK, certificateBack);
  }

  String? getUserCertificateBack() {
    return box?.read(USER_CERTIFICATE_BACK);
  }

  Future<void> setUserPricePerHour(String? pricePerHour) async {
    await box?.write(USER_PRICE_PER_HOUR, pricePerHour);
  }

  String? getUserPricePerHour() {
    return box?.read(USER_PRICE_PER_HOUR);
  }
}
