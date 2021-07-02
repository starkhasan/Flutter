import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class ShowDocument extends StatefulWidget {
  final String url;
  ShowDocument({required this.url});
  @override
  _ShowDocumentState createState() => _ShowDocumentState();
}

class _ShowDocumentState extends State<ShowDocument> {

  late PDFDocument document;
  bool _isLoading = true;
  bool _dataNotFound = false;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async{
    try{
      document = await PDFDocument.fromURL(widget.url);
    }catch(e){
      _dataNotFound = true;
    }
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'States Vaccination Report',
          style: TextStyle(fontSize: 16)
        )
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _isLoading
          ? CircularProgressIndicator()
          : _dataNotFound
            ? Text('States vaccination data not available.')
            : PDFViewer(
            document: document,
            zoomSteps: 1
          )
        )
      ),
    );
  }
}