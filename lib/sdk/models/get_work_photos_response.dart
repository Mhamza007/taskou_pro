class GetWorkPhotosResponse {
  int? statusCode;
  List<GetWorkPhotosResponseData>? data;
  String? message;

  GetWorkPhotosResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  GetWorkPhotosResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <GetWorkPhotosResponseData>[];
      json['data'].forEach((v) {
        data!.add(GetWorkPhotosResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class GetWorkPhotosResponseData {
  String? id;
  String? handymanId;
  String? image;
  String? createdAt;
  String? updatedAt;

  GetWorkPhotosResponseData({
    this.id,
    this.handymanId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  GetWorkPhotosResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handymanId = json['handyman_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['handyman_id'] = handymanId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
