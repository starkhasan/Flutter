import 'package:flutter/material.dart';
import 'dart:math';

class TransactionPage extends StatefulWidget {
  const TransactionPage({ Key? key }) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.transparent),
      ),
      body: Container(
        padding: EdgeInsets.zero,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: false,
              floating: true,
              toolbarHeight: kToolbarHeight,
              leading: IconButton(onPressed: () => Navigator.pop(context),icon: const Icon(Icons.arrow_back,color: Colors.black)),
              actions: [
                IconButton(
                  onPressed: () => print('Click on Search Icon'),
                  icon: const Icon(Icons.search,color: Colors.grey))
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([ mainBody()])
            )
          ]
        )
      )
    );
  }

  Widget mainBody(){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text('Transaction',style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 2 : 3),
                  itemBuilder: (BuildContext context,int index){
                    return Container(
                      margin: const EdgeInsets.only(left: 5,right: 5,bottom: 10),
                      padding: const EdgeInsets.all(15),
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${73+index}',style: const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                          const Text('Waiting for Confirmation')
                        ]
                      ),
                    );
                  }
                ),
                const SizedBox(height: 20),
                const Text('Tender Transaction',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18))
              ]
            )
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            child: Divider(height: 1,thickness: 1,color: Colors.grey[400])
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Street greening project',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Originator : Ali Hasan (me)',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)),
                    SizedBox(height: 5),
                    Text('Transaction Number : 20191016170400078',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)),
                    SizedBox(height: 5),
                    Text('Type : Public',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal))
                  ] 
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionPage())),
                  child: Container(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 14,bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Text('Pairing',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15))
                  )
                )
              ]
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionPage())),
                  child: Container(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 14,bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text('Delete',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15))
                  )
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionPage())),
                  child: Container(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 14,bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.blue,width: 1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text('Accept (22)',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15))
                  )
                )
              ]
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            child: Divider(height: 1,thickness: 1,color: Colors.grey[400])
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Blockchain Analysis Report',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Originator : Ali Hasan',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal))
                  ] 
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionPage())),
                  child: Container(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 14,bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Text('Pairing',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15))
                  )
                )
              ]
            ),
          ),
          const SizedBox(height: 30),
        ]
      )
    );
  }
}