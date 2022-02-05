import 'package:flutter/material.dart';

extension NavigatorPage on StatefulWidget {
  Future<dynamic> push(BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => this));
  }

  Future<dynamic> pushReplacement(BuildContext context) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => this));
  }
}
