import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteNotesDialog extends StatefulWidget {
  final Function onPressed;
  const DeleteNotesDialog({Key? key,required this.onPressed}) : super(key: key);

  @override
  State<DeleteNotesDialog> createState() => _DeleteNotesDialogState();
}

class _DeleteNotesDialogState extends State<DeleteNotesDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Delete all Notes'),
      content: const Text('Are you sure you want to delete all Notes?'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('No',style: TextStyle(color: Colors.red))
        ),
        CupertinoDialogAction(
          onPressed: () => widget.onPressed(),
          child: const Text('Yes'),
        )
      ],
    );
  }
}