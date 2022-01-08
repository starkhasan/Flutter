import 'package:flutter/material.dart';
import 'package:test_app/ui/grocery/product_details.dart';
import 'package:test_app/utils/dash_line.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({ Key? key }) : super(key: key);

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  
  final currentPageNotifier = ValueNotifier<int>(0);
  var itemCount = 1;
  var listImageURL = [
    'https://m.media-amazon.com/images/I/91pDdDLHquL._SX522_.jpg',
    'https://www.bigbasket.com/media/uploads/p/xxl/40198145_1-popular-essentials-premium-jeera-rice.jpg',
    'https://m.media-amazon.com/images/I/71LpBnx+5xL._SL1500_.jpg',
    'https://m.media-amazon.com/images/I/71bSLxCaGGL._SL1500_.jpg',
    'https://www.jiomart.com/images/product/original/490001392/amul-butter-500-g-carton-6-20210315.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green,)),
      bottomNavigationBar: InkWell(
        onTap: () => print('Click Here to Add to Cart'),
        child: Container(
          height: 50,
          color: Colors.deepOrange,
          child: const Center(child: Text('Place Order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white)))
        )
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Place Orders',style: TextStyle(color: Colors.black,fontSize: 14)),
            backgroundColor: Colors.white,
            floating: true,
            snap: true,
            automaticallyImplyLeading: false
          ),
          SliverList(delegate: SliverChildListDelegate([mainBody()]))
        ]
      )
    );
  }

  Widget mainBody(){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15, left: 15,right: 15),
            child: Text('Products',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 15),
            itemBuilder: (BuildContext context,int index){
              return InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(imagePath: listImageURL[index], productDetails: 'Nothing', productId: '10'))),
                child: Container(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Image.network(listImageURL[index])
                      ),
                      const SizedBox(width: 10), 
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Aashirvaad Whole Wheat Atta 10 kg',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            const Text('\u{20B9}180',style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text('\u{20B9}149',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5,top: 2,right: 5,bottom: 2),
                                      decoration: BoxDecoration(color:Colors.green[800],borderRadius: const BorderRadius.all(Radius.circular(2))),
                                      child: Row(
                                        children: const [
                                          Text('4.5',style: TextStyle(color: Colors.white,fontSize: 12)),
                                          SizedBox(width: 5),
                                          Icon(Icons.star,size: 14,color: Colors.white)
                                        ]
                                      )
                                    )
                                  ]
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => updateItemCount('down'),
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red[50]),
                                        child: const Icon(Icons.remove,size: 22),
                                      )
                                    ),
                                    Text(itemCount.toString(),style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                                    InkWell(
                                      onTap: () => updateItemCount('up'),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 8,right: 10),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green[50]),
                                        child: const Icon(Icons.add,size: 22),
                                      )
                                    )
                                  ]
                                )
                              ]
                            )
                          ]
                        )
                      )
                    ]
                  )
                )
              );
            },
            separatorBuilder: (context,index) => Divider(height: 1,thickness: 1,color: Colors.grey[300]), 
            itemCount: listImageURL.length
          ),
          Divider(height: 1,thickness: 1,color: Colors.grey[400]), 
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Deliver Location',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () => print('Click Here to Change Address'),
                      child: const Text('Change Address',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue)),
                    )
                  ]
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      child: Icon(Icons.location_pin,color: Colors.white),
                      backgroundColor: Colors.green
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Ali Hasan',style: TextStyle(color: Colors.black,fontSize: 14)),
                          SizedBox(height: 2),
                          Text('MOH - Wali Ganj Infront of Badi Masjid, Arrah, Bhojpur Bihar 802301',style: TextStyle(color: Colors.black,fontSize: 12)),
                          SizedBox(height: 2),
                          Text('9760656467',style: TextStyle(color: Colors.black,fontSize: 12))
                        ]
                      )
                    )
                  ]
                )
              ]
            )
          ),
          Divider(height: 1,thickness: 1,color: Colors.grey[400]),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Subtotal',style: TextStyle(fontSize: 12)),
                    Text('745.00',style: TextStyle(fontWeight: FontWeight.normal))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Delivery',style: TextStyle(fontSize: 12)),
                    Text('50.00',style: TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('GST',style: TextStyle(fontSize: 12)),
                    Text('5.00',style: TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Coupon Discount',style: TextStyle(fontSize: 12)),
                    Text('-10.00',style: TextStyle(fontSize: 12,color: Colors.green))
                  ]
                ),
                const SizedBox(height: 10),
                CustomPaint(size: const Size(double.infinity, 0),painter: DashedLineVerticalPainter(line: 'horizontal',lineColor: Colors.grey,type: 'dash')),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Total',style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\u{20B9}790',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                  ]
                )
              ]
            )
          )
        ]
      )
    );
  }

  updateItemCount(String type){
    setState(() {
      if(type == 'down' && (itemCount > 1)){
        itemCount-=1;
      }
      if(type == 'up' && itemCount < 30){
        itemCount+=1;
      }
    });
  }
}