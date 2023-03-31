import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:verify_plugin/verify_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _realPlugin = VerifyPlugin();

  List<int> encryptResult = [];
  String filePath = "";

  @override
  void initState() {
    super.initState();
    _realPlugin.setMethodCallHandler(onInvoke);
  }

  Future onInvoke(MethodCall call) async {
    if (call.method == "detectionResult") {
      var arguments = call.arguments as Map<dynamic, dynamic>;
      var status = arguments["status"];
      //校验信息
      encryptResult = arguments["encryptResult"];
      // var  detectionStatus = arguments["detectionStatus"];
      //Image
      filePath = arguments["file"];
      //1 success
      if (status == 1) {
        //success
        setState(() {});
      }
    }
  }

  Future onPress() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      _realPlugin.detection(false);
      return;
    }

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
    if (statuses[Permission.camera] == PermissionStatus.granted) {
      _realPlugin.detection(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(onPressed: onPress, child: Text("点击校验")),
              Text("filePath:${filePath}"),
              getImage(),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: Text("encryptResult:${encryptResult}"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImage() {
    if (filePath == null || filePath.isEmpty) {
      return Container();
    }
    return Image.file(
      File(filePath),
      width: 100,
      height: 100,
    );
  }
}
