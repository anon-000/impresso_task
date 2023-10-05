import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_anim/config/app_assets.dart';
import 'package:flutter_anim/pages/document_capture/document_capture_page.dart';
import 'package:flutter_anim/pages/document_details/document_details_page.dart';
import 'package:flutter_anim/widgets/app_outlined_button.dart';
import 'package:flutter_anim/widgets/app_primary_button.dart';
import 'package:flutter_anim/widgets/photo_chooser.dart';
import 'package:flutter_anim/widgets/validation_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 20/09/23 at 1:05 AM
///

class DocumentSelectionPage extends StatefulWidget {
  static const routeName = '/document-selection';

  const DocumentSelectionPage({Key? key}) : super(key: key);

  @override
  State<DocumentSelectionPage> createState() => _DocumentSelectionPageState();
}

class _DocumentSelectionPageState extends State<DocumentSelectionPage> {
  File? image;
  int currentIIdType = 1;
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
  void initState() {
    super.initState();
    currentIIdType = Get.arguments['type'];
    onlyId = Get.arguments['onlyId'] ?? true;
  }

  choosePhoto() async {
    final res = await Get.toNamed(DocumentCapturePage.routeName, arguments: {
      "type": currentIIdType,
      "onlyId": onlyId,
    });

    log("==>>>$res");

    if (res != null) {
      setState(() {
        image = res;
      });
    }

    // final res = await Get.bottomSheet(
    //   const PhotoChooser(),
    //   backgroundColor: Colors.white,
    // );
    // setState(() {
    //   image = res;
    // });
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
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(2.0),
                margin: const EdgeInsets.all(40.0),
                clipBehavior: Clip.antiAlias,
                height: onlyId ? 180 : 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: image != null
                            ? Image.file(
                                image!,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://www.canada.ca/content/dam/ircc/images/services/canadian-passports/passport-data-page-large.jpg",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: choosePhoto,
                        child: image != null
                            ? const SizedBox()
                            : ColoredBox(
                                color: Colors.black54,
                                child: Center(
                                  child: Text(
                                    onlyId
                                        ? "Tap to Capture your ${appBarData[currentIIdType - 1]['title']}"
                                        : "Tap to Capture Yourself holding your ${appBarData[currentIIdType - 1]['title']}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: SvgPicture.asset(AppAssets.alert),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    onlyId
                        ? "Make sure that the four corners of the ID is visible. There are no reflections on the ID and text is clear."
                        : "Make sure that your face is not blocked by the ID. And your ID is not blocked by your fingers. Your face and your ID face image has to be clearly visible.",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppPrimaryButton(
                onPressed: image == null
                    ? null
                    : () {
                        if (onlyId) {
                          Get.toNamed(
                            DocumentDetailsPage.routeName,
                            arguments: {
                              "type": currentIIdType,
                            },
                          );
                        } else {
                          Get.dialog(ValidationDialog());
                        }
                      },
                child: const Text("Submit"),
              ),
            ),
          ),
          if (image == null) const SizedBox(height: 16),
          if (image != null)
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: AppOutlineButton(
                  onPressed: choosePhoto,
                  child: const Text(
                    "Retake Photo",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
