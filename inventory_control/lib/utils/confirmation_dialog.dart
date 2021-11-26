import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  final String title;
  final String content;
  final Function onPressed;
  const ConfirmationDialog({Key? key,required this.title,required this.content,required this.onPressed}) : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title,style: const TextStyle(fontSize: 14)),
      content: Text(widget.content),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context,false),
          child: const Text('No',style: TextStyle(fontSize: 14,color: Colors.red)),
        ),
        CupertinoDialogAction(
          onPressed: () => {
            Navigator.pop(context),
            widget.onPressed()
          },
          child: const Text('Yes',style: TextStyle(fontSize: 14)),
        )
      ]
    );
  }
}
