import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatefulWidget {
  final String productId;
  final String imagePath;
  final double productRating;
  const RatingScreen({ Key? key,required this.productId,required this.imagePath,required this.productRating}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {

  var newRating = 0.0;
  var titleController = TextEditingController();
  var reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Write Review',style: TextStyle(color: Colors.black)),
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            leading: IconButton(onPressed: () => Navigator.pop(context),icon: const Icon(Icons.arrow_back,color: Colors.black),),
          ),
          SliverList(delegate: SliverChildListDelegate([mainBody()]))
        ]
      )
    );
  }

  Widget mainBody(){
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Aashirvaad Whole Wheat Atta 10 kg',style: TextStyle(fontSize: 16)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.12,
                child: Image.network(widget.imagePath),
              )
            ]
          ),
          const SizedBox(height: 10),
          const Text('Rate your experience',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          RatingBar.builder(
            initialRating: widget.productRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            glowColor: Colors.white,
            glowRadius: 0.0,
            itemCount: 5,
            itemSize: 40.0,
            itemPadding: EdgeInsets.zero,
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) => newRating = rating,
          ),
          const SizedBox(height: 20),
          const Text('Review Title',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
          TextField(
            keyboardType: TextInputType.text,
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Ex. Job Done Successfully',hintStyle: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 20),
          const Text('Write Review',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
          TextField(
            keyboardType: TextInputType.text,
            controller: reviewController,
            maxLength: 300,
            maxLines: null,
            decoration: const InputDecoration(hintText: 'Write your experience',hintStyle: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => print('Click Here to select image file'),
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(top: 12,bottom: 12),
              decoration: BoxDecoration(color: Colors.green[100],borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.attach_file,size: 20),
                  SizedBox(height: 5),
                  Text('Attach Photo',style: TextStyle(fontWeight: FontWeight.bold))
                ]
              )
            ),
          ),
          InkWell(
            onTap: () => print('Click Here to Publish Review'),
            child: Container(
              margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              decoration: const BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Center(child: Text('Publish Review',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)))
            ),
          ),
        ]
      )
    );
  }
}