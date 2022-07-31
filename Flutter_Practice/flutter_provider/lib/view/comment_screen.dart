import 'dart:math';
import 'package:flutter_provider/provider/comment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/view/edit_comment.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<CommentProvider>(
      create: (context) => CommentProvider(),
      child: const MainScreen()
    );
  }
}

class MainScreen extends StatefulWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CommentProvider>(context,listen: false).comments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Consumer<CommentProvider>(
      builder: (context, provider, child){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Comment',style: TextStyle(fontSize: 14)),
            actions: [
              Visibility(visible: provider.count == 0 ? false : true,child: Container(margin: const EdgeInsets.only(right: 20),alignment: Alignment.center,child: Text(provider.count.toString(),style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 14))))
            ]
          ),
          body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              child: ListView.builder(
                itemCount: provider.commentResponse.length,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var data = provider.commentResponse;
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
                                  Text(provider.commentResponse[index].name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                  Text(provider.commentResponse[index].email,style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)),
                                ]
                              )
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                              child: Center(child: Text(provider.commentResponse[index].name.substring(0,1).toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20))),
                            )
                          ]
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(provider.commentResponse[index].body,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal))
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditComment(response: data[index],isUpdate: true))).then((value) {
                                      if(value is! bool){
                                        provider.updateComment(value, index);
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
                                  onTap: () => provider.deleteComment(index),
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
              ), 
              onRefresh: () => provider.comments()
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditComment(isUpdate: false))).then((value) {
                if(value is! bool){
                  provider.addComment(value);
                }
              });
            },
            child: const Icon(Icons.add)
          )
        );
      }
    );
  }

  void showSnackBar(BuildContext context,String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  
}
