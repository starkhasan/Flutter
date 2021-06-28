import 'package:flutter/material.dart';

class HelperAbout {
  HelperAbout._();
  static var listCommonSymptoms = ['Fever','Dry Cough','Tiredness'];
  static var listLessSymptoms = ['Aches & Pains','Sore throat','Diarrhoea','Conjunctivitis','Headache','Loss of taste or smell','A rash on skin, or discolouration of fingers or toes'];
  static var listSeriousSymptoms = ['Difficulty breathing or shortness of breath','Chest pain or pressure','Loss of speech or movement'];
  static var listPreventation = [
    'Wash your hands regularly with soap and water, or clean them with alcohol-based hand rub',
    'Maintain at least 1 metre distance between you and people coughing or sneezing',
    'Avoid touching your face',
    'Cover your mouth and nose when coughing or sneezing',
    'Stay home if you feel unwell',
    'Refrain from smoking and other activities that weaken the lungs',
    'Practice physical distancing by avoiding unnecessary travel and staying away from large groups of people'
  ];

  static var listIcons = [
    Icon(Icons.stacked_line_chart_outlined,color: Colors.blue,size: 40),
    Icon(Icons.verified_user_rounded,color: Colors.green,size: 40),
    Icon(Icons.health_and_safety,color: Colors.red,size: 40),
    Icon(Icons.hotel,color: Colors.red,size: 40)
  ];

  static var listTags = [
    'Total Confirmed',
    'Total Recovered',
    'Total Active',
    'Total Deaths'
  ];
}
