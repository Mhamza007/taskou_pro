class GetHandymanProfessionsResponse {
  int? statusCode;
  List<GetHandymanProfessionsResponseData>? data;
  String? message;

  GetHandymanProfessionsResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  GetHandymanProfessionsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <GetHandymanProfessionsResponseData>[];
      json['data'].forEach((v) {
        data!.add(GetHandymanProfessionsResponseData.fromJson(v));
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

class GetHandymanProfessionsResponseData {
  String? id;
  String? handymanId;
  String? catId;
  String? sub1Id;
  String? sub2Id;
  String? sub3Id;
  String? createdAt;
  String? updatedAt;
  String? categoryName;
  String? categoryImage;
  String? price;
  String? subCategory;
  String? subCategoryImage;
  String? subCategoryPrice;
  String? subSubCatName;
  String? subSubCatImage;
  String? subSubCatPrice;
  String? subSubSubCatName;
  String? subSubSubCatImage;
  String? subSubSubCatPrice;

  GetHandymanProfessionsResponseData({
    this.id,
    this.handymanId,
    this.catId,
    this.sub1Id,
    this.sub2Id,
    this.sub3Id,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
    this.categoryImage,
    this.price,
    this.subCategory,
    this.subCategoryImage,
    this.subCategoryPrice,
    this.subSubCatName,
    this.subSubCatImage,
    this.subSubCatPrice,
    this.subSubSubCatName,
    this.subSubSubCatImage,
    this.subSubSubCatPrice,
  });

  GetHandymanProfessionsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handymanId = json['handyman_id'];
    catId = json['cat_id'];
    sub1Id = json['sub1_id'];
    sub2Id = json['sub2_id'];
    sub3Id = json['sub3_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    price = json['price'];
    subCategory = json['sub_category'];
    subCategoryImage = json['sub_category_image'];
    subCategoryPrice = json['sub_category_price'];
    subSubCatName = json['sub_sub_cat_name'];
    subSubCatImage = json['sub_sub_cat_image'];
    subSubCatPrice = json['sub_sub_cat_price'];
    subSubSubCatName = json['sub_sub_sub_cat_name'];
    subSubSubCatImage = json['sub_sub_sub_cat_image'];
    subSubSubCatPrice = json['sub_sub_sub_cat_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['handyman_id'] = handymanId;
    data['cat_id'] = catId;
    data['sub1_id'] = sub1Id;
    data['sub2_id'] = sub2Id;
    data['sub3_id'] = sub3Id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['price'] = price;
    data['sub_category'] = subCategory;
    data['sub_category_image'] = subCategoryImage;
    data['sub_category_price'] = subCategoryPrice;
    data['sub_sub_cat_name'] = subSubCatName;
    data['sub_sub_cat_image'] = subSubCatImage;
    data['sub_sub_cat_price'] = subSubCatPrice;
    data['sub_sub_sub_cat_name'] = subSubSubCatName;
    data['sub_sub_sub_cat_image'] = subSubSubCatImage;
    data['sub_sub_sub_cat_price'] = subSubSubCatPrice;
    return data;
  }
}
