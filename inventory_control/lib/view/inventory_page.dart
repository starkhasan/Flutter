import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({ Key? key }) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Inventory',style: TextStyle(fontSize: 14))
      ),
      body: Container(
        child: const Center(child: Text('Inventory')),
      ),
    );
  }
}