import '../../../models/responseModel.dart';

class ActivePackage {
  Null? customerPackagesDto;
  List<CustomerPackagesDtoList>? customerPackagesDtoList;
  ResponseDto? responseDto;
  bool? valid;

  ActivePackage(
      {this.customerPackagesDto,
        this.customerPackagesDtoList,
        this.responseDto,
        this.valid});

  ActivePackage.fromJson(Map<String, dynamic> json) {
    customerPackagesDto = json['customerPackagesDto'];
    if (json['customerPackagesDtoList'] != null) {
      customerPackagesDtoList = <CustomerPackagesDtoList>[];
      json['customerPackagesDtoList'].forEach((v) {
        customerPackagesDtoList!.add(new CustomerPackagesDtoList.fromJson(v));
      });
    }
    responseDto = json['responseDto'] != null
        ? new ResponseDto.fromJson(json['responseDto'])
        : null;
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerPackagesDto'] = this.customerPackagesDto;
    if (this.customerPackagesDtoList != null) {
      data['customerPackagesDtoList'] =
          this.customerPackagesDtoList!.map((v) => v.toJson()).toList();
    }
    if (this.responseDto != null) {
      data['responseDto'] = this.responseDto!.toJson();
    }
    data['valid'] = this.valid;
    return data;
  }
}

class CustomerPackagesDtoList {
  int? id;
  int? packageId;
  String? userId;
  String? name;
  int? amount;
  String? startDate;
  String? endDate;
  String? type;
  String? status;
  int? duration;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  Null? modifiedAt;

  CustomerPackagesDtoList(
      {this.id,
        this.packageId,
        this.userId,
        this.name,
        this.amount,
        this.startDate,
        this.endDate,
        this.type,
        this.status,
        this.duration,
        this.createdBy,
        this.createdAt,
        this.modifiedBy,
        this.modifiedAt});

  CustomerPackagesDtoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['packageId'];
    userId = json['userId'];
    name = json['name'];
    amount = json['amount'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    type = json['type'];
    status = json['status'];
    duration = json['duration'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['packageId'] = this.packageId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['type'] = this.type;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}