import 'dart:convert';
import 'package:device_info_2/device_info_provider.dart';
import 'package:device_info_2/device_info_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DeviceInformation(),
    );
  }
}

class DeviceInformation extends StatefulWidget {
  const DeviceInformation({Key? key}) : super(key: key);

  @override
  State<DeviceInformation> createState() => _DeviceInformationState();
}

class _DeviceInformationState extends State<DeviceInformation> {
  late String deviceID;
  late String encoded;
  late String decoded;
  final String apiVersion = "1.2.2";
  final String appVersion = "1.12";
  final String mobileNo = "NF";
  late EnvInf envInf;
  late DeviceInfoModel deviceInfoModel;

  @override
  void initState() {
    deviceID = '';
    encoded = '';
    decoded = '';
    envInf = EnvInf();
    deviceInfoModel = DeviceInfoModel();
    init();
    super.initState();
  }

  Future init() async {
    final deviceID = await DeviceInfo.getDeviceID();
    final deviceManufacturer = await DeviceInfo.getDeviceManufacturerInfo();
    final deviceBrand = await DeviceInfo.getDeviceBrandInfo();
    final deviceModel = await DeviceInfo.getDeviceModelInfo();
    final deviceApiVersion = await DeviceInfo.getDeviceAPiInfo();
    setState(() {
      String deviceInfo =
          "$deviceBrand\$$deviceApiVersion\$$deviceModel\$$deviceManufacturer";

      envInf.apiVrsn = apiVersion;
      envInf.appVrsn = appVersion;
      envInf.imeiNo = deviceID;
      envInf.mobNo = mobileNo;
      envInf.devcInf = deviceInfo;

      deviceInfoModel = DeviceInfoModel(envInf: envInf);

      String credentials = json.encode(deviceInfoModel);
      print(credentials);
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      encoded = stringToBase64.encode(credentials);
      decoded = stringToBase64.decode(encoded);
      //print(encoded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Encrypt: $encoded'),
              SizedBox(
                height: 12,
              ),
              Text('Decrypt: $decoded'),
            ],
          ),
        ),
      ),
    );
  }
}
