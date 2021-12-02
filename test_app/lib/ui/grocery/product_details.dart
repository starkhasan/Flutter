import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  final String imagePath;
  final String productDetails;
  final String productId;
  const ProductDetails({ Key? key,required this.imagePath,required this.productDetails,required this.productId}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

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
          child: const Center(child: Text('Add to Cart',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)))
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Product Details',style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            floating: true,
            snap: true,
            leading: IconButton(onPressed: () => Navigator.pop(context),icon: const Icon(Icons.arrow_back,color:Colors.black)),
          ),
          SliverList(delegate: SliverChildListDelegate([mainBody()]))
        ],
      ),
    );
  }

  Widget mainBody(){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: PageView.builder(
                  itemCount: listImageURL.length,
                  itemBuilder: (BuildContext contex,int index) => Container(color: Colors.transparent,child: Image.network(listImageURL[index])),
                  onPageChanged: (int index) {
                    currentPageNotifier.value = index;
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CirclePageIndicator(
                  itemCount: listImageURL.length,
                  currentPageNotifier: currentPageNotifier,
                ),
              )
            ]
          ),
          Container(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aashirvaad Whole Wheat Atta 10 kg',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('\u{20B9}300',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 5,top: 2,right: 5,bottom: 2),
                          decoration: BoxDecoration(color:Colors.green[800],borderRadius: const BorderRadius.all(Radius.circular(2))),
                          child: Row(
                            children: const [
                              Text('4.5',style: TextStyle(color: Colors.white)),
                              SizedBox(width: 5),
                              Icon(Icons.star,size: 15,color: Colors.white)
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
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red[50]),
                            child: const Icon(Icons.remove),
                          )
                        ),
                        Text(itemCount.toString(),style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: () => updateItemCount('up'),
                          child: Container(
                            margin: const EdgeInsets.only(left: 8,right: 10),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green[50]),
                            child: const Icon(Icons.add),
                          )
                        )
                      ],
                    )
                  ]
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined,color: Colors.red,size: 24),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Manufactured date 02 Nov 2021',style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Best Before 29 July 2022',style: TextStyle(color: Colors.grey,fontSize: 12))
                      ]
                    )
                  ]
                )
              ]
            )
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 1,thickness: 1,color: Colors.grey[300]),
                InkWell(
                  onTap: () => print('Click Here to see all details'),
                  child: Container(
                    padding: const EdgeInsets.only(top: 12,bottom: 12,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('All Details'),
                        Icon(Icons.arrow_forward_ios_rounded,size: 20)
                      ]
                    )
                  )
                ),
                Divider(height: 1,thickness: 1,color: Colors.grey[300]),
                Container(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,right: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Description'),
                      SizedBox(width: 10),
                      Expanded(child: Text("If you are interested in getting home a double-door fridge, this LG convertible refrigerator should feature on your list. The Inverter Linear Compressor of this refrigerator moderates the internal temperatures across the fridge and makes it highly energy-efficient."))
                    ]
                  ),
                )
              ]
            )
          ),
          Divider(height: 1,thickness: 1,color: Colors.grey[400]), 
          const Padding(
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Text('You can also check this item',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 20,top: 15),
            itemBuilder: (BuildContext context,int index){
              return Container(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Image.network(listImageURL[index]),
                    ),
                    const SizedBox(width: 10), 
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Aashirvaad Whole Wheat Atta 10 kg',style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          const Text('\u{20B9}180',style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text('\u{20B9}300',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal)),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.only(left: 5,top: 2,right: 5,bottom: 2),
                                decoration: BoxDecoration(color:Colors.green[800],borderRadius: const BorderRadius.all(Radius.circular(2))),
                                child: Row(
                                  children: const [
                                    Text('4.5',style: TextStyle(color: Colors.white)),
                                    SizedBox(width: 5),
                                    Icon(Icons.star,size: 15,color: Colors.white)
                                  ]
                                )
                              )
                            ]
                          )
                        ]
                      ),
                    )
                  ]
                )
              );
            },
            separatorBuilder: (context,index) => Divider(height: 1,thickness: 1,color: Colors.grey[300]), 
            itemCount: listImageURL.length
          )
        ]
      ),
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