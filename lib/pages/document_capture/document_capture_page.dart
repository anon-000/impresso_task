import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_anim/config/app_assets.dart';
import 'package:flutter_anim/utils/check_permissions.dart';
import 'package:flutter_anim/widgets/capture_instructions.dart';
import 'package:flutter_anim/widgets/snackbar_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 20/09/23 at 1:04 AM
///

class DocumentCapturePage extends StatefulWidget {
  static const routeName = '/document-capture';

  const DocumentCapturePage({Key? key}) : super(key: key);

  @override
  State<DocumentCapturePage> createState() => _DocumentCapturePageState();
}

class _DocumentCapturePageState extends State<DocumentCapturePage> {
  int currentIIdType = 1;

  CameraController? cameraController;

  late List<CameraDescription> _cameras;
  bool loading = false;
  bool onlyId = true;
  List<Map<String, dynamic>> appBarData = [
    {
      "title": "National ID",
      "asset": AppAssets.nationalId,
    },
    {
      "title": "Driving License",
      "asset": AppAssets.drivingLicense,
    },
    {
      "title": "Passport",
      "asset": AppAssets.passport,
    },
  ];

  @override
  void dispose() {
    super.dispose();
    cameraController!.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentIIdType = Get.arguments['type'];
    onlyId = Get.arguments['onlyId'] ?? true;
    initializeController();
  }

  initializeController() async {
    try {
      final permissionGranted = await CheckPermissions.checkCameraPermission();
      if (!permissionGranted) {
        return;
      }
      _cameras = await availableCameras();
      log("CAMERAs : $_cameras");
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        if (_cameras.isEmpty) {
          SnackBarHelper.show('No camera found.');
        }
      });
      initializeCameraController(_cameras.first);
    } catch (err) {
      SnackBarHelper.show("initializeController: $err");
    }
  }

  Future<void> initializeCameraController(
    CameraDescription cameraDescription,
  ) async {
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // If the controller is updated then update the UI.
    cameraController!.addListener(() {
      setState(() {});
      if (cameraController!.value.hasError) {
        SnackBarHelper.show(
          'Camera error ${cameraController!.value.errorDescription}',
        );
      }
    });

    try {
      await cameraController!.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          SnackBarHelper.show('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          SnackBarHelper.show(
              'Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          SnackBarHelper.show('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          SnackBarHelper.show('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          SnackBarHelper.show(
              'Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          SnackBarHelper.show('Audio access is restricted.');
          break;
        default:
          SnackBarHelper.show("$e");
          break;
      }
    }
    setState(() {});
  }

  clickPhoto() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      SnackBarHelper.show('Error: select a camera first.');
      return;
    }
    if (loading) {
      // A recording is already started, do nothing.
      return;
    }
    try {
      setState(() {
        loading = true;
      });
      final result = await cameraController!.takePicture();
      setState(() {
        loading = false;
      });
      Get.back(result: File(result.path));
    } on CameraException catch (e) {
      setState(() {
        loading = false;
      });
      SnackBarHelper.show("${e.description}");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/back.svg"),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              appBarData[currentIIdType - 1]['asset'],
              color: Colors.white,
              height: 30,
            ),
            const SizedBox(width: 16),
            Text(
              "${appBarData[currentIIdType - 1]['title']}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xff232336),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    width: double.infinity,
                    // margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.black,
                    child: cameraController == null
                        ? const SizedBox()
                        : Center(
                            child: CameraPreview(
                              cameraController!,
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    // onScaleStart: _handleScaleStart,
                                    // onScaleUpdate: _handleScaleUpdate,
                                    // onTapDown: (TapDownDetails details) =>
                                    //     onViewFinderTap(details, constraints),
                                  );
                                },
                              ),
                            ),
                          ),
                  ),
                ),
                if (!onlyId)
                  const Positioned(
                    top: 20,
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(child: CaptureInstructions()),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: SvgPicture.asset(AppAssets.alert),
                ),
                const SizedBox(width: 12),
                const Flexible(
                  child: Text(
                    "Place your camera closer to your ID.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                // Padding(
                //   padding: const EdgeInsets.only(top: 3),
                //   child: SvgPicture.asset(AppAssets.alert),
                // ),
                // const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Important Notes: \nMake sure that the four corners of the ID is visible. There are no reflections on the ID and text is clear.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: clickPhoto,
                      child: SvgPicture.asset(
                        AppAssets.capture,
                        height: 70,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
