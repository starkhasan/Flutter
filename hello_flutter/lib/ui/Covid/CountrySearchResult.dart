import 'package:flutter/material.dart';
import 'package:hello_flutter/providers/Covid/CovidStatusProvider.dart';
import 'package:provider/provider.dart';

class CountrySearchResult extends StatefulWidget {
  @override
  _CountrySearchResultState createState() => _CountrySearchResultState();
}

class _CountrySearchResultState extends State<CountrySearchResult> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CovidStatusProvider>(
      create: (context) => CovidStatusProvider(),
      child: Consumer<CovidStatusProvider>(
        builder: (context, provider, child) {
          return CountryMainScreen(provider: provider);
        },
      ),
    );
  }
}

class CountryMainScreen extends StatefulWidget {
  final CovidStatusProvider provider;
  CountryMainScreen({this.provider});
  @override
  _CountryMainScreen createState() => _CountryMainScreen();
}

class _CountryMainScreen extends State<CountryMainScreen> {


  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       widget.provider.countryCases();
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Country'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(color: Colors.grey,blurRadius: 2.0)
                  ]
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black,fontFamily: '',fontSize: 18),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Seach Country Here',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 18,fontFamily: '')
                        ),
                        onChanged: (input){
                          widget.provider.searchCountry(input);
                        },
                      )
                    )
                  ]
                )
              ),
              Expanded(
                child: widget.provider.apiCalling
                ? Center(child: Text('Loading...'))
                : widget.provider.countryResponse.length > 0
                  ? getCountryList()
                  : Center(child: Text('Loading...'))
              )
            ]
          )
        )
      )
    );
  }

  Widget getCountryList(){
    var response = widget.provider.countryResponse;
    return ListView.builder(
      itemCount: response.length,
      itemBuilder: (context,index){
        return Container(
          margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    response[index].country,
                    style: TextStyle(color: Colors.black,fontSize: 25,fontFamily: ''),
                  )
                ]
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Cases'),
                      Text(
                        response[index].cases != null ? response[index].cases.toString() : 'Not Found',
                        style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
                      )
                    ]
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Total Recovered'),
                      Text(
                        response[index].recovered !=null ? response[index].recovered.toString() : 'Not Found',
                        style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
                      )
                    ]
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Total Deaths'),
                      Text(
                        response[index].deaths !=null ? response[index].deaths.toString() : 'Not Found',
                        style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
                      )
                    ]
                  )
                ]
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Active'),
                      Text(
                        response[index].active != null ? response[index].active.toString() : 'Not Found',
                        style: TextStyle(color: Colors.teal,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
                      )
                    ]
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Critical Cases'),
                      Text(
                        response[index].critical !=null ? response[index].critical.toString() : 'Not Found',
                        style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
                      )
                    ]
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('New Cases'),
                      Text(
                        response[index].todayCases !=null ? response[index].todayCases.toString() : 'Not Found',
                        style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
                      )
                    ]
                  )
                ]
              )
            ]
          )
        );
      }
    );
  }

  Future<bool> backPressed() async{
    Navigator.pop(context,'Ali Hasan');
    return true;
  }
}
