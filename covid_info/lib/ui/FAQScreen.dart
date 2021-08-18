import 'package:covid_info/constant/HelperFAQ.dart';
import 'package:covid_info/model/provider/CovidStatusProvider.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    subHeaderLeftMargin = MediaQuery.of(context).size.width * 0.035;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers:[
          SliverAppBar(
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
      itemCount: HelperFAQ.listHeading.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
        return Card(
          shadowColor: HelperFAQ.listSubHeading[index] == 'Corona' ? Colors.red[400] : Colors.green[400],
          elevation: 2.0,
          child: ExpansionTile(
            title: Text(HelperFAQ.listHeading[index],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal)),
            subtitle: Text(HelperFAQ.listSubHeading[index],style: TextStyle(fontStyle: FontStyle.italic,color: HelperFAQ.listSubHeading[index] == 'Corona' ? Colors.red : Colors.green)),
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(subHeaderLeftMargin, 0, 10, 10),
                child: Text(HelperFAQ.answer[index])
              )
            ]
          )
        );
      }
    );
  }
}
