class FAQResponse {
  String tag;
  String question;
  String answer;

  FAQResponse({required this.tag, required this.question, required this.answer});

  factory FAQResponse.fromJson(Map<String, dynamic> json){
    return FAQResponse(
      tag: json['tag'],
      question: json['question'],
      answer: json['answer']
    );
  }
}
