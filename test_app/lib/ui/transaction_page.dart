import 'package:flutter/material.dart';
import 'dart:math';

class TransactionPage extends StatefulWidget {
  const TransactionPage({ Key? key }) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  late PageController pageController;
  var currentTransactionPage = 0;

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0
    );
    pageController.addListener(pageControllerListener);
    super.initState();
  }

  pageControllerListener(){
    if(pageController.page == 0.0){
      setState(() => currentTransactionPage = 0);
    }
    if(pageController.page == 1.0){
      setState(() => currentTransactionPage = 1);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Transaction',style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              pinned: false,
              floating: true,
              toolbarHeight: kToolbarHeight,
              leading: IconButton(onPressed: () => Navigator.pop(context),icon: const Icon(Icons.arrow_back,color: Colors.black)),
              titleSpacing: 0,
              actions: [
                IconButton(
                  onPressed: () => showSnackBar(context,'Click on Search Icon'),
                  icon: const Icon(Icons.search,color: Colors.grey)
                )
              ]
            ),
            SliverList(delegate: SliverChildListDelegate([mainBody()]))
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
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      child: Text('Launched',style: TextStyle(color: currentTransactionPage == 0 ? Colors.black : Colors.grey[400],fontSize: currentTransactionPage == 0 ? 22 : 18,fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 20),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      child: Text('Received',style: TextStyle(color: currentTransactionPage == 1 ? Colors.black : Colors.grey[400],fontSize: currentTransactionPage == 1 ? 22 : 18,fontWeight: FontWeight.bold))
                    )
                  ]
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.52,
                  padding: EdgeInsets.zero,
                  child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: const [
                      TrasactionGridView(gridLabel: 'Waiting for Confirmation',gridPice: 73),
                      TrasactionGridView(gridLabel: 'In Progress',gridPice: 1)
                    ]
                  )
                ),
                const SizedBox(height: 20),
                const Text('New Transactions',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18))
              ]
            )
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            child: Divider(height: 1,thickness: 1,color: Colors.grey[400])
          ),
          const SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: Text('Street greening project',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16))),
                    GestureDetector(
                      onTap: () => showSnackBar(context, 'Pairing'),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Text('Pairing',style: TextStyle(color: Color.fromARGB(255, 80, 79, 79),fontWeight: FontWeight.bold,fontSize: 14))
                      )
                    )
                  ]
                ),
                const Text('Originator : Ali Hasan (me)',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12)),
                const SizedBox(height: 2),
                const Text('Transaction Number : 20191016170400078',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12)),
                const SizedBox(height: 2),
                const Text('Type : Public',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12))
              ]
            )
          ),
          const SizedBox(height: 15),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => showSnackBar(context, 'Deleted'),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Text('Delete',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14))
                  )
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => showSnackBar(context, 'Accepted'),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.blue,width: 1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Text('Accept (22)',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14))
                  )
                )
              ]
            )
          ),
          const SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            child: Divider(height: 1,thickness: 1,color: Colors.grey[400])
          ),
          const SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: Text('Blockchain Analysis Report',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16))),
                    GestureDetector(
                      onTap: () => showSnackBar(context, 'Pairing'),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Text('Pairing',style: TextStyle(color: Color.fromARGB(255, 80, 79, 79),fontWeight: FontWeight.bold,fontSize: 14))
                      )
                    )
                  ]
                ),
                const Text('Originator : Ali Hasan',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12))
              ]
            )
          )
        ]
      )
    );
  }

  showSnackBar(BuildContext _context,String message){
    var snackbar = SnackBar(backgroundColor: Colors.grey[200],content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

}


class TrasactionGridView extends StatelessWidget {
  final String gridLabel;
  final int gridPice;
  const TrasactionGridView({ Key? key,required this.gridLabel,required this.gridPice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 2 : 3),
      itemBuilder: (BuildContext context,int index){
        return Container(
          margin: const EdgeInsets.only(left: 2,right: 2,bottom: 4),
          padding: const EdgeInsets.only(left: 15, top: 15,bottom: 10, right: 10),
          height: MediaQuery.of(context).size.height * 0.10,
          decoration: BoxDecoration(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('${gridPice+index*2}',style: const TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold))),
              Text(gridLabel,maxLines: 2,overflow: TextOverflow.ellipsis,style : const TextStyle(fontSize: 12))
            ]
          )
        );
      }
    );
  }
}