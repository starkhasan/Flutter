import 'package:flutter_desktop/constants/strings.dart';

mixin Helper {

  static const dashboardTab = <String>[
    Strings.dashboard,
    Strings.post,
    Strings.answers
  ];

  static const emptyDaysReportDropDown = <Map<String, String>>[
    {'id': '0', 'value': 'Last 7 days'}
  ];

  static const emptyEntriesDropDown = <Map<String, String>>[
    {'id': '0', 'value': '10'},
    {'id': '1', 'value': '50'},
    {'id': '2', 'value': '100'},
    {'id': '3', 'value': '250'}
  ];
}