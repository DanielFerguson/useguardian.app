import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guardian/common/text_assets.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as L;
import 'package:permission_handler/permission_handler.dart';

/*
Future<bool?> permissionCheck(_permissionStatus) async {
  if (_permissionStatus == PermissionStatus.granted) {
    return true;
  } else {
    return false;
  }
}*/
/*permissionCheck(context) async {
  PermissionStatus _permissionStatus = await Permission.location.status;
  debugPrint('### $_permissionStatus');
  try {
    if (_permissionStatus != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.location.request();
      // setState(() {
      //   _permissionStatus = permissionStatus;
      // });
      HomePage().pushReplacement(context);

/*
      if (_permissionStatus == PermissionStatus.granted) {
        debugPrint('### Permission Granted');
        // var sharedPref = await SharedPreferences.getInstance();
        // sharedPref.setInt(TextAsset.intro, 1);
        HomePage().pushReplacement(context);
      } else {
        debugPrint('### Status Denied');
        showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text('Location Permission'),
                  content: Text(
                      'This app needs location access to get your current location'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Deny'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      child: Text('Settings'),
                      onPressed: () => openAppSettings(),
                    ),
                  ],
                ));
      }
*/
    } else if (_permissionStatus == PermissionStatus.granted) {
      HomePage().pushReplacement(context);
    } else if (_permissionStatus == PermissionStatus.denied ||
        _permissionStatus == PermissionStatus.restricted ||
        _permissionStatus == PermissionStatus.restricted) {
      PermissionStatus permissionStatus = await Permission.location.request();
      // setState(() {
      //   _permissionStatus = permissionStatus;
      // });
    }
  } catch (e) {
    debugPrint('### Status Denied') ;
  }
}*/

checkLocationPermission(mContext,
    {PermissionStatus? permissionStatus, Function(bool)? callback}) async {
  bool isServiceEnable =
      await Permission.locationWhenInUse.serviceStatus.isEnabled;
  if (isServiceEnable == false) {
    bool _serviceEnabled = await L.Location().requestService();
    if (_serviceEnabled) {
      checkLocationPermission(mContext, callback: callback);
    }
    return;
  }

  PermissionStatus status =
      permissionStatus ?? await Permission.locationAlways.status;
  if (status.isGranted) {
    callback?.call(true);
  } else if (status.isDenied) {
    if (permissionStatus == null) {
      status = await Permission.location.request();
      checkLocationPermission(mContext,
          permissionStatus: status, callback: callback);
      return;
    }
    showDialog(
        context: mContext,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Location Permission'),
              content: Text(
                  'This app needs location access to get your current location.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  child: Text('Permission'),
                  onPressed: () {
                    Navigator.pop(context);
                    checkLocationPermission(mContext, callback: callback);
                  },
                ),
              ],
            ));
  } else if (status.isLimited || status.isRestricted) {
    status = await Permission.location.request();
    checkLocationPermission(mContext,
        permissionStatus: status, callback: callback);
  } else if (status.isPermanentlyDenied) {
    showDialog(
        context: mContext,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Location Permission'),
              content: Text(
                  'This app needs location access to get your current location'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  child: Text('Settings'),
                  onPressed: () {
                    Navigator.pop(context);
                    openAppSettings();
                  },
                ),
              ],
            ));
  }
}

const String FORMAT = "MMMM dd";
const String FORMAT1 = "dd/MM/yyyy";
const String FORMAT2 = "dd";
const String FORMAT3 = "hh:mm";
const String FORMAT4 = "hh:mm a";
const String FORMAT5 = "yyyy-MM-dd hh:mm:s"; //2021-08-07 11:00:00

String changeDateFormat(
    String date, String currentFormat, String requireFormat) {
  DateTime datetime = DateFormat(currentFormat).parse(date);
  return DateFormat(requireFormat).format(datetime);
}

DateTime dateTimeFromString(String date, String currentFormat,{isUTC=false}) {
  return DateFormat(currentFormat).parse(date, isUTC);
}

String stringFromDateTime(DateTime date, String requireFormat) {
  return DateFormat(requireFormat).format(date);
}

String stringFromDateTimeWithTH(DateTime date) {
  var suffix = "th";
  String sDate = stringFromDateTime(date, FORMAT);
  var digit = int.parse(sDate.split(" ")[1]);
  if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
    suffix = ["st", "nd", "rd"][digit - 1];
  }
  return sDate + suffix;
}

///distance in meter
double getLocationDistance(
  lastLat,
  lastLon,
  latitude,
  longitude,
) {
  return Geolocator.distanceBetween(
    lastLat,
    lastLon,
    latitude,
    longitude,
  );
}

DateTime? currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: TextAsset.exit);
    return Future.value(false);
  }
  return Future.value(true);
}
