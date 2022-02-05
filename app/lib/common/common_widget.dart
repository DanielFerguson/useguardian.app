import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guardian/common/common_ext.dart';
import 'package:guardian/floating/circular_menu.dart';
import 'package:guardian/floating/circular_menu_item.dart';
import 'package:guardian/main.dart';
import 'package:guardian/ui/home_page.dart';
import 'package:guardian/ui/settings_page.dart';
import 'package:guardian/ui/support_page.dart';

import 'color_assets.dart';
import 'image_assets.dart';

Widget commonButton(onPressed, String text, textSize, textColor) {
  return Container(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
          backgroundColor: MaterialStateProperty.all(AppColor.buttonBg),
          padding:
              MaterialStateProperty.all(EdgeInsets.only(top: 18, bottom: 18)),
          textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: textSize, color: Colors.white))),
      onPressed: onPressed,
      child: Text(text),
    ),
  );
}

Widget commonButtonWithIcon(onPressed, String text, textSize, textColor,
    {stringIcon}) {
  return Container(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.red),
        padding:
            MaterialStateProperty.all(EdgeInsets.only(top: 18, bottom: 18)),
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: textSize, color: Colors.white),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: stringIcon == null ? false : true,
            child: Row(
              children: [
                SvgPicture.asset(ImageAsset.icDelete),
                SizedBox(
                  width: 13,
                ),
                Text(text),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget commonText(text, color, size, {weight = FontWeight.normal}) {
  return Text(
    text,
    style:
        TextStyle(height: 2, color: color, fontSize: size, fontWeight: weight),
  );
}

Widget commonTextNoHeight(text, color, size,
    {weight = FontWeight.normal, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      text,
      // maxLines: 2,
      softWrap: true,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
      // overflow: TextOverflow.ellipsis,
    ),
  );
}

enum CurrentScreen { HOME, SETTINGS, SUPPORT, NAN }

Widget floatingButton(BuildContext context,
    {CurrentScreen currentScreen = CurrentScreen.NAN}) {
  var key = GlobalKey<CircularMenuState>();
  return CircularMenu(
    toggleButtonSize: 30.0,
    alignment: Alignment.bottomRight,
    key: key,
    toggleButtonColor: AppColor.buttonBg,
    items: [
      CircularMenuItem(
        icon: Icons.settings,
        color: AppColor.fabBgGrey,
        iconColor: AppColor.buttonBg,
        onTap: () {
          if (currentScreen != CurrentScreen.SETTINGS) {
            SettingsPage().pushReplacement(context);
          } else {
            key.currentState?.reverseAnimation();
          }
        },
      ),
      CircularMenuItem(
        icon: Icons.info,
        iconColor: AppColor.buttonBg,
        color: AppColor.fabBgGrey,
        onTap: () {
          if (currentScreen != CurrentScreen.SUPPORT) {
            SupportPage().pushReplacement(context);
          } else {
            key.currentState?.reverseAnimation();
          }
        },
      ),
      CircularMenuItem(
          icon: Icons.home_filled,
          color: AppColor.fabBgGrey,
          iconColor: AppColor.buttonBg,
          onTap: () {
            if (currentScreen != CurrentScreen.HOME) {
              HomePage().pushReplacement(context);
            } else {
              key.currentState?.reverseAnimation();
            }
          })
    ],
  );
}

Widget cardButton(text, {onTap}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        child: Center(
          child: commonTextNoHeight(text, AppColor.buttonBg, 16.0,
              weight: FontWeight.w500),
        ),
      ),
    ),
  );
}
