import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/provider/input_provider.dart';
import 'package:provider/provider.dart';

class InputPage extends StatefulWidget {
  const InputPage({ Key? key }) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InputProvider(),
      child: Consumer<InputProvider>(
        builder: (context,inputProvider,child){
          return MainInputScreen(provider: inputProvider);
        }
      )
    );
  }
}

class MainInputScreen extends StatefulWidget {
  final InputProvider provider;
  const MainInputScreen({ Key? key,required this.provider}) : super(key: key);

  @override
  _MainInputScreenState createState() => _MainInputScreenState();
}

class _MainInputScreenState extends State<MainInputScreen> with WidgetsBindingObserver{


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) => widget.provider.getFirebaseInputData());
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }


  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance!.window.viewInsets.bottom;
    if(bottomInset == 0.0){
      widget.provider.fabVisibility(true);
    }
  }

  var productController = TextEditingController();
  var quantityController = TextEditingController();
  var descriptionConstroller = TextEditingController();
  var firebaseDataBaseReferene = FirebaseDatabase.instance.reference().child('inventory_control');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Input',style: TextStyle(fontSize: 14)),
      ),
      floatingActionButton: widget.provider.showFabButton
      ? FloatingActionButton(
          onPressed: () => widget.provider.fabVisibility(false),
          child: const Icon(Icons.add),
        )
      : null,
      body: Stack(
        children: [
          widget.provider.loadingData
          ? const Center(child:  CircularProgressIndicator(color: Colors.indigo,strokeWidth: 3))
          : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.provider.inventoryInput.length,
            itemBuilder: (BuildContext context,int index){
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Product Id',style: TextStyle(color: Colors.grey,fontSize: 10)),
                              Text(widget.provider.inventoryInput[index].productID!,style: const TextStyle(color: Colors.black,fontSize: 12))
                            ]
                          ),
                        ),
                        Text(widget.provider.inventoryInput[index].createdAt!,style: const TextStyle(color: Colors.black,fontSize: 10))
                      ]
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Quantity',style: TextStyle(color: Colors.grey,fontSize: 10)),
                        Text(widget.provider.inventoryInput[index].quantity!,style: const TextStyle(color: Colors.black,fontSize: 11))
                      ]
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: widget.provider.inventoryInput[index].productDescription!.isNotEmpty,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Product Description',style: TextStyle(color: Colors.grey,fontSize: 10)),
                          Text(widget.provider.inventoryInput[index].productDescription!,style: const TextStyle(color: Colors.black,fontSize: 11))
                        ]
                      )
                    )
                  ]
                )
              );
            }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: !widget.provider.showFabButton,
              child: Container(
                padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Color(0xFFD6D6D6),blurRadius: 4.0,spreadRadius: 1.0,offset: Offset(1, 1))]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: productController,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: 'Product Id*',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10
                        )
                      )
                    ),
                    TextField(
                      controller: quantityController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: 'Quantity*',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10
                        )
                      )
                    ),
                    TextField(
                      controller: descriptionConstroller,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: 'Product Description (Optional)',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10
                        )
                      )
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () async {
                        var data = await widget.provider.createInventory(context,productController.text,quantityController.text,descriptionConstroller.text);
                        if(data){
                          productController.clear();
                          quantityController.clear();
                          descriptionConstroller.clear();
                        }
                      },
                      child: const Text('Create',style: TextStyle(fontSize: 12))
                    )
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }

}