class LoginResponse {
  int? statusCode;
  String? message;
  UserLoginData? data;

  LoginResponse({this.statusCode, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? UserLoginData.fromMap(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toMap();
    }
    return data;
  }
}

class UserLoginData {
  String? userId;
  String? profileImg;
  String? userStatus;
  String? isProfession;
  String? isDocuments;
  String? isWork;
  String? userVerified;
  String? userToken;
  String? isAvailable;
  String? firstName;
  String? lastName;
  String? email;
  String? userMobile;
  String? city;
  String? countryCode;
  String? zipCode;
  String? province;
  String? price;
  String? description;
  String? deviceToken;
  String? isSubscribed;
  String? submitForApproval;
  String? isSubmitted;
  int? userOtp;

  UserLoginData({
    this.userId,
    this.profileImg,
    this.userStatus,
    this.isProfession,
    this.isDocuments,
    this.isWork,
    this.userVerified,
    this.userToken,
    this.isAvailable,
    this.firstName,
    this.lastName,
    this.email,
    this.userMobile,
    this.city,
    this.countryCode,
    this.zipCode,
    this.province,
    this.price,
    this.description,
    this.deviceToken,
    this.isSubscribed,
    this.submitForApproval,
    this.isSubmitted,
    this.userOtp,
  });

  UserLoginData.fromMap(Map<String, dynamic> json) {
    userId = json['user_id'];
    profileImg = json['profile_img'];
    userStatus = json['user_status'];
    isProfession = json['is_profession'];
    isDocuments = json['is_documents'];
    isWork = json['is_work'];
    userVerified = json['user_verified'];
    userToken = json['user_token'];
    isAvailable = json['is_available'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    userMobile = json['user_mobile'];
    city = json['city'];
    countryCode = json['country_code'];
    zipCode = json['zip_code'];
    province = json['province'];
    price = json['price'];
    description = json['description'];
    deviceToken = json['device_token'];
    isSubscribed = json['is_subscribed'];
    submitForApproval = json['submit_for_approval'];
    isSubmitted = json['is_submitted'];
    userOtp = json['userOtp'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['profile_img'] = profileImg;
    data['user_status'] = userStatus;
    data['is_profession'] = isProfession;
    data['is_documents'] = isDocuments;
    data['is_work'] = isWork;
    data['user_verified'] = userVerified;
    data['user_token'] = userToken;
    data['is_available'] = isAvailable;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['user_mobile'] = userMobile;
    data['city'] = city;
    data['country_code'] = countryCode;
    data['zip_code'] = zipCode;
    data['province'] = province;
    data['price'] = price;
    data['description'] = description;
    data['device_token'] = deviceToken;
    data['is_subscribed'] = isSubscribed;
    data['submit_for_approval'] = submitForApproval;
    data['is_submitted'] = isSubmitted;
    data['userOtp'] = userOtp;
    return data;
  }
}
