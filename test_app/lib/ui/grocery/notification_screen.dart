import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Notifications',style: TextStyle(color: Colors.black,fontSize: 14)),
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            titleSpacing: 0,
            leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back,color: Colors.black)),
          ),
          SliverList(delegate: SliverChildListDelegate([mainBody()]))
        ]
      )
    );
  }


  Widget mainBody(){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0),
      itemBuilder: (BuildContext context,int index){
        return Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5)),boxShadow: [BoxShadow(blurRadius: 2.0,color: Colors.grey)]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Order #2314',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                  Text('4:23 PM',style: TextStyle(fontSize: 12))
                ]
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text('Your order is confirmed. Please check everything is okay',style: TextStyle(fontSize: 12))),
                  InkWell(
                    onTap: () => print('Click Here to call'),
                    child: Container(
                      margin: const EdgeInsets.only(left: 8,right: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red[50]),
                      child: const Icon(Icons.phone,color: Colors.red,size: 22)
                    )
                  )
                ]
              )
            ]
          )
        );
      }, 
      itemCount: 20
    );
  }
}