import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anim/config/app_page_routes.dart';
import 'package:flutter_anim/pages/verify_home/verify_home_page.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Color(0xff232336),
        statusBarBrightness:
            Brightness.light // Dark == white status bar -- for IOS.,
        ),
  );

  /// Setup for notification services
  // InAppNotification.configureInAppNotification();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // initDynamicLinks();
  }

  // void _goToLink(PendingDynamicLinkData data) {
  //   if (data == null) return;
  //   final Uri deepLink = data.link;
  //   if (deepLink != null) {
  //     switch (deepLink.path) {
  //       case '/profile':
  //         String id = deepLink.queryParameters['id'];
  //         Get.toNamed(OtherProfilePage.routeName, arguments: id);
  //         break;
  //     }
  //   }
  // }
  //
  // Future<void> initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink(

  //       onSuccess: (PendingDynamicLinkData data) async {
  //         _goToLink(data);
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Impresso',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      // theme: AppThemes.appTheme,
      // darkTheme: AppThemes.appTheme,
      // localizationsDelegates: const [
      //   S.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      initialRoute: VerifyHomePage.routeName,
      getPages: AppPages.pages,
    );
  }
}
