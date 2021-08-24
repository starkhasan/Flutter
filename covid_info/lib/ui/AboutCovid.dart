import 'package:flutter/material.dart';
import 'package:covid_info/constant/HelperAbout.dart';
import 'package:flutter/services.dart';
class AboutCovid extends StatefulWidget {

  @override
  _AboutCovidState createState() => _AboutCovidState();
}

class _AboutCovidState extends State<AboutCovid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers:[
          SliverAppBar(
            backgroundColor: Color(0xFF0B3054),
            centerTitle: true,
            floating: true,
            title: Text('COVID',style: TextStyle(fontSize: 16)),
            expandedHeight: kToolbarHeight,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              infoWidget()
            ])
          )
        ]
      )
    );
  }

  Widget infoWidget(){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is COVID-19',
            style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: HelperAbout.aboutCrona1
                ),
                TextSpan(
                  text: HelperAbout.aboutCrona2
                )
              ]
            ),
          ),
          Text(
            '\nSymptoms of COVID-19',
            style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
          ),
          Text(
            HelperAbout.aboutSymptoms1,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            '\nMost common symptoms',
            style: TextStyle(color: Colors.black),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            physics: NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listCommonSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.amber,size: 10),
                    SizedBox(width: 5),
                    Text(HelperAbout.listCommonSymptoms[index],style: TextStyle(color: Colors.black))
                  ]
                )
              );
            }
          ),
          Text(
            '\nLess  common symptoms',
            style: TextStyle(color: Colors.black),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            physics: NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listLessSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.green,size: 10),
                    SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listLessSymptoms[index],style: TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          ),
          Text(
            '\nSerious common symptoms',
            style: TextStyle(color: Colors.black),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            physics: NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listSeriousSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.red,size: 10),
                    SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listSeriousSymptoms[index],style: TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          ),
          Text(
            HelperAbout.aboutSymptoms2,
            style: TextStyle(color: Colors.black)
          ),
          SizedBox(height: 20),
          Center(child: Image.asset('assets/images/symptoms.jpg',height: MediaQuery.of(context).size.height * 0.15)),
          SizedBox(height: 20),
          Text(
            'Prevention of COVID-19',
            style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold,fontFamily: '')
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            physics: NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listPreventation.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.circle,color: Colors.blue,size: 10),
                    SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listPreventation[index],style: TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          ),
          Center(child: Image.asset('assets/images/prevention.jpg',height: MediaQuery.of(context).size.height * 0.40,width: MediaQuery.of(context).size.width * 0.70))
        ]
      )
    );
  }
}