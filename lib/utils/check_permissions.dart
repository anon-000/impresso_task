///
/// Created by Auro on 24/09/23 at 1:50 AM
///

// import 'package:geolocation/geolocation.dart';

// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

import 'dart:developer';
import 'dart:io';

import 'package:flutter_anim/widgets/snackbar_helper.dart';
import 'package:device_info/device_info.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermissions {
  static Future<bool> checkCameraPermission() async {
    if (Platform.isAndroid) {
      log("CHECKING FOR PERMISSIONS IN ANDROID");
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      Map<Permission, PermissionStatus> statues = await [
        Permission.camera,
        androidInfo.version.sdkInt <= 32
            ? Permission.storage
            : Permission.photos
      ].request();
      PermissionStatus? statusCamera = statues[Permission.camera];

      PermissionStatus? statusPhotos = statues[androidInfo.version.sdkInt <= 32
          ? Permission.storage
          : Permission.photos];
      bool isGranted = statusCamera == PermissionStatus.granted &&
          statusPhotos == PermissionStatus.granted;
      if (isGranted) {
        return true;
      }
      bool isPermanentlyDenied =
          statusCamera == PermissionStatus.permanentlyDenied ||
              statusPhotos == PermissionStatus.permanentlyDenied;
      if (isPermanentlyDenied) {
        openAppSettings();
        return false;
      }
    } else {
      Map<Permission, PermissionStatus> statues = await [
        Permission.camera,
        Permission.storage,
        Permission.photos
      ].request();
      PermissionStatus? statusCamera = statues[Permission.camera];
      PermissionStatus? statusStorage = statues[Permission.storage];
      PermissionStatus? statusPhotos = statues[Permission.photos];
      bool isGranted = statusCamera == PermissionStatus.granted &&
          statusStorage == PermissionStatus.granted &&
          statusPhotos == PermissionStatus.granted;
      if (isGranted) {
        return true;
      }
      bool isPermanentlyDenied =
          statusCamera == PermissionStatus.permanentlyDenied ||
              statusStorage == PermissionStatus.permanentlyDenied ||
              statusPhotos == PermissionStatus.permanentlyDenied;
      if (isPermanentlyDenied) {
        log("PERMANENTLY DENIED");
        openAppSettings();
        return false;
      }
    }
    return false;
  }

  static Future<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isRestricted) {
      // Permissions are denied or restricted, show an error message or prompt the user to enable permissions in settings.
      SnackBarHelper.show("Some error occurred while granting permissions.");
      return false;
    } else if (status.isPermanentlyDenied) {
      // Permissions are permanently denied, show an error message or prompt the user to enable permissions in settings.
      SnackBarHelper.show(
          "Camera permission permanently denied. Change from settings");
      openAppSettings();
      return false;
    } else {
      SnackBarHelper.show("Some error occurred while granting permissions.");
      return false;
    }
  }
// static Future requestGpsService() async {
//   try {
//     GeolocationResult result = await Geolocation.enableLocationServices();
//     if (result == null || !result.isSuccessful) {
//       throw 'Please Enable GPS to continue';
//     }
//   } catch (e) {
//     throw 'Please Enable GPS to continue';
//   }
// }

// static Future<l.LocationData> requestLocation() async {
//   if (Platform.isIOS) {
//     final GeolocationResult result =
//         await Geolocation.requestLocationPermission(
//       permission: LocationPermission(
//         ios: LocationPermissionIOS.always,
//       ),
//       openSettingsIfDenied: true,
//     );
//     if (result.isSuccessful) {
//       return getLocation();
//     } else {
//       switch (result.error.type) {
//         case GeolocationResultErrorType.serviceDisabled:
//           throw 'Please Enable GPS to continue';
//         case GeolocationResultErrorType.locationNotFound:
//           throw 'Unable to get your location';
//         case GeolocationResultErrorType.permissionDenied:
//           throw 'Please Allow Location permission to continue';
//         case GeolocationResultErrorType.playServicesUnavailable:
//           throw 'Install play services in your phone to continue';
//         case GeolocationResultErrorType.permissionNotGranted:
//           throw 'Please Allow Location permission to continue';
//         default:
//           throw 'Please Allow Location permission to continue';
//       }
//     }
//   } else {
//   var result = await Permission.location.request();
//   if (result.isGranted) {
//     await requestGpsService();
//     return getLocation();
//   }
//   if (result.isDenied) {
//     throw 'Please Allow Location permission to continue';
//   }
//   if (result.isPermanentlyDenied) {
//     throw 'Please Allow Location permission in app settings to continue';
//     // AppSettings.openAppSettings();
//   }
//   }
//   throw 'Please Allow Location permission to continue';
// }

// static Future<l.LocationData> getLocation() async {
//   l.Location location = l.Location();
//   var loc = await location.getLocation().timeout(Duration(seconds: 10),
//       onTimeout: () {
//     throw 'Unable to fetch your location';
//   });
//   return loc;
// }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
//   static Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }
//
//   static Future<bool> storagePermission() async {
//     var status = await Permission.storage.status;
//     if (status.isGranted) {
//       return true;
//     } else if (status.isDenied || status.isPermanentlyDenied) {
//       var result = await Permission.storage.request();
//       if (result.isDenied) {
//         return false;
//       } else {
//         return true;
//       }
//     } else {
//       return false;
//     }
//   }
}
