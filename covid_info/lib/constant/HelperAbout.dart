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
    'Population',
    'Confirmed',
    'Recovered',
    'Active',
    'Deaths',
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
    'Registrations',
    'Vaccinations',
    'Dose1',
    'Dose2',
  ];

  static var flagCode = {
    "Andorra": "AD",
     "UAE": "AE",
     "Afghanistan": "AF",
     "Antigua And Barbuda": "AG",
     "Anguilla": "AI",
     "Albania": "AL",
     "Armenia": "AM",
     "Netherlands": "AN",
     "Angola": "AO",
     "Antarctica": "AQ",
     "Argentina": "AR",
     "Samoa": "AS",
     "Austria": "AT",
     "Australia": "AU",
     "Aruba": "AW",
     "Bosnia and Herzegovina": "BA",
     "Barbados": "BB",
     "Bangladesh": "BD",
     "Belgium": "BE",
     "Burkina Faso": "BF",
     "Bulgaria": "BG",
     "Bahrain": "BH",
     "Burundi": "BI",
     "Benin": "BJ",
     "Bermuda": "BM",
     "Brunei": "BN",
     "Bolivia": "BO",
     "Brazil": "BR",
     "Bahamas": "BS",
     "Bhutan": "BT",
     "Botswana": "BW",
     "Belarus": "BY",
     "Belize": "BZ",
     "Canada": "CA",
     "Congo": "CG",
     "Switzerland": "CH",
     "Ivory Coast": "CI",
     "Chile": "CL",
     "Cameroon": "CM",
     "China": "CN",
     "Colombia": "CO",
     "Costa Rica": "CR",
     "Cuba": "CU",
     "Cabo Verde": "CV",
     "Cyprus": "CY",
     "Czech": "CZ",
     "Germany": "DE",
     "Djibouti": "DJ",
     "Denmark": "DK",
     "Dominica": "DM",
     "Dominican Republic": "DO",
     "Algeria": "DZ",
     "Ecuador": "EC",
     "Estonia": "EE",
     "Egypt": "EG",
     "Western Sahara": "EH",
     "Eritrea": "ER",
     "Spain": "ES",
     "Ethiopia": "ET",
     "Finland": "FI",
     "Fiji": "FJ",
     "Falkland Islands": "FK",
     "Micronesia": "FM",
     "France": "FR",
     "Gabon": "GA",
     "UK": "GB",
     "Grenada": "GD",
     "Georgia": "GE",
     "French Guiana": "GF",
     "Ghana": "GH",
     "Gibraltar": "GI",
     "Greenland": "GL",
     "Gambia": "GM",
     "Guinea": "GN",
     "Guadeloupe": "GP",
     "Equatorial Guinea": "GQ",
     "Greece": "GR",
     "Guatemala": "GT",
     "Guinea-Bissau": "GW",
     "Guyana": "GY",
     "Hong Kong": "HK",
     "Honduras": "HN",
     "Croatia": "HR",
     "Haiti": "HT",
     "Hungary": "HU",
     "Indonesia": "ID",
     "Ireland": "IE",
     "Israel": "IL",
     "India": "IN",
     "Iraq": "IQ",
     "Iran": "IR",
     "Iceland": "IS",
     "Italy": "IT",
     "Jamaica": "JM",
     "Jordan": "JO",
     "Japan": "JP",
     "Kenya": "KE",
     "Kyrgyzstan": "KG",
     "Cambodia": "KH",
     "Comoros": "KM",
     "Saint Kitts and Nevis": "KN",
     "North Korea": "KP",
     "South Korea": "KR",
     "Kuwait": "KW",
     "Cayman Islands": "KY",
     "Kazakhstan": "KZ",
     "Laos": "LA",
     "Lebanon": "LB",
     "Saint Lucia": "LC",
     "Liechtenstein": "LI",
     "Sri Lanka": "LK",
     "Liberia": "LR",
     "Lesotho": "LS",
     "Lithuania": "LT",
     "Luxembourg": "LU",
     "Latvia": "LV",
     "Libya": "LY",
     "Morocco": "MA",
     "Monaco": "MC",
     "Madagascar": "MG",
     "Marshall Islands": "MH",
     "North Macedonia": "MK",
     "Mali": "ML",
     "Myanmar": "MM",
     "Mongolia": "MN",
     "Macao": "MO",
     "Martinique": "MQ",
     "Mauritania": "MR",
     "Montserrat": "MS",
     "Malta": "MT",
     "Mauritius": "MU",
     "Maldives": "MV",
     "Malawi": "MW",
     "Mexico": "MX",
     "Malaysia": "MY",
     "Mozambique": "MZ",
     "Namibia": "NA",
     "New Caledonia": "NC",
     "Niger": "NE",
     "Nigeria": "NG",
     "Nicaragua": "NI",
     "Norway": "NO",
     "Nepal": "NP",
     "New Zealand": "NZ",
     "Oman": "OM",
     "Panama": "PA",
     "Peru": "PE",
     "French Polynesia": "PF",
     "Papua New Guinea": "PG",
     "Philippines": "PH",
     "Pakistan": "PK",
     "Poland": "PL",
     "Portugal": "PT",
     "Palau": "PW",
     "Paraguay": "PY",
     "Qatar": "QA",
     "Reunion": "RE",
     "Romania": "RO",
     "Russia": "RU",
     "Rwanda": "RW",
     "Saudi Arabia": "SA",
     "Solomon Islands": "SB",
     "Seychelles": "SC",
     "Sudan": "SD",
     "Sweden": "SE",
     "Singapore": "SG",
     "Saint Helena": "SH",
     "Slovenia": "SI",
     "Slovakia": "SK",
     "Sierra Leone": "SL",
     "San Marino": "SM",
     "Senegal": "SN",
     "Somalia": "SO",
     "Suriname": "SR",
     "Sao Tome and Principe": "ST",
     "El Salvador": "SV",
     "Syria": "SY",
     "Swaziland": "SZ",
     "Chad": "TD",
     "Togo": "TG",
     "Thailand": "TH",
     "Tajikistan": "TJ",
     "Tunisia": "TN",
     "Turkey": "TR",
     "Trinidad And Tobago": "TT",
     "Taiwan": "TW",
     "Tanzania": "TZ",
     "Ukraine": "UA",
     "Uganda": "UG",
     "USA": "US",
     "Uruguay": "UY",
     "Uzbekistan": "UZ",
     "Vatican City": "VA",
     "St. Vincent Grenadines": "VC",
     "Venezuela": "VE",
     "British Virgin Islands": "VG",
     "Vietnam": "VN",
     "Vanuatu": "VU",
     "Wallis and Futuna": "WF",
     "Yemen": "YE",
     "Mayotte": "YT",
     "South Africa": "ZA",
     "Zambia": "ZM",
     "Zimbabwe": "ZW"
  };
}
