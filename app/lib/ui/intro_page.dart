import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guardian/common/color_assets.dart';
import 'package:guardian/common/common_ext.dart';
import 'package:guardian/common/common_methos.dart';
import 'package:guardian/common/common_methos_ios.dart';
import 'package:guardian/common/common_widget.dart';
import 'package:guardian/common/image_assets.dart';
import 'package:guardian/common/pref_keys.dart';
import 'package:guardian/common/text_assets.dart';
import 'package:guardian/di/injection_container.dart';
import 'package:guardian/ui/home_page.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var _pref = sl<SharedPreferences>();
  late PermissionStatus permission;
  late ServiceStatus serviceStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); // 1
    return Scaffold(
      backgroundColor: AppColor.appBg,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: SafeArea(
          child: Hero(
            tag: 'button',
            child: commonButton(
              () {
                if (Platform.isIOS) {
                  checkLocationPermissionIOS(context, callback: (allow) {
                    if (allow == true) {
                      Navigator.pop(context);
                      _pref.setBool(PrefKeys.isIntroDone, true);
                      HomePage().push(context);
                    }
                  });
                } else
                  checkLocationPermission(context, callback: (allow) {
                    if (allow == true) {
                      Navigator.pop(context);
                      _pref.setBool(PrefKeys.isIntroDone, true);
                      HomePage().push(context);
                    }
                  });
              },
              'Get Started',
              16.0,
              Colors.white,
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Hero(
                      tag: 'shield',
                      child: Image.asset(
                        ImageAsset.guardianLogo,
                        height: 140,
                        width: 140,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        border: Border.all(
                          color: Color(0xFFF0F0F0),
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.only(
                        top: 15.0,
                        bottom: 15.0,
                        right: 15.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              ImageAsset.shieldGreen,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTextNoHeight(
                                  TextAsset.privacy,
                                  AppColor.buttonBg,
                                  18.0,
                                  weight: FontWeight.w600,
                                ),
                                commonText(
                                  TextAsset.privacyDesc,
                                  AppColor.textGrey,
                                  14.0,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF0F0F0),
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.only(
                        top: 20.0,
                        bottom: 20.0,
                        right: 15.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: SvgPicture.asset(
                              ImageAsset.locationPermission,
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTextNoHeight(
                                  TextAsset.location,
                                  AppColor.buttonBg,
                                  18.0,
                                  weight: FontWeight.w600,
                                ),
                                commonText(
                                  TextAsset.locationDesc,
                                  AppColor.textGrey,
                                  14.0,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
