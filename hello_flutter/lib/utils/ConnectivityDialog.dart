import 'package:flutter/cupertino.dart';

class ConnectivityDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('No Internet Connection'),
      content: Text('Make sure that Wi-Fi or mobile data is turned on, then try again.'),
      actions: [
        CupertinoDialogAction(onPressed: () => Navigator.pop(context), child: Text('OK'))
      ],
    );
  }
}
