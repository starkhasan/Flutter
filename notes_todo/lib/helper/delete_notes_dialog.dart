import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteNotesDialog extends StatefulWidget {
  final Function onPressed;
  final String titleDialog;
  final String contentDialog;
  const DeleteNotesDialog({Key? key,required this.onPressed,required this.titleDialog,required this.contentDialog}) : super(key: key);

  @override
  State<DeleteNotesDialog> createState() => _DeleteNotesDialogState();
}

class _DeleteNotesDialogState extends State<DeleteNotesDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.titleDialog),
      content: Text(widget.contentDialog),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('No',style: TextStyle(color: Colors.red))
        ),
        CupertinoDialogAction(
          onPressed: () => widget.onPressed(),
          child: const Text('Yes',style: TextStyle(color: Colors.blue)),
        )
      ]
    );
  }
}