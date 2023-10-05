import 'package:flutter_anim/pages/document_capture/document_capture_page.dart';
import 'package:flutter_anim/pages/document_details/document_details_page.dart';
import 'package:flutter_anim/pages/document_selection/document_selection_page.dart';
import 'package:flutter_anim/pages/verify_home/verify_home_page.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 20/09/23 at 1:40 AM
///

class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: VerifyHomePage.routeName, page: () => const VerifyHomePage()),
    GetPage(
        name: DocumentSelectionPage.routeName,
        page: () => const DocumentSelectionPage()),
    GetPage(
        name: DocumentDetailsPage.routeName,
        page: () => const DocumentDetailsPage()),
    GetPage(
        name: DocumentCapturePage.routeName,
        page: () => const DocumentCapturePage()),
  ];
}
