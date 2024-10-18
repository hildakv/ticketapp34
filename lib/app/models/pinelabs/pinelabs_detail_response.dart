class PineLabsDetailResponse {
  Response? response;
  Header? header;

  PineLabsDetailResponse({this.response, this.header});

  PineLabsDetailResponse.fromJson(Map<String, dynamic> json) {
    response = json['Response'] != null
        ? new Response.fromJson(json['Response'])
        : null;
    header =
        json['Header'] != null ? new Header.fromJson(json['Header']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response!.toJson();
    }
    if (this.header != null) {
      data['Header'] = this.header!.toJson();
    }
    return data;
  }
}

class Response {
  int? responseCode;
  String? responseMsg;
  String? parameterJson;
  String? appVersion;

  Response(
      {this.responseCode,
      this.responseMsg,
      this.parameterJson,
      this.appVersion});

  Response.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseMsg = json['ResponseMsg'];
    parameterJson = json['ParameterJson'];
    appVersion = json['AppVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['ResponseMsg'] = this.responseMsg;
    data['ParameterJson'] = this.parameterJson;
    data['AppVersion'] = this.appVersion;
    return data;
  }
}

class Header {
  String? userId;
  String? methodId;
  String? applicationId;
  String? versionNo;

  Header({this.userId, this.methodId, this.applicationId, this.versionNo});

  Header.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    methodId = json['MethodId'];
    applicationId = json['ApplicationId'];
    versionNo = json['VersionNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['MethodId'] = this.methodId;
    data['ApplicationId'] = this.applicationId;
    data['VersionNo'] = this.versionNo;
    return data;
  }
}
