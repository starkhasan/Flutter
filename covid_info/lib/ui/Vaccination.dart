import 'package:flutter/material.dart';
import 'package:covid_info/constant/HelperAbout.dart';
import 'package:covid_info/model/provider/CovidStatusProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
       widget.provider.vaccination();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            centerTitle: true,
            floating: true,
            title: Text('Vaccination'),
            expandedHeight: kToolbarHeight
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              vaccinationStatusWidget()
            ])
          )
        ]
      )
    );
  }

  

  Widget vaccinationStatusWidget(){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.provider.apiVaccine
                      ? 'Loading...'
                      : 'Last updated: 2 days ago',
                      style: TextStyle(color: Colors.black,fontSize: 17,fontFamily: ''),
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
                        Text('India',style: TextStyle(fontSize: 17,fontFamily: ''))
                      ]
                    )
                  )
                ]
              )
            )
          ),
          ListView.builder(
            itemCount: HelperAbout.listVaccineTag.length,
            shrinkWrap: true,
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
                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: ''),
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
                              fontSize: 28,
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
          )
        ]
      )
    );
  }
  
}
