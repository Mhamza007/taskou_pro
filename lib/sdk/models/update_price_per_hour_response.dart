class UpdatePricePerHourResponse {
  int? statusCode;
  UpdatePricePerHourResponseData? data;
  String? message;

  UpdatePricePerHourResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  UpdatePricePerHourResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null
        ? UpdatePricePerHourResponseData.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class UpdatePricePerHourResponseData {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? city;
  String? userMobile;
  String? userOtp;
  String? userPassword;
  String? countryCode;
  String? zipCode;
  String? province;
  String? profileImg;
  String? description;
  String? deviceToken;
  String? userToken;
  String? price;
  String? userType;
  String? isUpdated;
  dynamic socialId;
  String? userVerified;
  String? userStatus;
  String? submitForApproval;
  String? isUpload;
  dynamic isSocial;
  String? isProfession;
  String? isDocuments;
  String? isSubmitted;
  String? isWork;
  String? isAvailable;
  String? idFront;
  String? idBack;
  String? certFront;
  String? certBack;
  String? createdOn;
  dynamic updatedOn;

  UpdatePricePerHourResponseData({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.city,
    this.userMobile,
    this.userOtp,
    this.userPassword,
    this.countryCode,
    this.zipCode,
    this.province,
    this.profileImg,
    this.description,
    this.deviceToken,
    this.userToken,
    this.price,
    this.userType,
    this.isUpdated,
    this.socialId,
    this.userVerified,
    this.userStatus,
    this.submitForApproval,
    this.isUpload,
    this.isSocial,
    this.isProfession,
    this.isDocuments,
    this.isSubmitted,
    this.isWork,
    this.isAvailable,
    this.idFront,
    this.idBack,
    this.certFront,
    this.certBack,
    this.createdOn,
    this.updatedOn,
  });

  UpdatePricePerHourResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    city = json['city'];
    userMobile = json['user_mobile'];
    userOtp = json['user_otp'];
    userPassword = json['user_password'];
    countryCode = json['country_code'];
    zipCode = json['zip_code'];
    province = json['province'];
    profileImg = json['profile_img'];
    description = json['description'];
    deviceToken = json['device_token'];
    userToken = json['user_token'];
    price = json['price'];
    userType = json['user_type'];
    isUpdated = json['is_updated'];
    socialId = json['social_id'];
    userVerified = json['user_verified'];
    userStatus = json['user_status'];
    submitForApproval = json['submit_for_approval'];
    isUpload = json['is_upload'];
    isSocial = json['is_social'];
    isProfession = json['is_profession'];
    isDocuments = json['is_documents'];
    isSubmitted = json['is_submitted'];
    isWork = json['is_work'];
    isAvailable = json['is_available'];
    idFront = json['id_front'];
    idBack = json['id_back'];
    certFront = json['cert_front'];
    certBack = json['cert_back'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['city'] = city;
    data['user_mobile'] = userMobile;
    data['user_otp'] = userOtp;
    data['user_password'] = userPassword;
    data['country_code'] = countryCode;
    data['zip_code'] = zipCode;
    data['province'] = province;
    data['profile_img'] = profileImg;
    data['description'] = description;
    data['device_token'] = deviceToken;
    data['user_token'] = userToken;
    data['price'] = price;
    data['user_type'] = userType;
    data['is_updated'] = isUpdated;
    data['social_id'] = socialId;
    data['user_verified'] = userVerified;
    data['user_status'] = userStatus;
    data['submit_for_approval'] = submitForApproval;
    data['is_upload'] = isUpload;
    data['is_social'] = isSocial;
    data['is_profession'] = isProfession;
    data['is_documents'] = isDocuments;
    data['is_submitted'] = isSubmitted;
    data['is_work'] = isWork;
    data['is_available'] = isAvailable;
    data['id_front'] = idFront;
    data['id_back'] = idBack;
    data['cert_front'] = certFront;
    data['cert_back'] = certBack;
    data['created_on'] = createdOn;
    data['updated_on'] = updatedOn;
    return data;
  }
}
