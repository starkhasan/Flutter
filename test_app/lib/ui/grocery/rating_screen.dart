import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

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
  var imagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Write Review',style: TextStyle(color: Colors.black,fontSize: 14)),
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
              const  Expanded(child: Text('Aashirvaad Whole Wheat Atta 10 kg',style: TextStyle(fontSize: 14))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.12,
                child: Image.network(widget.imagePath),
              )
            ]
          ),
          const SizedBox(height: 10),
          const Text('Rate your experience',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold)),
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
          const Text('Review Title',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold)),
          TextField(
            keyboardType: TextInputType.text,
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Ex. Job Done Successfully',hintStyle: TextStyle(color: Colors.grey,fontSize: 14)),
          ),
          const SizedBox(height: 20),
          const Text('Write Review',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold)),
          TextField(
            keyboardType: TextInputType.text,
            controller: reviewController,
            maxLength: 300,
            maxLines: null,
            decoration: const InputDecoration(hintText: 'Write your experience',hintStyle: TextStyle(color: Colors.grey,fontSize: 14)),
          ),
          const SizedBox(height: 10),
          imagePath.isEmpty
           ? InkWell(
              onTap: ()  async {
                var source = await chooseImageSource();
                uploadImageFile(context,source);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
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
              )
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Attached Photo',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 15,top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(File(imagePath)),
                      ),
                      InkWell(
                        onTap: () => setState(() => imagePath = ''),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.red[50],border: Border.all(width: 1.0,color: Colors.red),borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                          child: const Text('Remove',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 13))
                        ),
                      )
                    ]
                  ),
                )
              ]
            ),
          InkWell(
            onTap: () => print('Click Here to Publish Review'),
            child: Container(
              margin: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 15),
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              decoration: const BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Center(child: Text('Publish Review',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)))
            )
          )
        ]
      )
    );
  }

  Future<ImageSource> chooseImageSource() async{
    var source = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: const Text('Choose Image Source',style: TextStyle(fontSize: 14)),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context,ImageSource.camera),
              child: const Text('Camera',style: TextStyle(fontSize: 14))
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: const Text('Gallery',style: TextStyle(color: Colors.red,fontSize: 14))
            )
          ]
        );
      }
    );
    return source;
  }

  Future<void> uploadImageFile(BuildContext _context,ImageSource imgSource) async{
    var photo = await ImagePicker().pickImage(source: imgSource);
    if(photo!=null){
      setState(() {
        imagePath = photo.path;
      });
    }
  }
}