import 'package:flutter/material.dart';
import 'package:guardian/common/color_assets.dart';
import 'package:guardian/common/common_methos.dart';
import 'package:guardian/common/common_widget.dart';
import 'package:guardian/common/text_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        floatingActionButton: floatingButton(context),
        backgroundColor: AppColor.appBg,
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          title: commonTextNoHeight(TextAsset.legal, Colors.white, 18.0,
              weight: FontWeight.w600),
          centerTitle: true,
          backgroundColor: AppColor.buttonBg,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  commonTextNoHeight(TextAsset.tnc, AppColor.buttonBg, 24.0,
                      weight: FontWeight.w700),
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      text: TextAsset.tncPageDesc,
                      style: TextStyle(color: AppColor.textGrey,fontSize: 16.0,fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: TextAsset.supportMail,
                          style: TextStyle(color: AppColor.buttonBgBlue,fontSize: 16.0,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
/*                  Row(
                    children: [
                      Flexible(
                        child: commonTextNoHeight(
                            TextAsset.tncPageDesc, AppColor.textGrey, 16.0,
                            weight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch(emailLaunchUri.toString());
                        },
                        child: commonTextNoHeight(
                            TextAsset.supportMail, AppColor.textGrey, 16.0,
                            weight: FontWeight.w400),
                      ),
                    ],
                  )*/
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: TextAsset.supportMail,
/*    query: encodeQueryParameters(
        <String, String>{'subject': 'Example Subject & Symbols are allowed!'})*/
  );
}
