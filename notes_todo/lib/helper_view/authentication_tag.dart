import 'package:flutter/material.dart';

class AuthenticationTab extends StatelessWidget{
  final bool isLogin;
  final String tag;
  const AuthenticationTab({Key? key,required this.isLogin,required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2.0,color: isLogin ? Colors.transparent : Theme.of(context).toggleableActiveColor))
      ),
      padding: const EdgeInsets.only(top: 12,bottom: 12),
      child: Text(tag,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,color: isLogin ? Colors.grey : Theme.of(context).toggleableActiveColor, fontWeight: FontWeight.bold))
    );
  }
}