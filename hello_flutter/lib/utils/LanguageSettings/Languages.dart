import 'package:flutter/cupertino.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get chooseLanguage;
  String get labelSelectLanguage;
  String get language;
  String get homeTitle;
  String get landingTitle;
  String get swipeTitle;
  String get expandableTitle;
  String get cardTitle;
  String get homeDrawerTitle;
  String get sliverScreen;
  String get appLifeCycle;
  String get takePicture;
  String get payment;
  String get notification;
}
