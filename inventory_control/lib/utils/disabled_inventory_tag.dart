import 'package:flutter/material.dart';

class DisabledInventoryTag extends StatelessWidget {
  const DisabledInventoryTag({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15,top: 8, bottom: 8,right: 8),
      color: Colors.yellow[50],
      child: Row(
        children: const [
          Icon(Icons.warning,color: Colors.amber,size: 20),
          SizedBox(width:  5),
          Text(
            'Inventory Disabled. Please enable inventory to perform action.',
            style: TextStyle(color: Colors.black,fontSize: 12)
          )
        ]
      )
    );
  }
}