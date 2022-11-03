import 'dart:convert';
import 'package:device_info_2/device_info_provider.dart';
import 'package:device_info_2/device_info_model.dart';
import 'package:device_info_2/encryption.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'aes_encrypt_decrypt.dart';

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
      home: const Encryption(),
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
  late String refID;
  late String dateTimeValue;
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
    refID = '';
    dateTimeValue = '';
    envInf = EnvInf();
    deviceInfoModel = DeviceInfoModel();
    init();
    randomIDGenerator();
    dateTime();
    encrypt();
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
      //print(credentials);
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      encoded = stringToBase64.encode(credentials);
      decoded = stringToBase64.decode(encoded);
      //print(encoded);
    });
  }

  randomIDGenerator() {
    var uuid = Uuid();
    String input = uuid.v1().toUpperCase();
    refID = input.replaceAll('-', '');
    int len = refID.length;
    String v = '085810BA117E4B46A058153D9D03CB0D';
    int len2 = v.length;
    //print(len2);
    //print(refID);
    //print(len);
  }

  dateTime() {
    var dateTime = DateTime.now();
    var val = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(dateTime);
    var offset = dateTime.timeZoneOffset;
    var hours =
        offset.inHours > 0 ? offset.inHours : 1; // For fixing divide by 0

    if (!offset.isNegative) {
      val = val +
          "+" +
          offset.inHours.toString().padLeft(2, '0') +
          ":" +
          (offset.inMinutes % (hours * 60)).toString().padLeft(2, '0');
    } else {
      val = val +
          "-" +
          (-offset.inHours).toString().padLeft(2, '0') +
          ":" +
          (offset.inMinutes % (hours * 60)).toString().padLeft(2, '0');
    }
    dateTimeValue = val;
    //print(val);
  }

  Future<dynamic> encrypt() async {

    String data =
        await DefaultAssetBundle.of(context).loadString("asset/headers.json");

    final encryptedText = AESEncryptionDecryption.encryptAES(data);
    final decryptedText = AESEncryptionDecryption.decryptAES(encryptedText);
    return encryptedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Encrypt: $encoded'),
              SizedBox(
                height: 12,
              ),
              Text('Decrypt: $decoded'),
              SizedBox(
                height: 12,
              ),
              Text(
                'Ref ID: $refID',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'Date Time: $dateTimeValue',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
