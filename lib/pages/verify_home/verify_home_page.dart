import 'package:flutter/material.dart';
import 'package:flutter_anim/config/app_assets.dart';
import 'package:flutter_anim/pages/document_selection/document_selection_page.dart';
import 'package:flutter_anim/widgets/app_primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 20/09/23 at 12:59 AM
///

class VerifyHomePage extends StatefulWidget {
  static const routeName = '/';

  const VerifyHomePage({Key? key}) : super(key: key);

  @override
  State<VerifyHomePage> createState() => _VerifyHomePageState();
}

class _VerifyHomePageState extends State<VerifyHomePage> {
  int idType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/back.svg"),
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xff232336),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    "Verify Me",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    "Select Type of Submitted Document ",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                IDType(
                  title: "National ID",
                  asset: "assets/national_id.svg",
                  selected: idType == 1,
                  onTap: () {
                    setState(() {
                      idType = 1;
                    });
                  },
                ),
                const SizedBox(height: 10),
                IDType(
                  title: "Driver’s License",
                  asset: "assets/dl.svg",
                  selected: idType == 2,
                  onTap: () {
                    setState(() {
                      idType = 2;
                    });
                  },
                ),
                const SizedBox(height: 10),
                IDType(
                  title: "Passport",
                  asset: "assets/passport.svg",
                  selected: idType == 3,
                  onTap: () {
                    setState(() {
                      idType = 3;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppAssets.info),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          "Only an official government issued ID will be accepted.",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppPrimaryButton(
                child: const Text("NEXT"),
                onPressed: () {
                  Get.toNamed(
                    DocumentSelectionPage.routeName,
                    arguments: {
                      "type": idType,
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IDType extends StatelessWidget {
  final String? asset;
  final String? title;
  final bool? selected;
  final VoidCallback? onTap;

  const IDType({
    Key? key,
    this.asset,
    this.onTap,
    this.selected,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SvgPicture.asset(
              asset!,
              color: selected! ? const Color(0xff00EFFE) : Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              "$title",
              style: TextStyle(
                color: selected! ? const Color(0xff00EFFE) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
