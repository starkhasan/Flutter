import 'package:flutter/material.dart';
import 'package:flutter_provider/model/comment_response.dart';
import 'package:flutter_provider/provider/comment_provider.dart';
import 'package:flutter_provider/provider/counter_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_provider/view/edit_comment.dart';
import 'dart:math';

class MultiProviderExample extends StatelessWidget {
  const MultiProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider())
      ],
      child: const MainScreenMultiProvider()
    );
  }
}

class MainScreenMultiProvider extends StatefulWidget {
  const MainScreenMultiProvider({Key? key}) : super(key: key);

  @override
  MainScreenMultiProviderState createState() => MainScreenMultiProviderState();
}

class MainScreenMultiProviderState extends State<MainScreenMultiProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('MultiProvider Example',style: TextStyle(fontSize: 14))),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Selector<CounterProvider, Tuple2<int, CounterProvider>>(
              builder: (context, provider,child){
                return Container(
                  padding: const EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(provider.item1.toString(),style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                      ElevatedButton(onPressed: () => provider.item2.increment(), child: const Icon(Icons.add))
                    ]
                  )
                );
              },
              selector: (context, counterProvider) => Tuple2(counterProvider.count, counterProvider),
              shouldRebuild: (previous, next) => true
            ),
            Selector<CommentProvider, Tuple2<List<CommentResponse>,CommentProvider>>(
              builder: (context, provider, child){
                return Expanded(
                  child: provider.item1.isEmpty
                  ? const Center(child: Text('No Data Found'))
                  : ListView.builder(
                    itemCount: provider.item1.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      var data = provider.item1;
                      return Container(
                        margin: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [BoxShadow(blurRadius: 2.0,color: Colors.grey)]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                      Text(data[index].email,style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)),
                                    ]
                                  )
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                  child: Center(child: Text(data[index].name.substring(0,1).toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20))),
                                )
                              ]
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(data[index].body,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal))
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditComment(response: data[index],isUpdate: true))).then((value) {
                                          if(value is! bool){
                                            provider.item2.updateComment(value, index);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue[50]
                                        ),
                                        child: const Icon(Icons.edit,color: Colors.blue,size: 20)
                                      )
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () => {
                                        provider.item2.deleteComment(index),
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red[50]
                                        ),
                                        child: const Icon(Icons.delete_outline_outlined,color: Colors.red,size: 20)
                                      )
                                    )
                                  ]
                                )
                              ]
                            )
                          ]
                        )
                      );
                    }
                  ) 
                );
              }, 
              selector: (context, provider) => Tuple2(provider.commentResponse, provider),
              shouldRebuild: (previous, next) => true 
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CommentProvider>().comments(),
        child: const Icon(Icons.download)
      )
    );
  }
}
