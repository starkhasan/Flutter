import 'dart:async';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(
        {required BuildContext context, required String title, required String description}) =>
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: Text(description),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));