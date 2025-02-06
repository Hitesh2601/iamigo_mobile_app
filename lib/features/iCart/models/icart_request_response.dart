class ICartRequestsResponse {
  String? responseMessage;
  int? returnStatus;
  Hardware? hardware;
  Software? software;

  ICartRequestsResponse(
      {this.responseMessage, this.returnStatus, this.hardware, this.software});

  ICartRequestsResponse.fromJson(Map<String, dynamic> json) {
    responseMessage = json['ResponseMessage'];
    returnStatus = json['ReturnStatus'];
    hardware =
        json['Hardware'] != null ? Hardware.fromJson(json['Hardware']) : null;
    software =
        json['Software'] != null ? Software.fromJson(json['Software']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseMessage'] = responseMessage;
    data['ReturnStatus'] = returnStatus;
    if (hardware != null) {
      data['Hardware'] = hardware!.toJson();
    }
    if (software != null) {
      data['Software'] = software!.toJson();
    }
    return data;
  }
}

class Hardware {
  int? endCount;
  List<String>? filteredRequestNo;
  List<NextApproverName>? nextApproverName;
  int? pageNo;
  List<RequestListHardware>? requestListHardware;
  int? startCount;
  int? totalCount;
  HardwareFilter? filter;

  Hardware(
      {this.endCount,
      this.filteredRequestNo,
      this.nextApproverName,
      this.pageNo,
      this.requestListHardware,
      this.startCount,
      this.totalCount,
      this.filter});

  Hardware.fromJson(Map<String, dynamic> json) {
    endCount = json['EndCount'];
    filteredRequestNo = json['FilteredRequestNo'].cast<String>();
    if (json['NextApproverName'] != null) {
      nextApproverName = <NextApproverName>[];
      json['NextApproverName'].forEach((v) {
        nextApproverName!.add(NextApproverName.fromJson(v));
      });
    }
    pageNo = json['PageNo'];
    if (json['RequestListHardware'] != null) {
      requestListHardware = <RequestListHardware>[];
      json['RequestListHardware'].forEach((v) {
        requestListHardware!.add(RequestListHardware.fromJson(v));
      });
    }
    startCount = json['StartCount'];
    totalCount = json['TotalCount'];
    filter =
        json['filter'] != null ? HardwareFilter.fromJson(json['filter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EndCount'] = endCount;
    data['FilteredRequestNo'] = filteredRequestNo;
    if (nextApproverName != null) {
      data['NextApproverName'] =
          nextApproverName!.map((v) => v.toJson()).toList();
    }
    data['PageNo'] = pageNo;
    if (requestListHardware != null) {
      data['RequestListHardware'] =
          requestListHardware!.map((v) => v.toJson()).toList();
    }
    data['StartCount'] = startCount;
    data['TotalCount'] = totalCount;
    if (filter != null) {
      data['filter'] = filter!.toJson();
    }
    return data;
  }
}

class NextApproverName {
  String? approver;

  NextApproverName({this.approver});

  NextApproverName.fromJson(Map<String, dynamic> json) {
    approver = json['Approver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Approver'] = approver;
    return data;
  }
}

class RequestListHardware {
  String? addtionalInfo;
  String? amount;
  String? nextApproverId;
  String? previousApprover;
  String? product;
  String? productSpecification;
  String? requestBy;
  String? requestFor;
  String? requestNo;
  String? requestType;
  List<dynamic>? searchListData;
  int? iCartCid;

  RequestListHardware(
      {this.addtionalInfo,
      this.amount,
      this.nextApproverId,
      this.previousApprover,
      this.product,
      this.productSpecification,
      this.requestBy,
      this.requestFor,
      this.requestNo,
      this.requestType,
      this.searchListData,
      this.iCartCid});

  RequestListHardware.fromJson(Map<String, dynamic> json) {
    addtionalInfo = json['AddtionalInfo'];
    amount = json['Amount'];
    nextApproverId = json['NextApproverId'];
    previousApprover = json['PreviousApprover'];
    product = json['Product'];
    productSpecification = json['ProductSpecification'];
    requestBy = json['RequestBy'];
    requestFor = json['RequestFor'];
    requestNo = json['RequestNo'];
    requestType = json['RequestType'];
    searchListData = json['SearchListData'];
    iCartCid = json['iCartCid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AddtionalInfo'] = addtionalInfo;
    data['Amount'] = amount;
    data['NextApproverId'] = nextApproverId;
    data['PreviousApprover'] = previousApprover;
    data['Product'] = product;
    data['ProductSpecification'] = productSpecification;
    data['RequestBy'] = requestBy;
    data['RequestFor'] = requestFor;
    data['RequestNo'] = requestNo;
    data['RequestType'] = requestType;
    data['SearchListData'] = searchListData;
    data['iCartCid'] = iCartCid;
    return data;
  }
}

class HardwareFilter {
  List<HardwareRequestType>? hardwareRequestType;
  List<Product>? product;
  List<ProductSpecification>? productSpecification;

  HardwareFilter(
      {this.hardwareRequestType, this.product, this.productSpecification});

  HardwareFilter.fromJson(Map<String, dynamic> json) {
    if (json['HardwareRequestType'] != null) {
      hardwareRequestType = <HardwareRequestType>[];
      json['HardwareRequestType'].forEach((v) {
        hardwareRequestType!.add(HardwareRequestType.fromJson(v));
      });
    }
    if (json['Product'] != null) {
      product = <Product>[];
      json['Product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
    if (json['ProductSpecification'] != null) {
      productSpecification = <ProductSpecification>[];
      json['ProductSpecification'].forEach((v) {
        productSpecification!.add(ProductSpecification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hardwareRequestType != null) {
      data['HardwareRequestType'] =
          hardwareRequestType!.map((v) => v.toJson()).toList();
    }
    if (product != null) {
      data['Product'] = product!.map((v) => v.toJson()).toList();
    }
    if (productSpecification != null) {
      data['ProductSpecification'] =
          productSpecification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HardwareRequestType {
  String? type;

  HardwareRequestType({this.type});

  HardwareRequestType.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type'] = type;
    return data;
  }
}

class Product {
  String? productName;

  Product({this.productName});

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['ProductName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductName'] = productName;
    return data;
  }
}

class ProductSpecification {
  String? specification;

  ProductSpecification({this.specification});

  ProductSpecification.fromJson(Map<String, dynamic> json) {
    specification = json['Specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Specification'] = specification;
    return data;
  }
}

class Software {
  int? endCount;
  List<String>? filteredRequestNo;
  int? pageNo;
  List<RequestListSoftware>? requestListSoftware;
  int? startCount;
  int? totalCount;
  SoftwareFilter? filter;

  Software(
      {this.endCount,
      this.filteredRequestNo,
      this.pageNo,
      this.requestListSoftware,
      this.startCount,
      this.totalCount,
      this.filter});

  Software.fromJson(Map<String, dynamic> json) {
    endCount = json['EndCount'];
    filteredRequestNo = json['FilteredRequestNo'].cast<String>();
    pageNo = json['PageNo'];
    if (json['RequestListSoftware'] != null) {
      requestListSoftware = <RequestListSoftware>[];
      json['RequestListSoftware'].forEach((v) {
        requestListSoftware!.add(RequestListSoftware.fromJson(v));
      });
    }
    startCount = json['StartCount'];
    totalCount = json['TotalCount'];
    filter =
        json['filter'] != null ? SoftwareFilter.fromJson(json['filter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EndCount'] = endCount;
    data['FilteredRequestNo'] = filteredRequestNo;
    data['PageNo'] = pageNo;
    if (requestListSoftware != null) {
      data['RequestListSoftware'] =
          requestListSoftware!.map((v) => v.toJson()).toList();
    }
    data['StartCount'] = startCount;
    data['TotalCount'] = totalCount;
    if (filter != null) {
      data['filter'] = filter!.toJson();
    }
    return data;
  }
}

class RequestListSoftware {
  String? acquisitionType;
  String? amount;
  String? nextApproverId;
  String? previousApprover;
  String? requestBy;
  String? requestFor;
  String? requestNo;
  String? requestType;
  String? softwareName;
  String? softwareType;
  String? softwareVersion;
  int? iCartCid;

  RequestListSoftware(
      {this.acquisitionType,
      this.amount,
      this.nextApproverId,
      this.previousApprover,
      this.requestBy,
      this.requestFor,
      this.requestNo,
      this.requestType,
      this.softwareName,
      this.softwareType,
      this.softwareVersion,
      this.iCartCid});

  RequestListSoftware.fromJson(Map<String, dynamic> json) {
    acquisitionType = json['AcquisitionType'];
    amount = json['Amount'];
    nextApproverId = json['NextApproverId'];
    previousApprover = json['PreviousApprover'];
    requestBy = json['RequestBy'];
    requestFor = json['RequestFor'];
    requestNo = json['RequestNo'];
    requestType = json['RequestType'];
    softwareName = json['SoftwareName'];
    softwareType = json['SoftwareType'];
    softwareVersion = json['SoftwareVersion'];
    iCartCid = json['iCartCid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcquisitionType'] = acquisitionType;
    data['Amount'] = amount;
    data['NextApproverId'] = nextApproverId;
    data['PreviousApprover'] = previousApprover;
    data['RequestBy'] = requestBy;
    data['RequestFor'] = requestFor;
    data['RequestNo'] = requestNo;
    data['RequestType'] = requestType;
    data['SoftwareName'] = softwareName;
    data['SoftwareType'] = softwareType;
    data['SoftwareVersion'] = softwareVersion;
    data['iCartCid'] = iCartCid;
    return data;
  }
}

class SoftwareFilter {
  List<SoftwareFilterItem>? software;
  List<SoftwareRequestType>? softwareRequestType;

  SoftwareFilter({this.software, this.softwareRequestType});

  SoftwareFilter.fromJson(Map<String, dynamic> json) {
    if (json['Software'] != null) {
      software = <SoftwareFilterItem>[];
      json['Software'].forEach((v) {
        software!.add(SoftwareFilterItem.fromJson(v));
      });
    }
    if (json['SoftwareRequestType'] != null) {
      softwareRequestType = <SoftwareRequestType>[];
      json['SoftwareRequestType'].forEach((v) {
        softwareRequestType!.add(SoftwareRequestType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (software != null) {
      data['Software'] = software!.map((v) => v.toJson()).toList();
    }
    if (softwareRequestType != null) {
      data['SoftwareRequestType'] =
          softwareRequestType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SoftwareFilterItem {
  String? softName;

  SoftwareFilterItem({this.softName});

  SoftwareFilterItem.fromJson(Map<String, dynamic> json) {
    softName = json['SoftName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SoftName'] = softName;
    return data;
  }
}

class SoftwareRequestType {
  String? softRequestType;

  SoftwareRequestType({this.softRequestType});

  SoftwareRequestType.fromJson(Map<String, dynamic> json) {
    softRequestType = json['SoftRequestType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SoftRequestType'] = softRequestType;
    return data;
  }
}
