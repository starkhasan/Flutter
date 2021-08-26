import 'package:flutter/material.dart';

class HelperFAQ {
  HelperFAQ._();

  static var listHeading = [
    'What is the difference Between isolation and quarantine?',
    'What should I do if I have been exposed to someone who has COVID-19?',
    'How long does it take to develop symptoms?',
    'Are antibiotics effective in preventing or treating COVID-19?',
    'Will I get Covid after COVID vaccination?',
    'How does a vaccine work?',
    'Are there side effects from vaccine?',
    'Is vaccination free at all vaccination centres?',
    'Can I choose the vaccine?',
    'What precautions should I take at the time of 2nd dose vaccination?',
    'Can I get vaccinated with 2nd dose in a different State/District?',
    'Which documents should I carry with me for vaccination?',
    'Why do I need a vaccination certificate?',
    'Where can I download vaccination certificate from?',
    'Whom do I contact in case of side effects from vaccination?',
    'Is there a mobile app that needs to be installed to register for vaccination?',
    'Is online registration mandatory for Covid 19 vaccination?',
    'How many people can be registered in the Co-WIN portal through one mobile number?',
    'Can I register for vaccination without Aadhaar card?',
    'Is there any registration charge to be paid?',
    'Is it necessary to take 2nd dose of vaccination?',
    'When should I take the 2nd dose of vaccination?',
    'Will my 2nd dose appointment be automatically scheduled by Co-WIN system?',
  ];
  static var listSubHeading = [
    'Corona',
    'Corona',
    'Corona',
    'Corona',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine',
    'Vaccine'
  ];

  static var answer = [
    "Quarantine is used for anyone who is a contact of someone infected with the Corona virus, whether the infected person has symptoms or not.Quarantine means that you remain separated from others because you have been exposed to the virus and you may be infected and can take place in a designated facility or at home. For COVID-19, this means staying in the facility or at home for 14 days.\n\nIsolation is used for people with COVID-19 symptoms or who have tested positive for the virus. Being in isolation means being separated from other people, ideally in a medically facility where you can receive clinical care.",
    "Call your health care provider or COVID-19 hotline for instructions and find out when and where to get a test, stay at home for 14 days away from others and monitor your health.",
    "The time from exposure to COVID-19 to the moment when symptoms begin is, on average, 5-6 days and can range from 1-14 days.",
    "Antibiotics do not work against viruses; they only work on bacterial infections. COVID-19 is caused by a virus, so antibiotics do not work. Antibiotics should not be used as a means of prevention or treatment of COVID-19.",
    "It's unclear, but researchers are studying the chances of long-term symptoms developing in anyone who might get infected after vaccination.The COVID-19 vaccines in use around the world are effective at preventing severe illness and death from the coronavirus, but some people do get infected after the shots. With such breakthrough cases, health experts say the vaccines should help lessen the severity of any illness people experience.",
    "Vaccines reduce risks of getting a disease by working with your body’s natural defenses to build protection. When you get a vaccine, your immune system responds. It:\n\nRecognizes the invading germ, such as the virus or bacteria.\nProduces antibodies. Antibodies are proteins produced naturally by the immune system to fight disease.\nRemembers the disease and how to fight it. If you are then exposed to the germ in the future, your immune system can quickly destroy it before you become unwell.\n\nThe vaccine is therefore a safe and clever way to produce an immune response in the body, without causing illness.",
    "Like any medicine, vaccines can cause mild side effects, such as a low-grade fever, or pain or redness at the injection site. Mild reactions go away within a few days on their own.\nSevere or long-lasting side effects are extremely rare. Vaccines are continually monitored for safety, to detect rare adverse events.",
    "No. Vaccination is free at Government hospitals and charged up to INR 250 per dose in Private hospitals.",
    "System will show the vaccine being administered in each vaccination centre at the time of scheduling an appointment, the choice will not be available at the Government facilities .",
    "The Vaccination Centres have been directed to ensure that if a citizen is being vaccinated with 2nd dose, they should confirm that the first dose vaccination was done with the same vaccine as is being offered at the time of second dose and that the first dose was administered more than 28 days ago.",
    "Yes, you can get vaccinated in any State/District. The only restriction is that you will be able to get vaccinated only on those centres which are offering the same vaccine as was administered to you on your first dose.",
    "You should carry your identity proof specified by you at the time of registration on the Co-WIN portal and a printout/screenshot of your appointment slip.",
    "A COVID Vaccine Certificate (CVC) issued by the government offers an assurance to the beneficiary on the vaccination, type of vaccine used, and the provisional certificate also provides the next vaccination due. It also is an evidence for the citizen to prove to any entities which may require proof of vaccination specially in case of travel. Vaccination not only protects individuals from disease, but also reduces their risk of spreading the virus. Therefore, there could be a requirement in future to produce certificate for certain kind of social interactions and international travel.",
    "You can download vaccination certificate from the Co-WIN portal (cowin.gov.in) or the Aarogya Setu app or through Digi-Locker.",
    "You can contact on any of the following details:\nHelpline Number: +91-11-23978046 (Toll free- 1075)\nTechnical Helpline Number: 0120-4473222\nHelpline Email Id: support@cowin.gov.in\nYou may also contact the Vaccination Centre where you took vaccination, for advice.",
    "There is no authorised mobile app for registering for vaccination in India. You need to log into the Co-WIN portal. You can also register for vaccination through the Aarogya Setu App.",
    "No. Vaccination Centres provide for a limited number of on-spot registration slots every day.",
    "Up to 4 people can be registered for vaccination using the same mobile number.",
    "Yes, you can register on Co-WIN portal using any of the following ID proofs: a. Aadhaar card b. Driving License c. PAN card d. Passport e. Pension Passbook f. NPR Smart Card g. Voter ID (EPIC)",
    'No. There is no registration charge.',
    'Yes. It is recommended that both doses of vaccine should be taken for realising the full benefit of vaccination. Both doses must be of the same vaccine type.',
    'It is recommended that the 2nd dose of COVAXIN should be administered in the interval of 4 to 6 weeks from the date of 1st dose administration. For COVISHIELD the recommended interval is 4 to 8 weeks while an interval of 6 to 8 weeks gives an enhanced protection.',
    'No. You have to take an appointment for the 2nd dose vaccination.',
  ];

  static Gradient vaccineGradient(){
    return LinearGradient(
        colors: [
          Color(0xFFE3F2FD),
          Color(0xFFE3F2FD),
          Color(0xFFffffff),
          Color(0xFFffffff),
          Color(0xFFffffff),
          Color(0xFFffffff),
          Color(0xFFffffff),
          Color(0xFFffffff)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        tileMode: TileMode.clamp
    );
  }

  static Gradient coronaGradient(){
    return LinearGradient(
        colors: [
          Color(0xFFFFEBEE),
          Color(0xFFFFEBEE),
          Color(0xFFffffff),
          Color(0xFFffffff),
          Color(0xFFffffff),
          Color(0xFFffffff),
          Color(0xFFffffff),
          Color(0xFFffffff)
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        tileMode: TileMode.clamp
    );
  }
}
