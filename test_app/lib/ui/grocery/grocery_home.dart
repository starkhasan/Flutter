import 'package:flutter/material.dart';
import 'package:test_app/ui/grocery/notification_screen.dart';
import 'package:test_app/ui/grocery/product_details.dart';

class GroceryHome extends StatefulWidget {
  const GroceryHome({ Key? key }) : super(key: key);

  @override
  _GroceryHomeState createState() => _GroceryHomeState();
}

class _GroceryHomeState extends State<GroceryHome> {

  var listImageURL = [
    'https://m.media-amazon.com/images/I/91pDdDLHquL._SX522_.jpg',
    'https://www.bigbasket.com/media/uploads/p/xxl/40198145_1-popular-essentials-premium-jeera-rice.jpg',
    'https://m.media-amazon.com/images/I/71LpBnx+5xL._SL1500_.jpg',
    'https://m.media-amazon.com/images/I/71bSLxCaGGL._SL1500_.jpg',
    'https://www.jiomart.com/images/product/original/490001392/amul-butter-500-g-carton-6-20210315.jpg',
    'https://www.bigbasket.com/media/uploads/p/l/104823_3-amul-cheese-spread-yummy-plain.jpg',
    'https://5.imimg.com/data5/PF/FT/XN/SELLER-6800096/amul-gold-milk-500ml-500x500.jpg',
    'https://m.media-amazon.com/images/I/615etm93zBL._SX522_.jpg',
    'https://m.media-amazon.com/images/I/519YSKro-XL.jpg',
    'https://m.media-amazon.com/images/I/61L0w87gCML._SX522_.jpg',
  ];

  var listProductName = [
    'Flour',
    'Rice',
    'Sugar',
    'Salt',
    'Butter',
    'Cheese',
    'Milk',
    'Red Chilli Powder',
    'Turmeric Powder',
    'Coriander Powder' 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: Container(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Grocery Plus',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen())),
                    icon: const Icon(Icons.notifications),
                  )
                ]
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.location_pin,color: Colors.white),
                    backgroundColor: Colors.green
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Your Location',style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text('Wali Ganj, Arrah, Arrah Town',style: TextStyle(color: Colors.black,fontSize: 16))
                    ]
                  )
                ]
              ),
              Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 12,bottom: 12),
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(color: Colors.grey[300],borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(hintText: 'Search Anything'),
                      ),
                    )
                  ]
                )
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 2 : 2),
                itemCount: listImageURL.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context,int index){
                  return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(imagePath: listImageURL[index], productDetails: listProductName[index], productId: '10'))),
                    child: Container(
                      margin: const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 5),
                      decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5.0)),boxShadow: [BoxShadow(blurRadius: 2.0,color: Color(0xFFE0E0E0))]),
                      child: Column(
                        children: [
                          Expanded(child: Image.network(listImageURL[index])),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(listProductName[index],style: const TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ]
                      )
                    )
                  );
                }
              )
            ]
          )
        )
      )
    );
  }
}