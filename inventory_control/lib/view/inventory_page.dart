import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inventory_control/utils/datetime_conversion.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({ Key? key }) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  var firebaseDataBaseReferene = FirebaseDatabase.instance.reference().child('inventory_control');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Inventory',style: TextStyle(fontSize: 14))
      ),
      body: StreamBuilder(
        stream: firebaseDataBaseReferene.child('inventory').onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.connectionState == ConnectionState.active && snapshot.data.snapshot.value != null){
            var input = snapshot.data.snapshot.value;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: input.length,
              reverse: true,
              itemBuilder: (BuildContext context,int index){
                var key = input.keys.elementAt(index);
                return Container(
                  margin: const EdgeInsets.only(top: 8,left: 5,right: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 1.0)]
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
                                const Text('Product Id',style: TextStyle(color: Colors.grey,fontSize: 10)),
                                Text(key,style: const TextStyle(color: Colors.black,fontSize: 12))
                              ]
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(input[key]['quantity']>0 ? 'In Stock' : 'Out of Stock',style: TextStyle(color: input[key]['quantity']>0 ? Colors.green : Colors.red,fontSize: 10)),
                                Text(input[key]['quantity'].toString(),style: const TextStyle(color: Colors.black,fontSize: 11))
                              ]
                            ),
                          )
                        ]
                      ),
                      Visibility(
                        visible: input[key]['productDescription'].isNotEmpty,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text('Product Description',style: TextStyle(color: Colors.grey,fontSize: 10)),
                            Text(input[key]['productDescription'],style: const TextStyle(color: Colors.black,fontSize: 11))
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
                            Text(input[key]['updatedAt'].toString().convertTime,style: const TextStyle(color: Colors.black,fontSize: 10))
                          ]
                        ),
                      )
                    ]
                  )
                );
              }
            );
          }else{
            return const Center(child: Text('Empty Inventory'));
          }
        }
      )
    );
  }
}