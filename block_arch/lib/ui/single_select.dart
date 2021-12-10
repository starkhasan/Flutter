import 'package:flutter/material.dart';

class SingleSelect extends StatefulWidget {
  const SingleSelect({ Key? key }) : super(key: key);

  @override
  _SingleSelectState createState() => _SingleSelectState();
}

class _SingleSelectState extends State<SingleSelect> {

  var selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Single Select')
      ),
      body: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 50,
            padding: EdgeInsets.only(top: 5, bottom: MediaQuery.of(context).size.height * 0.10 + 5),
            itemBuilder: (BuildContext context,int index){
              return Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: const [BoxShadow(blurRadius: 1.0,color: Colors.grey)]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Index ${index+1}'),
                    IconButton(
                      onPressed: () => setState(() => selectIndex = index),
                      icon: index == selectIndex
                      ? const Icon(Icons.check_circle)
                      : const Icon(Icons.circle_outlined)
                    )
                  ]
                )
              );
            }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Text(selectIndex >= 0 ? 'You select ${selectIndex+1}' : 'No Item Selected yet',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
            )
          )
        ]
      )
    );
  }
}