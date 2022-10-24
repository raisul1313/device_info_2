class DeviceInfoModel {
  EnvInf? envInf;

  DeviceInfoModel({this.envInf});

  DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    envInf =
    json['env_inf'] != null ? new EnvInf.fromJson(json['env_inf']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.envInf != null) {
      data['env_inf'] = this.envInf!.toJson();
    }
    return data;
  }
}

class EnvInf {
  String? apiVrsn;
  String? appVrsn;
  String? devcInf;
  String? imeiNo;
  String? mobNo;

  EnvInf({this.apiVrsn, this.appVrsn, this.devcInf, this.imeiNo, this.mobNo});

  EnvInf.fromJson(Map<String, dynamic> json) {
    apiVrsn = json['api_vrsn'];
    appVrsn = json['app_vrsn'];
    devcInf = json['devc_inf'];
    imeiNo = json['imei_no'];
    mobNo = json['mob_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_vrsn'] = this.apiVrsn;
    data['app_vrsn'] = this.appVrsn;
    data['devc_inf'] = this.devcInf;
    data['imei_no'] = this.imeiNo;
    data['mob_no'] = this.mobNo;
    return data;
  }
}