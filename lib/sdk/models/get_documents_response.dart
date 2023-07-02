class GetDocumentsResponse {
  int? statusCode;
  GetDocumentsResponseData? data;
  String? message;

  GetDocumentsResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  GetDocumentsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null
        ? GetDocumentsResponseData.fromJson(json['data'])
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

class GetDocumentsResponseData {
  String? userId;
  String? idFront;
  String? idBack;
  String? certFront;
  String? certBack;

  GetDocumentsResponseData({
    this.userId,
    this.idFront,
    this.idBack,
    this.certFront,
    this.certBack,
  });

  GetDocumentsResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    idFront = json['id_front'];
    idBack = json['id_back'];
    certFront = json['cert_front'];
    certBack = json['cert_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['id_front'] = idFront;
    data['id_back'] = idBack;
    data['cert_front'] = certFront;
    data['cert_back'] = certBack;
    return data;
  }
}
