import 'package:hello_flutter/ui/SilverScreen.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

class LanguageHindi extends Languages {
  @override
  String get chooseLanguage => 'हिंदी';
  @override
  String get labelSelectLanguage => "भाषा का चयन करें";
  @override
  String get language => "भाषा";
  @override
  String get homeTitle => "होम";
  @override
  String get landingTitle => "लैंडिंग स्क्रीन";
  @override
  String get swipeTitle => "स्वाइप डिलीट";
  @override
  String get expandableTitle => "एक्सपेंडेबल कार्ड्स";
  @override
  String get cardTitle => "कार्ड्स  स्वाइप";
  @override
  String get homeDrawerTitle => "होम ड्रावर";
  @override
  String get sliverScreen => "सिल्वर स्क्रीन";
  @override
  String get appLifeCycle => "अप्प लाइफ साइकिल";
  @override
  String get takePicture => "तस्वीर ले";
  @override
  String get notification => "सूचना";
  @override
  String get payment => "भुगतान";
}
