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
          StreamBuilder(
            stream: firebaseDataBaseReferene.child('input').onValue,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(child: const Center(child:  CircularProgressIndicator(color: Colors.indigo,strokeWidth: 3)));
              }else if(snapshot.connectionState == ConnectionState.active && snapshot.data.snapshot.value != null){
                var input = snapshot.data.snapshot.value;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: input.length,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Product Id',style: TextStyle(color: Colors.grey,fontSize: 10)),
                                    Text(input[key]['productID'],style: const TextStyle(color: Colors.black,fontSize: 12))
                                  ]
                                ),
                              ),
                              Text(input[key]['createdAt'],style: const TextStyle(color: Colors.black,fontSize: 10))
                            ]
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Quantity',style: TextStyle(color: Colors.grey,fontSize: 10)),
                              Text(input[key]['quantity'],style: const TextStyle(color: Colors.black,fontSize: 11))
                            ]
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: input[key]['productDescription'].isNotEmpty,
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Product Description',style: TextStyle(color: Colors.grey,fontSize: 10)),
                                Text(input[key]['productDescription'],style: const TextStyle(color: Colors.black,fontSize: 11))
                              ]
                            )
                          )
                        ]
                      )
                    );
                  }
                );
              }else{
                return Container(child: const Center(child: Text('To add Input Click on + button')));
              }
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
                      onPressed: createInventory,
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

  bool validation(){
    if(productController.text.isEmpty){
      snackBar('Please provide product id');
      return false;
    }else if(quantityController.text.isEmpty){
      snackBar('Please provide quantity');
      return false;
    }
    return true;
  } 

  void createInventory() async{
    if(validation()){
      await firebaseDataBaseReferene.child('input').push().set({
        'productID': productController.text,
        'quantity': quantityController.text,
        'productDescription': descriptionConstroller.text,
        'createdAt': DateTime.now().toString().substring(0,19)
      });
      quantityController.clear();
      productController.clear();
      descriptionConstroller.clear();
      snackBar('Input Added');
    }
  }

  void snackBar(String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

}