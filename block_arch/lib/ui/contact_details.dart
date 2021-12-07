import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {

  var headerCount = 0;
  Map<String,List<String>> contactMap = {};
  List<String> listContact = [
    'Ali Hasan',
    'Anil',
    'Ankit',
    'Aamir',
    'Asad',
    'Abhishek',
    'Abhiraj',
    'Aniket',
    'Abdullah',
    'Adbi',
    'Anupam',
    'Aman',
    'Aakash',
    'Bikki',
    'Banti',
    'Bablu',
    'Baklol',
    'Cikki',
    'Chintu',
    'Champak',
    'Chaddi',
    'Chandal',
    'Dog',
    'Dom',
    'Domin',
    'Doctor',
    'Dablu'
  ];

  Set<String> indexName = {};
  Map<String,List<String>> mapContact = {};


  @override
  Widget build(BuildContext context) {
    manipulateContactDetails();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        centerTitle: true
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context,int index){
          return StickyHeader(  
            header: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
              child: Text(
                indexName.elementAt(index),
                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),
            content: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(15)),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mapContact[indexName.elementAt(index)]!.length,
                itemBuilder: (BuildContext context,int localIndex){
                  var data = mapContact[indexName.elementAt(index)]!!;
                  return Container(padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        child: Center(child: Text(data[localIndex].substring(0,1))),
                      ),
                      const SizedBox(width: 10),
                      Text(data[localIndex],style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                    ],
                  ));
                },
                separatorBuilder: (BuildContext context,int index){
                  return const Divider(height: 1,thickness: 1);
                }
              ),
            )
          );
        },
        itemCount: indexName.length
      )
    );
  }

  manipulateContactDetails(){
    indexName.clear();
    mapContact.clear();
    List.generate(listContact.length, (index) {
      indexName.add(listContact[index].substring(0,1));
      if(mapContact.containsKey(listContact[index].substring(0,1))){
        var tempList = mapContact[listContact[index].substring(0,1)]!!;
        tempList.add(listContact[index]);
        mapContact[listContact[index].substring(0,1)] = tempList;
      }else{
        mapContact[listContact[index].substring(0,1)] = [listContact[index]];
      }
    });
  }
}
