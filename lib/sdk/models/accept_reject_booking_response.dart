class AcceptRejectBookingResponse {
  int? statusCode;
  AcceptRejectBookingResponseData? data;
  String? message;

  AcceptRejectBookingResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  AcceptRejectBookingResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null
        ? AcceptRejectBookingResponseData.fromJson(json['data'])
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

class AcceptRejectBookingResponseData {
  String? notificationBy;
  String? notificationTo;
  String? notificationMessage;
  String? notificationImg;
  String? notificationType;
  int? createdOn;
  String? bookingId;

  AcceptRejectBookingResponseData({
    this.notificationBy,
    this.notificationTo,
    this.notificationMessage,
    this.notificationImg,
    this.notificationType,
    this.createdOn,
    this.bookingId,
  });

  AcceptRejectBookingResponseData.fromJson(Map<String, dynamic> json) {
    notificationBy = json['notification_by'];
    notificationTo = json['notification_to'];
    notificationMessage = json['notification_message'];
    notificationImg = json['notification_img'];
    notificationType = json['notification_type'];
    createdOn = json['created_on'];
    bookingId = json['Booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_by'] = notificationBy;
    data['notification_to'] = notificationTo;
    data['notification_message'] = notificationMessage;
    data['notification_img'] = notificationImg;
    data['notification_type'] = notificationType;
    data['created_on'] = createdOn;
    data['Booking_id'] = bookingId;
    return data;
  }
}
