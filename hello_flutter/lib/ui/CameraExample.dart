// import 'dart:async';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// class CameraExample extends StatefulWidget {
//   @override
//   _CameraExampleState createState() {
//     return _CameraExampleState();
//   }
// }

// class _CameraExampleState extends State {
//   CameraController controller;
//   List cameras;
//   int selectedCameraIdx;
//   String imagePath;
//   XFile _imagePath;

//   final GlobalKey _scaffoldKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();

//     // Get the list of available cameras.
//     // Then set the first camera as selected.
//     availableCameras().then((availableCameras) {
//       cameras = availableCameras;

//       if (cameras.length > 0) {
//         setState(() {
//           selectedCameraIdx = 0;
//         });

//         _onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
//       }
//     }).catchError((err) {
//       print('Error: $err.code\nError Message: $err.message');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(0.0),
//                 child: Center(
//                   child: _cameraPreviewWidget(),
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 3.0,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 _cameraTogglesRowWidget(),
//                 _captureControlRowWidget(),
//                 _thumbnailWidget(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Display 'Loading' text when the camera is still loading.
//   Widget _cameraPreviewWidget() {
//     if (controller == null || !controller.value.isInitialized) {
//       return const Text(
//         'Loading...',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 20.0,
//           fontWeight: FontWeight.w900,
//         ),
//       );
//     }

//     return AspectRatio(
//       aspectRatio: controller.value.aspectRatio,
//       child: CameraPreview(controller),
//     );
//   }

//   /// Display the thumbnail of the captured image
//   Widget _thumbnailWidget() {
//     return Expanded(
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: imagePath == null
//             ? SizedBox()
//             : SizedBox(
//                 child: Image.file(File(imagePath)),
//                 width: 64.0,
//                 height: 64.0,
//               ),
//       ),
//     );
//   }

//   /// Display the control bar with buttons to take pictures
//   Widget _captureControlRowWidget() {
//     return Expanded(
//       child: Align(
//         alignment: Alignment.center,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.camera_alt),
//               color: Colors.blue,
//               onPressed: controller != null && controller.value.isInitialized
//                   ? _onCapturePressed
//                   : null,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   /// Display a row of toggle to select the camera (or a message if no camera is available).
//   Widget _cameraTogglesRowWidget() {
//     if (cameras == null) {
//       return Row();
//     }

//     CameraDescription selectedCamera = cameras[selectedCameraIdx];
//     CameraLensDirection lensDirection = selectedCamera.lensDirection;

//     return Expanded(
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: FlatButton.icon(
//             onPressed: _onSwitchCamera,
//             icon: Icon(_getCameraLensIcon(lensDirection)),
//             label: Text(
//                 "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
//       ),
//     );
//   }

//   IconData _getCameraLensIcon(CameraLensDirection direction) {
//     switch (direction) {
//       case CameraLensDirection.back:
//         return Icons.camera_rear;
//       case CameraLensDirection.front:
//         return Icons.camera_front;
//       case CameraLensDirection.external:
//         return Icons.camera;
//       default:
//         return Icons.device_unknown;
//     }
//   }

//   Future _onCameraSwitched(CameraDescription cameraDescription) async {
//     if (controller != null) {
//       await controller.dispose();
//     }

//     controller = CameraController(cameraDescription, ResolutionPreset.high);

//     // If the controller is updated then update the UI.
//     controller.addListener(() {
//       if (mounted) {
//         setState(() {});
//       }

//       if (controller.value.hasError) {
//         Fluttertoast.showToast(
//             msg: 'Camera error ${controller.value.errorDescription}',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white);
//       }
//     });

//     try {
//       await controller.initialize();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//     }

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   void _onSwitchCamera() {
//     selectedCameraIdx =
//         selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
//     CameraDescription selectedCamera = cameras[selectedCameraIdx];

//     _onCameraSwitched(selectedCamera);

//     setState(() {
//       selectedCameraIdx = selectedCameraIdx;
//     });
//   }

//   Future _takePicture() async {
//     if (!controller.value.isInitialized) {
//       Fluttertoast.showToast(
//           msg: 'Please wait',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.grey,
//           textColor: Colors.white);

//       return null;
//     }

//     // Do nothing if a capture is on progress
//     if (controller.value.isTakingPicture) {
//       return null;
//     }

//     final Directory appDirectory = await getApplicationDocumentsDirectory();
//     final String pictureDirectory = '${appDirectory.path}/Pictures';
//     await Directory(pictureDirectory).create(recursive: true);
//     final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
//     final String filePath = '$pictureDirectory/${currentTime}.jpg';

//     try {
//       _imagePath = await controller.takePicture();
//       if (_imagePath != null) {
//         Navigator.pop(context, _imagePath.path);
//       }
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//   }

//   void _onCapturePressed() {
//     _takePicture();
//   }

//   void _showCameraException(CameraException e) {
//     String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
//     print(errorText);

//     Fluttertoast.showToast(
//         msg: 'Error: ${e.code}\n${e.description}',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white);
//   }
// }

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CameraExample extends StatefulWidget {
  CameraExample({this.camera});
  final dynamic camera;
  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample>
    with WidgetsBindingObserver {
  CameraController _controller;
  Future<void> _initializeCameraControllerFuture;
  XFile file;
  var isFront = false;
  var isFlash = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeCameraControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _initializeCameraControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () => print('Start Flash'),
                        icon: Icon(Icons.swap_horiz, color: Colors.white),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.blue,
                        child: Center(
                          child: Icon(Icons.camera_alt),
                        ),
                        onPressed: () {
                          _takePicture();
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          if (_controller.value.flashMode == FlashMode.off || _controller.value.flashMode == FlashMode.auto)
                            _setFlashMode(FlashMode.torch);
                          else
                            _setFlashMode(FlashMode.off);
                          setState(() {
                            isFlash = isFlash ? false : true;
                          });
                        },
                        icon: isFlash
                            ? Icon(Icons.flash_on, color: Colors.white)
                            : Icon(Icons.flash_off, color: Colors.white),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized) {
      final snackBar = SnackBar(content: Text('Error: select a camera first'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
    if (_controller.value.isTakingPicture) return null;

    try {
      file = await _controller.takePicture();
      if (file != null) Navigator.pop(context, file.path);
    } on CameraException catch (e) {
      final snackBar =
          SnackBar(content: Text('Error: ${e.code}\n${e.description}'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _setFlashMode(FlashMode mode) async {
    try {
      await _controller.setFlashMode(mode);
    } on CameraException catch (e) {
      final snackBar =
          SnackBar(content: Text('Error: ${e.code}\n${e.description}'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  
}
