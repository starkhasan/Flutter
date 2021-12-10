import 'package:block_arch/models/list_select.dart';
import 'package:flutter/material.dart';

class MultiSelectList extends StatefulWidget {
  const MultiSelectList({ Key? key }) : super(key: key);

  @override
  _MultiSelectListState createState() => _MultiSelectListState();
}

class _MultiSelectListState extends State<MultiSelectList> {
  
  List<ListSelect> listSelectData = [];

  @override
  void initState() {
    super.initState();
    List.generate(50, (index) => listSelectData.add(ListSelect('Index ${index+1}', false, index)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Multi Select')
      ),
      body: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: listSelectData.length,
            padding: const EdgeInsets.all(5),
            itemBuilder: (BuildContext context,int index){
              return Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: const [BoxShadow(blurRadius: 1.0,color: Colors.grey)]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(listSelectData[index].title),
                    IconButton(
                      onPressed: () => setState(() => listSelectData[index].isSelected = true),
                      icon: listSelectData[index].isSelected
                      ? const Icon(Icons.check_circle)
                      : const Icon(Icons.circle_outlined)
                    )
                  ]
                )
              );
            }
          )
        ]
      )
    );
  }

}