import 'package:flutter/material.dart';
import 'package:flutter_anim/config/app_assets.dart';
import 'package:flutter_anim/pages/document_capture/document_capture_page.dart';
import 'package:flutter_anim/pages/document_selection/document_selection_page.dart';
import 'package:flutter_anim/widgets/app_primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 20/09/23 at 1:07 AM
///

class DocumentDetailsPage extends StatefulWidget {
  static const routeName = '/document-details';

  const DocumentDetailsPage({Key? key}) : super(key: key);

  @override
  State<DocumentDetailsPage> createState() => _DocumentDetailsPageState();
}

class _DocumentDetailsPageState extends State<DocumentDetailsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Rx<AutovalidateMode> autoValidateMode;
  int currentIIdType = 1;
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
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
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
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode.value,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "First Name",
                        hintStyle: TextStyle(
                          color: Color(0xff979797),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        )),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Last Name",
                        hintStyle: TextStyle(
                          color: Color(0xff979797),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        )),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nationality",
                        hintStyle: TextStyle(
                          color: Color(0xff979797),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        )),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Expiration Date",
                        hintStyle: TextStyle(
                          color: Color(0xff979797),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        )),
                    // decoration: AppDecorations.textFieldDecoration(context)
                    //     .copyWith(
                    //     fillColor: Colors.white,
                    //     filled: true,
                    //     prefixIconConstraints:
                    //     BoxConstraints.tightFor(width: 54),
                    //     hintText: "Enter your name"),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: SvgPicture.asset(AppAssets.alert),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Information must be identical to your passport. If you only have one name please write your complete. name in both the First and Last Name.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppPrimaryButton(
                  onPressed: () {
                    Get.toNamed(
                      DocumentSelectionPage.routeName,
                      arguments: {
                        "type": currentIIdType,
                        "onlyId": false,
                      },
                    );
                  },
                  child: const Text("NEXT"),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
