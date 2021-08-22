import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginButton extends StatelessWidget {
  const LoginButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: const Text(
        'LOGIN',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.white
        )
      ),
    );
  }
}
