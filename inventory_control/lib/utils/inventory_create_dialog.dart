import 'package:flutter/material.dart';
import 'package:inventory_control/provider/home_provider.dart';
import 'package:inventory_control/utils/helper.dart';

class CreateInventoryDialog extends StatefulWidget{
  final HomeProvider provider;
  const CreateInventoryDialog({ Key? key,required this.provider}) : super(key: key);

  @override
  _CreateInventoryDialogState createState() => _CreateInventoryDialogState();
}

class _CreateInventoryDialogState extends State<CreateInventoryDialog> with Helper {

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text('Create New Inventory',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0)),
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: textController.text.isNotEmpty,
                    child: Text(
                      widget.provider.isInventoryAvailable
                      ? 'Not Available'
                      : 'Available',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: widget.provider.isInventoryAvailable ? Colors.red : Colors.green,fontSize: 12)
                    ),
                  )
                )
              ]
            ),
            const SizedBox(height: 10),
            TextField(
              controller: textController,
              autofocus: true,
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                hintText: 'Inventory Name',
                labelText: 'Inventory Name',
                hintStyle: TextStyle(color: Colors.grey,fontSize: 12.0)
              ),
              onChanged: (value) => {
                if(value.isNotEmpty){
                  widget.provider.searchInventoryName(value)
                },
                setState((){})
              }
            ),
            const SizedBox(height: 20),
            widget.provider.isLoading
            ? const Center(child: SizedBox(child: CircularProgressIndicator(strokeWidth: 2.0)))
            : Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pop(context,false),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      padding: const EdgeInsets.only(top: 6,bottom: 6,left: 6,right: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: Colors.red,width: 0.5)
                      ),
                      child: const Center(child:Text('Close',style: TextStyle(color: Colors.red)))
                    )
                  )
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      if(textController.text.isNotEmpty && !widget.provider.isInventoryAvailable){
                        setState(() {});
                        var value = await widget.provider.createInventory(context,textController.text);
                        if(value){
                          setState(() {});
                          Navigator.pop(context);
                        }
                      }else{
                        showSnackBar(context, 'Please provider valid name');
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: const Center(child: Text('Create',style: TextStyle(color: Colors.white)))
                    )
                  ),
                )  
              ]
            )
          ]
        )
      )
    );
  }
}