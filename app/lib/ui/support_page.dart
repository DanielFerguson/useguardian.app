import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guardian/common/color_assets.dart';
import 'package:guardian/common/common_ext.dart';
import 'package:guardian/common/common_methos.dart';
import 'package:guardian/common/common_widget.dart';
import 'package:guardian/common/image_assets.dart';
import 'package:guardian/common/text_assets.dart';
import 'package:guardian/ui/terms_page.dart';
import 'package:guardian/ui/webview_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        floatingActionButton:
            floatingButton(context, currentScreen: CurrentScreen.SUPPORT),
        backgroundColor: AppColor.appBg,
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          title: commonTextNoHeight(TextAsset.support, Colors.white, 18.0,
              weight: FontWeight.w600),
          centerTitle: true,
          backgroundColor: AppColor.buttonBg,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  commonTextNoHeight(
                      TextAsset.simpleDesign, AppColor.buttonBg, 24.0,
                      weight: FontWeight.w700),
                  SizedBox(
                    height: 15,
                  ),
                  commonTextNoHeight(
                      TextAsset.simpleDesign1, AppColor.textGrey, 16.0,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 10,
                  ),
                  commonTextNoHeight(
                      TextAsset.simpleDesign2, AppColor.textGrey, 16.0,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 20,
                  ),
                  commonTextNoHeight(
                      TextAsset.doNotTrack, AppColor.buttonBg, 18.0,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: 15,
                  ),
                  /* Row(
                      children: [
                        commonTextNoHeight(
                            TextAsset.dot, AppColor.buttonBg, 16.0,
                            weight: FontWeight.w600) ,
                        commonTextNoHeight(
                            TextAsset.doNotTrack1, AppColor.textGrey, 16.0,
                            weight: FontWeight.w400),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),*/
                  Row(
                    children: [
                      commonTextNoHeight(TextAsset.dot, AppColor.buttonBg, 16.0,
                          weight: FontWeight.w600),
                      commonTextNoHeight(
                          TextAsset.doNotTrack2, AppColor.textGrey, 16.0,
                          weight: FontWeight.w400),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      commonTextNoHeight(TextAsset.dot, AppColor.buttonBg, 16.0,
                          weight: FontWeight.w600),
                      commonTextNoHeight(
                          TextAsset.doNotTrack3, AppColor.textGrey, 16.0,
                          weight: FontWeight.w400),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      commonTextNoHeight(TextAsset.dot, AppColor.buttonBg, 16.0,
                          weight: FontWeight.w600),
                      commonTextNoHeight(
                          TextAsset.doNotTrack4, AppColor.textGrey, 16.0,
                          weight: FontWeight.w400),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  commonTextNoHeight(
                      TextAsset.doNotTrackDetails, AppColor.textGrey, 16.0,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 20,
                  ),
                  commonTextNoHeight(
                      TextAsset.dataSource, AppColor.buttonBg, 18.0,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: 20,
                  ),
                  cardButton(TextAsset.cardButton1, onTap: () {
                    WebViewPage(
                      link: TextAsset.linkSouthWhales,
                    ).push(context);
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  cardButton(TextAsset.cardButton2, onTap: () {
                    WebViewPage(
                      link: TextAsset.linkSouthAustralia,
                    ).push(context);
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  cardButton(TextAsset.cardButton3, onTap: () {
                    WebViewPage(
                      link: TextAsset.linkVictoria,
                    ).push(context);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  commonTextNoHeight(
                      TextAsset.getTouch, AppColor.buttonBg, 18.0,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: 15,
                  ),
                  commonTextNoHeight(
                      TextAsset.getTouchDesc, AppColor.textGrey, 16.0,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageAsset.icMail),
                      SizedBox(
                        width: 12,
                      ),
                      commonTextNoHeight(
                        TextAsset.supportMail,
                        AppColor.buttonBg,
                        16.0,
                        weight: FontWeight.w400,
                        onTap: () {
                          launch(emailLaunchUri.toString());
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      SvgPicture.asset(ImageAsset.icGlobal),
                      SizedBox(
                        width: 12,
                      ),
                      commonTextNoHeight(
                        TextAsset.website,
                        AppColor.buttonBg,
                        16.0,
                        weight: FontWeight.w400,
                        onTap: () => WebViewPage(link: TextAsset.linkWebsite)
                            .push(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  commonTextNoHeight(TextAsset.tnc, AppColor.buttonBg, 18.0,
                      weight: FontWeight.w600),
                  SizedBox(
                    height: 15,
                  ),
                  commonTextNoHeight(TextAsset.tncDesc, AppColor.textGrey, 16.0,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 15,
                  ),
                  cardButton(TextAsset.cardButton4,
                      onTap: () => TermsPage().pushReplacement(context)),
                  SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: TextAsset.supportMail,
  );
}
