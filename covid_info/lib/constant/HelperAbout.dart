import 'package:flutter/material.dart';

class HelperAbout {
  HelperAbout._();
  static var aboutCrona = 'Coronavirus disease 2019 (COVID-19) is a contagious disease caused by severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2). The first known case was identified in Wuhan, China in December 2019.[7] The disease has since spread worldwide, leading to an ongoing pandemic\nSARS‑CoV‑2 belongs to the broad family of viruses known as coronaviruses. It is a positive-sense single-stranded RNA (+ssRNA) virus, with a single linear RNA segment. Coronaviruses infect humans, other mammals, and avian species, including livestock and companion animals. Human coronaviruses are capable of causing illnesses ranging from the common cold to more severe diseases such as Middle East respiratory syndrome (MERS, fatality rate ~34%).';
  static var aboutSymptoms1 = 'COVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization';
  static var aboutSymptoms2 = '\nSeek immediate medical attention if you have serious symptoms. Always call before visiting your doctor or health facility.\nPeople with mild symptoms who are otherwise healthy should manage their symptoms at home.\nOn average it takes 5–6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.';
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
    Icon(Icons.groups,color: Colors.teal,size: 40),
    Icon(Icons.content_paste_rounded,color: Colors.blue,size: 40),
    Icon(Icons.verified_user_rounded,color: Colors.green,size: 40),
    Icon(Icons.health_and_safety,color: Colors.amber,size: 40),
    Icon(Icons.hotel,color: Colors.red,size: 40),
    Icon(Icons.gpp_maybe_rounded,color: Colors.red,size: 40),
    Icon(Icons.person_add_alt_sharp,color: Colors.blue,size: 40),
    Icon(Icons.person_add_alt_sharp,color: Colors.red,size: 40),
  ];

  static var listTags = [
    'Total Population',
    'Total Confirmed',
    'Total Recovered',
    'Total Active',
    'Total Deaths',
    'Critical Cases',
    'New Cases',
    'New Deaths'
  ];

  static var listIconsVaccine = [
    Icon(Icons.computer_rounded,color: Colors.blue,size: 40),
    Icon(Icons.groups,color: Colors.teal,size: 40),
    Icon(Icons.verified_user_rounded,color: Colors.amber,size: 40),
    Icon(Icons.verified_user_rounded,color: Colors.green,size: 40)
  ];

  static var listVaccineTag = [
    'Total Registrations',
    'Total Vaccinations',
    'Dose 1',
    'Dose 2',
  ];
}
