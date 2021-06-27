import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/HomeDrawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var _currentIndex = 0;
  var _listCommonSymptoms = ['Fever','Dry Cough','Tiredness'];
  var _listLessSymptoms = ['Aches & Pains','Sore throat','Diarrhoea','Conjunctivitis','Headache','Loss of taste or smell','A rash on skin, or discolouration of fingers or toes'];
  var _listSeriousSymptoms = ['Difficulty breathing or shortness of breath','Chest pain or pressure','Loss of speech or movement'];
  var _listPreventation = [
    'Wash your hands regularly with soap and water, or clean them with alcohol-based hand rub',
    'Maintain at least 1 metre distance between you and people coughing or sneezing',
    'Avoid touching your face',
    'Cover your mouth and nose when coughing or sneezing',
    'Stay home if you feel unwell',
    'Refrain from smoking and other activities that weaken the lungs',
    'Practice physical distancing by avoiding unnecessary travel and staying away from large groups of people'
  ]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState((){_currentIndex = _currentIndex == 0 ? 1 : 0;}),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: 'Photo',
            icon: Icon(Icons.photo)
          )
        ]
      ),
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            centerTitle: true,
            floating: true,
            title: Text('Hello'),
            expandedHeight: kToolbarHeight
          ),
          SliverList(
            delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What is COVID-19',
                        style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\nCoronavirus disease 2019 (COVID-19) is a contagious disease caused by severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2). The first known case was identified in Wuhan, China in December 2019.[7] The disease has since spread worldwide, leading to an ongoing pandemic\n',
                              style: TextStyle(color: Colors.black)
                            ),
                            TextSpan(
                              text: '\nSARS‑CoV‑2 belongs to the broad family of viruses known as coronaviruses. It is a positive-sense single-stranded RNA (+ssRNA) virus, with a single linear RNA segment. Coronaviruses infect humans, other mammals, and avian species, including livestock and companion animals. Human coronaviruses are capable of causing illnesses ranging from the common cold to more severe diseases such as Middle East respiratory syndrome (MERS, fatality rate ~34%).',
                              style: TextStyle(color: Colors.black)
                            )
                          ]
                        ),
                      ),
                      Text(
                        '\nSymptoms of COVID-19',
                        style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
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
                        itemCount: _listCommonSymptoms.length,
                        itemBuilder: (context,index){
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.circle,color: Colors.yellow,size: 15),
                                SizedBox(width: 5),
                                Text(_listCommonSymptoms[index],style: TextStyle(color: Colors.black))
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
                        itemCount: _listLessSymptoms.length,
                        itemBuilder: (context,index){
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.circle,color: Colors.green,size: 15),
                                SizedBox(width: 5),
                                Text(_listLessSymptoms[index],style: TextStyle(color: Colors.black))
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
                        itemCount: _listSeriousSymptoms.length,
                        itemBuilder: (context,index){
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.circle,color: Colors.red,size: 15),
                                SizedBox(width: 5),
                                Text(_listSeriousSymptoms[index],style: TextStyle(color: Colors.black))
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
                        style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(5),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _listPreventation.length,
                        itemBuilder: (context,index){
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.circle,color: Colors.blue,size: 15),
                                SizedBox(width: 5),
                                Flexible(child: Text(_listPreventation[index],style: TextStyle(color: Colors.black)))
                              ]
                            )
                          );
                        }
                      )
                    ]
                  ),
                )
              ]
            ),
          )
        ]
      )
    );
  }
}