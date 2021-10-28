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
            title: Text('About',style: TextStyle(fontSize: 16)),
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
            'What is Corona',
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2),
          Text(
            HelperAbout.aboutCrona
          ),
          Text(
            '\nSymptoms',
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2),
          Text(
            HelperAbout.aboutSymptoms1,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            '\nLess  common symptoms',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 5,top: 2),
            physics: NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listLessSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.green,size: 8),
                    SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listLessSymptoms[index],style: TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          ),
          Text(
            '\nMost common symptoms',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 5,top: 2),
            physics: NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listCommonSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.amber,size: 8),
                    SizedBox(width: 5),
                    Text(HelperAbout.listCommonSymptoms[index],style: TextStyle(color: Colors.black))
                  ]
                )
              );
            }
          ),
          Text(
            '\nSerious common symptoms',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 5,top: 2),
            physics: NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listSeriousSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.red,size: 8),
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
            'Prevention',
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 5,top: 2),
            physics: NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listPreventation.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.blue,size: 8),
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