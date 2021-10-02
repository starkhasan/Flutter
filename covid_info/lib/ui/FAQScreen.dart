import 'package:covid_info/constant/HelperFAQ.dart';
import 'package:covid_info/model/provider/CovidStatusProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CovidStatusProvider>(
      create: (context) => CovidStatusProvider(),
      child: Consumer<CovidStatusProvider>(
        builder: (context, covidProvider, child) {
          return MainScreen(provider: covidProvider);
        }
      )
    );
  }
}

class MainScreen extends StatefulWidget {
  final CovidStatusProvider provider;
  MainScreen({required this.provider});
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {

  var subHeaderLeftMargin = 0.0;
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    subHeaderLeftMargin = MediaQuery.of(context).size.width * 0.035;
  }

  _scrollListener(){
    if (_scrollController.offset > _scrollController.position.viewportDimension) {
      if(!widget.provider.faqFABVisible) widget.provider.fabVisibility();
    } else if(widget.provider.faqFABVisible){
      widget.provider.fabVisibility();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.provider.faqFABVisible
        ? FloatingActionButton(
            backgroundColor: Color(0xFF0B3054),
            onPressed: () => _scrollController.animateTo(0.0, duration: Duration(seconds: 1), curve: Curves.bounceInOut),
            child: Icon(Icons.arrow_upward_sharp,size: 22),
            mini: false
          )
        : null,
      body: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers:[
          SliverAppBar(
            backgroundColor: Color(0xFF0B3054),
            centerTitle: true,
            floating: true,
            title: Text('FAQs',style: TextStyle(fontSize: 16)),
            expandedHeight: kToolbarHeight,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              faqWidget()
            ])
          )
        ]
      )
    );
  }

  Widget faqWidget(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: HelperFAQ.listHeading.length,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      itemBuilder: (context,index){
        return Container(
          margin: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0XFFBDBDBD),
                blurRadius: 1.0
              )
            ]
          ),
          child: ExpansionTile(
            title: Text(HelperFAQ.listHeading[index],style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal)),
            subtitle: Text(HelperFAQ.listSubHeading[index],style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic,color: HelperFAQ.listSubHeading[index] == 'Corona' ? Colors.red : Colors.green)),
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(subHeaderLeftMargin, 0, 10, 10),
                child: Text(HelperFAQ.answer[index],style: TextStyle(fontSize: 12))
              )
            ]
          )
        );
      }
    );
  }

}
