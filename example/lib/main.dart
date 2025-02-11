import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rekognition_face_liveness/face_liveness_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _getPermissions();
  }

  void _getPermissions() async {
    await Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example appppp'),
        ),
        body: FaceLivenessDetector(
          sessionId: '32624a7f-e7fe-4355-85cf-2eccd049f746',
          region: 'us-east-1',
          onComplete: () {
            print('VINI: complete');
          },
          onError: () {
            print('VINI: error');
          },
        ),
      ),
    );
  }
}
