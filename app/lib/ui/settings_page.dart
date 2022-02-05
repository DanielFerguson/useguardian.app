import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guardian/bloc/settings_bloc/settings_bloc.dart';
import 'package:guardian/common/color_assets.dart';
import 'package:guardian/common/common_ext.dart';
import 'package:guardian/common/common_methos.dart';
import 'package:guardian/common/common_widget.dart';
import 'package:guardian/common/image_assets.dart';
import 'package:guardian/common/text_assets.dart';
import 'package:guardian/di/injection_container.dart';
import 'package:guardian/models/user_location.dart';
import 'package:guardian/ui/map_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsBloc _blocSettings = sl<SettingsBloc>();
  late Map<dynamic, List<UserLocation>> locations;
  late Set<dynamic> key;

  @override
  void initState() {
    super.initState();
    _blocSettings.add(MapLoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildUI() {
    return BlocConsumer(
      bloc: _blocSettings,
      listener: (context, state) {
        if (state is SettingsMapLoadingState) {
          CircularProgressIndicator();
        } else if (state is SettingsMapSuccessState) {
          key = state.key;
          locations = state.locations;
        } else if (state is NavigateMapState) {
          debugPrint('### Map clicked');
          MapPage(state.date).pushReplacement(context);
        }
        if (state is SettingsWipeDataState) {
          key.clear();
          locations.clear();
        }
        /*switch(state.runtimeType){
          case SettingsMapLoadingState:
            break;
          case SettingsMapSuccessState:
            state
        }*/
      },
      builder: (BuildContext context, SettingsState state) {
        if (state is SettingsMapLoadingState) {
          CircularProgressIndicator();
        } else if (state is SettingsMapSuccessState ||
            state is SettingsWipeDataState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              commonButtonWithIcon(
                () {
                  showSettingPopUp();
                  // _blocSettings.add(WipeDataEvent());
                },
                TextAsset.wipeButton,
                16.0,
                Colors.red,
                stringIcon: ImageAsset.icDelete,
              ),
              /*SizedBox(
                height: 30,
              ),
              commonTextNoHeight(
                  TextAsset.settingsText1, AppColor.textGrey, 16.0,
                  weight: FontWeight.w400),
              SizedBox(
                height: 15,
              ),
              commonTextNoHeight(
                  TextAsset.settingsText2, AppColor.textGrey, 16.0,
                  weight: FontWeight.w400),*/
              SizedBox(
                height: 20,
              ),
              commonTextNoHeight(
                  TextAsset.yourLocations, AppColor.buttonBg, 18.0,
                  weight: FontWeight.w600),
              SizedBox(
                height: 15,
              ),
              commonTextNoHeight(
                  key.isEmpty
                      ? TextAsset.settingsText3Empty
                      : TextAsset.settingsText3,
                  AppColor.textGrey,
                  16.0,
                  weight: FontWeight.w400),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: key.isNotEmpty ? true : false,
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: key.length,
                  itemBuilder: (context, index) {
                    var date = key.elementAt(index);
                    // AppConfig.BASE_URL.
                    String url =
                        'https://maps.googleapis.com/maps/api/staticmap?size=1024x1024&maptype=roadmap\%20&markers=icon:https://useguardian.app/assets/location.png|size:mid|${locations[date]?.map((e) => "${e.lat},${e.lon}").toList().join("|")}&key=AIzaSyDUQ-bUIxrVC1KF2XoFk-MuHR8QfAEF5gI';
                    String locationDate = getDate(date);
                    print(url);
                    return locationCard(url, locationDate, () {
                      _blocSettings.add(NavigateMapEvent(date, locations[key]));
                    });
                    // 'https://maps.googleapis.com/maps/api/staticmap?size=512x512&maptype=roadmap\%20&markers=icon:http://cdn.sstatic.net/Sites/stackoverflow/img/favicon.ico|size:mid|color:black|23.080284,72.512043|23.065033,72.530514|23.081029,72.538209&key=AIzaSyDUQ-bUIxrVC1KF2XoFk-MuHR8QfAEF5gI', 'Today');
                  },
                ),
              ),
              Visibility(
                visible: key.isEmpty ? true : false,
                child: Image.asset(
                  ImageAsset.imgNoLocation,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 90,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  String getDate(date) {
    DateTime dt = dateTimeFromString(date, FORMAT1);
    if (DateTime.now().difference(dt).inDays == 0) {
      return 'Today';
    } else if (DateTime.now().difference(dt).inDays == 1) {
      return 'Yesterday';
    } else {
      return stringFromDateTimeWithTH(dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        floatingActionButton:
            floatingButton(context, currentScreen: CurrentScreen.SETTINGS),
        backgroundColor: AppColor.appBg,
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          title: commonTextNoHeight(TextAsset.settings, Colors.white, 18.0,
              weight: FontWeight.w600),
          centerTitle: true,
          backgroundColor: AppColor.buttonBg,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: buildUI(),
          ),
        ),
      ),
    );
  }

  Widget locationCard(String link, String text, onTap) {
    return Card(
      // elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonTextNoHeight(text, AppColor.buttonBg, 16.0,
                  weight: FontWeight.w500),
              SizedBox(
                height: 15,
              ),
              CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  width: double.maxFinite,
                  height: 180.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                imageUrl: link,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Image.network('https://i.stack.imgur.com/y9DpT.jpg'),
                // CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSettingPopUp() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  child: Container(
                    // height: 375,
                    margin: EdgeInsets.only(top: 15.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: commonTextNoHeight(
                                      'Wipe Data',
                                      AppColor.buttonBg,
                                      18.0,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: SvgPicture.asset(
                                    ImageAsset.icClose,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            thickness: 2.0,
                            color: AppColor.dividerBg,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: commonTextNoHeight(
                            'Are you sure?',
                            AppColor.buttonBg,
                            16.0,
                            weight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonTextNoHeight(
                                TextAsset.dialogDesc1,
                                AppColor.textGrey,
                                14.0,
                                weight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              commonTextNoHeight(
                                TextAsset.dialogDesc2,
                                AppColor.textGrey,
                                14.0,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColor.fabBgGrey),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                side: BorderSide(
                                                    color:
                                                        AppColor.fabBgGrey)))),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: AppColor.buttonBg,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 55.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _blocSettings.add(WipeDataEvent());
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      /*transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 0), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },*/
    );
  }
}
