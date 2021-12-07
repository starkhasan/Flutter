import 'package:flutter/material.dart';

class  Helper {
  
  static void show_snack_bar(BuildContext context,String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }


}

/**
 * Square
 * Sandbox Application ID
 * sandbox-sq0idb-SDo00t1mjESNdPC3dp1fXQ
 * Sandbox Access Token
 * EAAAELUlW3QKjLxy65AEG59yryCakHLl50uQSMOsovOHND84QbVa8P9XDHqW-fE0
 * Sandbox Location ID
 * LDWVWYVTV3AP7
 */