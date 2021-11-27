import 'package:flutter/material.dart';
import 'package:inventory_control/utils/datetime_conversion.dart';

class ProductContent extends StatelessWidget {
  final Map input;
  final String keyInput;
  const ProductContent({ Key? key,required this.input,required this.keyInput}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 2),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 0.5)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Product Id',style: TextStyle(color: Colors.grey,fontSize: 11)),
                    Text(input[keyInput]['productID'].toString(),style: const TextStyle(color: Colors.black,fontSize: 14))
                  ]
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Quantity',style: TextStyle(color: Colors.grey,fontSize: 11)),
                    Text(input[keyInput]['quantity'].toString(),style: const TextStyle(color: Colors.black,fontSize: 14))
                  ]
                ),
              )
            ]
          ),
          Visibility(
            visible: input[keyInput]['productDescription'].isNotEmpty,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text('Product Description',style: TextStyle(color: Colors.grey,fontSize: 11)),
                Text(input[keyInput]['productDescription'],style: const TextStyle(color: Colors.black,fontSize: 12))
              ]
            )
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(2))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Created At',style: TextStyle(color: Colors.grey[600],fontSize: 11)),
                Text(input[keyInput]['createdAt'].toString().convertTime,style: const TextStyle(color: Colors.black,fontSize: 11))
              ]
            )
          )
        ]
      )
    );
  }
}