import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:eat_bestly/camera/camerascreen.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  runApp(
    const MyCameraApp());
}

class MyCameraApp extends StatelessWidget {
  const MyCameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CameraApp(),
    );
  }
}

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraApppState();
}

class _CameraApppState extends State<CameraApp> {

   CameraController? _controller;

  @override
  initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            debugPrint('access was denied');
            break;
          default:
            debugPrint(e.description);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // now let start implementing our camera
      body: Stack(children: [
        Container(
          height: double.infinity,
          child: CameraPreview(_controller!),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: MaterialButton(
                  onPressed: () async {
                    if (!_controller!.value.isInitialized) {
                      return null;
                    }
                    if (_controller!.value.isTakingPicture) {
                      return null;
                    }
                    try {
                      await _controller!.setFlashMode(FlashMode.auto);
                      XFile file = await _controller!.takePicture();
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>ImagePreview(file)));
                    } on CameraException catch (e) {
                      debugPrint("Error occured while tacking picture:$e");
                      return null;
                    }
                  },
                  color: Colors.white,
                  child: const Text('Take a picture'),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
