import 'package:covid_info/constant/HelperVaccination.dart';
import 'package:covid_info/ui/ShowDocument.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:covid_info/constant/HelperAbout.dart';
import 'package:covid_info/model/provider/CovidStatusProvider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Vaccination extends StatefulWidget {

  @override
  _VaccinationState createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CovidStatusProvider>(
      create: (context) => CovidStatusProvider(),
      child: Consumer<CovidStatusProvider>(
        builder: (context, provider, child){
          return VaccineScreen(provider: provider);
        }
      ),
    );
  }
}

class VaccineScreen extends StatefulWidget {
  final CovidStatusProvider provider;
  VaccineScreen({required this.provider});

  @override
  _VaccineScreenState createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {

  var formatter = NumberFormat('#,##,000');
  var refreshIndicatorMargin = 0.0;
  
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
       widget.provider.vaccination(true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshIndicatorMargin = kToolbarHeight+MediaQuery.of(context).padding.top;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: refreshIndicatorMargin,
        color: Color(0xff0B3054),
        onRefresh: refresh,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers:[
            SliverAppBar(
              centerTitle: true,
              floating: true,
              title: Text('Vaccination',style: TextStyle(fontSize: 16)),
              expandedHeight: kToolbarHeight,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                vaccinationStatusWidget()
              ])
            )
          ]
        )
      )
    );
  }

  Future<void> refresh() async{
    await widget.provider.vaccination(false);
  }

  Widget vaccinationStatusWidget(){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.provider.apiVaccine
                    ? 'Loading...'
                    : 'Last updated: 1 days ago',
                    style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: ''),
                  )
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        'https://www.countryflags.io/IN/shiny/64.png',
                        height: 25,
                        width: 25,
                        errorBuilder: (context,exception,stackTrace){return Icon(Icons.flag);},
                      ),
                      SizedBox(width: 10),
                      Text('India',style: TextStyle(fontSize: 14,fontFamily: ''))
                    ]
                  )
                )
              ]
            )
          ),
          SizedBox(height: 10),
          ListView.builder(
            itemCount: HelperAbout.listVaccineTag.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HelperAbout.listVaccineTag[index],
                            style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: ''),
                          ),
                          SizedBox(height: 5),
                          widget.provider.apiVaccine
                          ? SizedBox(height: 25,width: 25, child: CircularProgressIndicator(strokeWidth: 2.0,backgroundColor: Colors.white))
                          : Text(
                            widget.provider.vaccineResponse[index] == 0
                            ? '0'
                            : formatter.format(widget.provider.vaccineResponse[index]),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontFamily: '',
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      )
                    ),
                    HelperAbout.listIconsVaccine[index]
                  ],
                )
              );
            }
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sites Conducting Vaccination',
                        style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: ''),
                      ),
                      SizedBox(height: 5),
                      widget.provider.apiVaccine
                      ? SizedBox(height: 25,width: 25, child: CircularProgressIndicator(strokeWidth: 2.0,backgroundColor: Colors.white))
                      : Text(
                        widget.provider.sites == 0
                        ? '0'
                        : formatter.format(widget.provider.sites),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontFamily: '',
                          fontWeight: FontWeight.bold
                        )
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Government',
                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: ''),
                                ),
                                SizedBox(height: 2),
                                widget.provider.apiVaccine
                                ? SizedBox(height: 20,width: 20, child: CircularProgressIndicator(strokeWidth: 2.0,backgroundColor: Colors.white))
                                : Text(
                                  widget.provider.sitesGovernment == 0
                                  ? '0'
                                  : formatter.format(widget.provider.sitesGovernment),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: '',
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ]
                            )
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Private',
                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: ''),
                                ),
                                SizedBox(height: 2),
                                widget.provider.apiVaccine
                                ? SizedBox(height: 20,width: 20, child: CircularProgressIndicator(strokeWidth: 2.0,backgroundColor: Colors.white))
                                : Text(
                                  widget.provider.sitesPrivate == 0
                                  ? '0'
                                  : formatter.format(widget.provider.sitesPrivate),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: '',
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ]
                            )
                          )
                        ]
                      )
                    ]
                  )
                ),
                Icon(Icons.location_city,color: Color(0xFF0B3054),size: 40),
              ]
            )
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available vaccine in India',
                        style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: ''),
                      ),
                      SizedBox(height: 5),
                      widget.provider.apiVaccine
                      ? SizedBox(height: 20,width: 20, child: CircularProgressIndicator(strokeWidth: 2.0,backgroundColor: Colors.white))
                      : ListView.builder(
                        itemCount: widget.provider.vaccineName.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.circle,color: Colors.green,size: 8),
                                SizedBox(width: 5),
                                Flexible(child: Text(widget.provider.vaccineName[index],style: TextStyle(color: Colors.black,fontSize: 12)))
                              ]
                            )
                          );
                        }
                      )
                    ]
                  )
                ),
                Image.asset('assets/images/syringe.png',height: 40,width: 40),
              ]
            )
          ),
          GestureDetector(
            onTap: () => launch(HelperVaccination.vaccinationRegistration),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 2.0
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Register or SignIn for Vaccination with official Government of India CoWIN Portal',
                      style: TextStyle(color: Colors.blue,fontSize: 14,fontFamily: ''),
                    )
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.18,
                    child: Image.asset('assets/images/cowinlogo.jpg',fit: BoxFit.contain),
                  )
                ],
              )
            )
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ShowDocument(url: widget.provider.stateVaccineUrl))),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [ BoxShadow(color: Colors.blue,blurRadius: 2.0)]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'States Vaccination Report',
                      style: TextStyle(color: Colors.blue,fontSize: 14,fontFamily: ''),
                    )
                  ),
                  Icon(Icons.cabin_rounded,color: Colors.blue,size: 30),
                ]
              )
            )
          ),
          GestureDetector(
            onTap: () => launch(HelperVaccination.verifyCertification),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [ BoxShadow(color: Colors.blue,blurRadius: 2.0)]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Verify a vaccination certificate',
                      style: TextStyle(color: Colors.blue,fontSize: 14,fontFamily: ''),
                    )
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Image.asset('assets/images/verifyCertificate.png',fit: BoxFit.contain),
                  )
                ]
              )
            )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontStyle: FontStyle.italic,fontSize: 12),
                children: [
                  TextSpan(text: 'Source Data : ',style: TextStyle(color: Colors.grey[400])),
                  TextSpan(
                    text: 'CoWIN Official',
                    style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue[300]),
                    recognizer: TapGestureRecognizer()..onTap = () => launch(HelperVaccination.vaccineIndiaUrl)
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}
