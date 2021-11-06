import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_control/provider/input_provider.dart';

class BottomSearchBar extends StatelessWidget implements PreferredSizeWidget{
  final double preferredHeight;
  final InputProvider inputProvider;
  const BottomSearchBar({ Key? key,required this.preferredHeight,required this.inputProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4,left: 4,right: 4,bottom: 4),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(color: Colors.blue,blurRadius: 1.5)
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search,size: 20,color: Colors.grey[400]),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.text,
              cursorColor: const Color(0xFF0B3054),
              cursorWidth: 1.5,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9\u0900-\u097F]"))],
              style: const TextStyle(color: Colors.black,fontFamily: '',fontSize: 14),
              decoration: InputDecoration.collapsed(
                hintText: 'Search Products Here',
                hintStyle: TextStyle(color: Colors.grey[400],fontSize: 12,fontFamily: '')
              ),
              onChanged: (input) => inputProvider.searchInventoryProduct(input)
            )
          )
        ]
      )
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(50.0);
  }
}