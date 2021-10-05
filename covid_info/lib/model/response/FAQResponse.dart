class FAQResponse {
  String tag;
  String question;
  String answer;

  FAQResponse.fromJson(Map<String, dynamic> json)
      : tag = json['tag'],
        question = json['question'],
        answer = json['answer'];
}
