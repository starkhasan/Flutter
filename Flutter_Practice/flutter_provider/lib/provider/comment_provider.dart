import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_provider/model/comment_response.dart';
import 'package:flutter_provider/model/api.dart';

class CommentProvider extends ChangeNotifier {
  bool _isLoading = false;
  int _commentCount = 0;
  bool get loading => _isLoading;
  int get count => _commentCount;
  List<CommentResponse> commentResponse = [];

  Future<void> comments() async {
    _isLoading = true;
    notifyListeners();
    try {
      var response = await Api.getComments();
      if (response.statusCode == 200) {
        commentResponse = List<CommentResponse>.from(jsonDecode(response.body)
            .map((item) => CommentResponse.fromJson(item)));
        _commentCount = commentResponse.length;
      }
    } catch (e) {
      commentResponse = [];
      _commentCount = 0;
    }
    _isLoading = false;
    notifyListeners();
  }

  void deleteComment(int index) {
    commentResponse.removeAt(index);
    _commentCount = commentResponse.length;
    notifyListeners();
  }

  void updateComment(CommentResponse response, int index) {
    commentResponse[index] = response;
    notifyListeners();
  }

  void addComment(CommentResponse response) {
    response.id = commentResponse[commentResponse.length-1].id + 1;
    response.postId = commentResponse[commentResponse.length-1].id + 1;
    commentResponse.insert(0, response);
    _commentCount = commentResponse.length;
    notifyListeners();
  }
}
