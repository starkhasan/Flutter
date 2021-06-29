import 'package:flutter/material.dart';
import 'package:covid_info/constant/HelperAbout.dart';
class AboutCovid extends StatefulWidget {

  @override
  _AboutCovidState createState() => _AboutCovidState();
}

class _AboutCovidState extends State<AboutCovid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            centerTitle: true,
            floating: true,
            title: Text('About Covid'),
            expandedHeight: kToolbarHeight
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is COVID-19',
            style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: ''),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black,fontFamily: 'PoppinsRegular'),
              children: [
                TextSpan(
                  text: '\nCoronavirus disease 2019 (COVID-19) is a contagious disease caused by severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2). The first known case was identified in Wuhan, China in December 2019.[7] The disease has since spread worldwide, leading to an ongoing pandemic\n'
                ),
                TextSpan(
                  text: '\nSARS‑CoV‑2 belongs to the broad family of viruses known as coronaviruses. It is a positive-sense single-stranded RNA (+ssRNA) virus, with a single linear RNA segment. Coronaviruses infect humans, other mammals, and avian species, including livestock and companion animals. Human coronaviruses are capable of causing illnesses ranging from the common cold to more severe diseases such as Middle East respiratory syndrome (MERS, fatality rate ~34%).'
                )
              ]
            ),
          ),
          Text(
            '\nSymptoms of COVID-19',
            style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: ''),
          ),
          Text(
            '\nCOVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization',
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
                  children: [
                    Icon(Icons.circle,color: Colors.yellow,size: 15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.circle,color: Colors.green,size: 15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.circle,color: Colors.red,size: 15),
                    SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listSeriousSymptoms[index],style: TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          ),
          Text(
            '\nSeek immediate medical attention if you have serious symptoms. Always call before visiting your doctor or health facility.\n\nPeople with mild symptoms who are otherwise healthy should manage their symptoms at home.\n\nOn average it takes 5–6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.',
            style: TextStyle(color: Colors.black)
          ),
          Text(
            '\nPrevention of COVID-19',
            style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: ''),
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
                    Icon(Icons.circle,color: Colors.blue,size: 15),
                    SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listPreventation[index],style: TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          )
        ]
      ),
    );
  }
}