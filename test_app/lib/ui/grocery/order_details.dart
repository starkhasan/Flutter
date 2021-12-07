import 'package:flutter/material.dart';
import 'package:test_app/ui/grocery/rating_screen.dart';
import 'package:test_app/utils/dash_line.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderDetails extends StatefulWidget {
  final String imagePath;
  const OrderDetails({ Key? key,required this.imagePath}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  
  final currentPageNotifier = ValueNotifier<int>(0);
  var itemCount = 1;
  var productRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Order #OD0011238514',style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            floating: true,
            snap: true,
            leading: IconButton(onPressed: () => Navigator.pop(context),icon: const Icon(Icons.arrow_back,color:Colors.black))
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
            padding: EdgeInsets.all(15),
            child: Text('Delivery Completed',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold))
          ),
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Aashirvaad Whole Wheat Atta 10 kg',style: TextStyle(fontSize: 16)),
                    SizedBox(height: 2),
                    Text('\u{20B9}300',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold))
                  ]
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Image.network(widget.imagePath),
                )
              ]
            )
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.circle,color: Colors.green,size: 15),
                        CustomPaint(size: const Size(0, 40),painter: DashedLineVerticalPainter(line: 'vertical',lineColor: Colors.green,type: 'solid'))
                      ]
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Ordered',style: TextStyle(fontSize: 14,color: Colors.black)),
                          Text('15 Aug 2021',style: TextStyle(fontSize: 12,color: Colors.grey))
                        ]
                      )
                    )
                  ]
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.circle,color: Colors.green,size: 15),
                        CustomPaint(size: const Size(0, 40),painter: DashedLineVerticalPainter(line: 'vertical',lineColor: Colors.green,type: 'solid'))
                      ]
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Packing',style: TextStyle(fontSize: 14,color: Colors.black)),
                          Text('15 Aug 2021',style: TextStyle(fontSize: 12,color: Colors.grey))
                        ]
                      )
                    )
                  ]
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.circle,color: Colors.green,size: 15),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Delivered',style: TextStyle(fontSize: 14,color: Colors.black)),
                          Text('16 Aug 2021',style: TextStyle(fontSize: 12,color: Colors.grey))
                        ]
                      )
                    )
                  ]
                )
              ]
            )
          ),
          Container(
            margin: const EdgeInsets.all(15),
            height: 48,
            decoration: BoxDecoration(color: Colors.green[100],borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: const Center(child: Text('Delivery Details',style: TextStyle(fontWeight: FontWeight.bold,)))
          ),
          Container(
            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
            height: 48,
            decoration: BoxDecoration(color: Colors.green[100],borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: const Center(child: Text('Show Full Package',style: TextStyle(fontWeight: FontWeight.bold,)))
          ),
          Divider(height: 1,thickness: 1,color: Colors.grey[400]), 
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Deliver Man',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          child: Icon(Icons.person,color: Colors.white),
                          backgroundColor: Colors.green
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Ali Hasan',style: TextStyle(color: Colors.black,fontSize: 16)),
                            Text('9760656467',style: TextStyle(color: Colors.black,fontSize: 12))
                          ]
                        )
                      ]
                    ),
                    InkWell(
                      onTap: () => print('Click Here to call'),
                      child: Container(
                        margin: const EdgeInsets.only(left: 8,right: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red[50]),
                        child: const Icon(Icons.phone,color: Colors.red)
                      )
                    )
                  ]
                )
              ]
            )
          ),
          Divider(height: 1,thickness: 1,color: Colors.grey[400]), 
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Deliver Location',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
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
                          Text('Ali Hasan',style: TextStyle(color: Colors.black,fontSize: 16)),
                          SizedBox(height: 2),
                          Text('MOH - Wali Ganj Infront of Badi Masjid, Arrah, Bhojpur Bihar 802301',style: TextStyle(color: Colors.black,fontSize: 12)),
                          SizedBox(height: 2),
                          Text('9760656467',style: TextStyle(color: Colors.black,fontSize: 12))
                        ]
                      ),
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
                    Text('\u{20B9}300.00',style: TextStyle(fontWeight: FontWeight.normal))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Delivery',style: TextStyle(fontSize: 12)),
                    Text('\u{20B9}50.00',style: TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('GST',style: TextStyle(fontSize: 12)),
                    Text('\u{20B9}5.00',style: TextStyle(fontSize: 12))
                  ]
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Coupon Discount',style: TextStyle(fontSize: 12)),
                    Text('\u{20B9}-10.00',style: TextStyle(fontSize: 12,color: Colors.green))
                  ]
                ),
                const SizedBox(height: 10),
                CustomPaint(size: const Size(double.infinity, 0),painter: DashedLineVerticalPainter(line: 'horizontal',lineColor: Colors.grey,type: 'dash')),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Total',style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\u{20B9}345',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                  ],
                )
              ]
            )
          ),
          Divider(height: 1,thickness: 1,color: Colors.grey[400]), 
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rating & Review',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      glowColor: Colors.white,
                      glowRadius: 0.0,
                      itemCount: 5,
                      itemSize: 28.0,
                      itemPadding: EdgeInsets.zero,
                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) => productRating = rating,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RatingScreen(productId: 'Aashirvaad Whole Wheat Atta 10 kg',imagePath: widget.imagePath,productRating: productRating))),
                      child: const Text('Write a Review',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue)),
                    )
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