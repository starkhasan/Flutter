import 'package:flutter_provider/model/comment_response.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class EditComment extends StatefulWidget {
  final CommentResponse? response;
  final bool isUpdate;
  const EditComment({Key? key,this.response,required this.isUpdate}) : super(key: key);

  @override
  State<EditComment> createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var commentController = TextEditingController();
  late CommentResponse editComment;

  @override
  void initState() {
    if(widget.isUpdate){
      nameController = TextEditingController(text: widget.response!.name);
      emailController = TextEditingController(text: widget.response!.email);
      commentController = TextEditingController(text: widget.response!.body);
      editComment = widget.response!;
    } else{
      editComment = CommentResponse(postId: 0, id: 0, name: '', email: '', body: '');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isUpdate ? 'Edit Comment' : 'Add Comment',style: const TextStyle(fontSize: 14)),
        leading: IconButton(onPressed: () => Navigator.pop(context, false),icon: Transform.rotate(angle: math.pi / 4,child: const Icon(Icons.add,size: 30))),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name*'
              )
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email*'
              )
            ),
            const SizedBox(height: 10),
            TextField(
              controller: commentController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Comment*'
              )
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(validation(context)){
                  editComment.name = nameController.text;
                  editComment.email = emailController.text;
                  editComment.body = commentController.text;
                  Navigator.pop(context,editComment);
                }
              },
              child: Text(widget.isUpdate ? 'Edit Comment' : 'Add Comment')
            )
          ]
        )
      )
    );
  }

  bool validation(BuildContext context) {
    if(nameController.text.isEmpty){
      showSnackbar(context, "Name can't be empty");
      return false;
    }else if(emailController.text.isEmpty){
      showSnackbar(context, "Email can't be empty");
      return false;
    } else if(commentController.text.isEmpty){
      showSnackbar(context, "Comment can't be empty");
      return false;
    } else{
      return true;
    }
  }

  void showSnackbar(BuildContext context,String message){
    var snackBar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
