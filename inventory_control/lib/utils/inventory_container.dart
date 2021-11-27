import 'package:flutter/material.dart';
import 'package:inventory_control/provider/input_provider.dart';
import 'package:inventory_control/utils/datetime_conversion.dart';

class InventoryContainer extends StatelessWidget {
  final InputProvider provider;
  final int index;
  const InventoryContainer({ Key? key,required this.provider,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8,left: 5,right: 5),
      padding: const EdgeInsets.all(10),
      decoration:  BoxDecoration(
        color: const Color(0xFFFFFFFF),
        boxShadow: const [BoxShadow(color: Color(0xFFBDBDBD),blurRadius: 0.5)],
        border: Border(right: BorderSide(color: provider.inventoryModel[index].productQuantity > 0 ? Colors.green : Colors.red,width: 3)),
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
                    const Text('Product Id',style: TextStyle(color: Colors.grey,fontSize: 12)),
                    Text(provider.inventoryModel[index].productId.toString(),style: const TextStyle(color: Colors.black,fontSize: 14))
                  ]
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(provider.inventoryModel[index].productQuantity > 0 ? 'In Stock' : 'Out of Stock',style: TextStyle(color: provider.inventoryModel[index].productQuantity > 0 ? Colors.green : Colors.red,fontSize: 12)),
                    Text(provider.inventoryModel[index].productQuantity.toString(),style: const TextStyle(color: Colors.black,fontSize: 14))
                  ]
                ),
              )
            ]
          ),
          Visibility(
            visible: provider.inventoryModel[index].productDescription.isNotEmpty,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text('Product Description',style: TextStyle(color: Colors.grey,fontSize: 10)),
                Text(provider.inventoryModel[index].productDescription.toString(),style: const TextStyle(color: Colors.black,fontSize: 12))
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
                Text('Last Update',style: TextStyle(color: Colors.grey[600],fontSize: 10)),
                Text(provider.inventoryModel[index].updatedAt.convertTime,style: const TextStyle(color: Colors.black,fontSize: 10))
              ]
            ),
          )
        ]
      )
    );
  }
}
