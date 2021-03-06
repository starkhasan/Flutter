import 'package:flutter/material.dart';
import 'package:covid_info/model/provider/CovidStatusProvider.dart';
import 'package:intl/intl.dart';
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
  CountryMainScreen({required this.provider});
  @override
  _CountryMainScreen createState() => _CountryMainScreen();
}

class _CountryMainScreen extends State<CountryMainScreen> {

  var formatter = NumberFormat('#,##,000');
  
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
       widget.provider.countryCases();
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Worldwide Status',style: TextStyle(fontSize: 16)),
          centerTitle: true,
          brightness: Brightness.dark
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
                          hintText: 'Search Country Here',
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
                child: widget.provider.apiCountry
                ? Center(child: Text('Loading...'))
                : widget.provider.countryResponse.length > 0
                  ? getCountryList()
                  : Center(child: Text('No result found'))
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
          margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 2.0)]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      response[index].country,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black,fontSize: 24,fontFamily: '',fontWeight: FontWeight.bold),
                    )
                  )
                ]
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cases',style: TextStyle(color:Colors.grey[700],fontSize: 12,fontFamily: '')),
                        Text(
                          response[index].cases == 0
                          ? '0'
                          : formatter.format(response[index].cases),
                          style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: '')
                        )
                      ]
                    )
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Recovered',style: TextStyle(color:Colors.grey[700],fontSize: 12,fontFamily: '')),
                        Text(
                          response[index].recovered == 0
                          ? '0'
                          : formatter.format(response[index].recovered),
                          style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: '')
                        )
                      ]
                    )
                  ) 
                ]
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deaths',style: TextStyle(color:Colors.grey[700],fontSize: 12,fontFamily: '')),
                        Text(
                          response[index].deaths == 0
                          ? '0'
                          : formatter.format(response[index].deaths),
                          style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: '')
                        )
                      ]
                    )
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Active',style: TextStyle(color:Colors.grey[700],fontSize: 12,fontFamily: '')),
                        Text(
                          response[index].active == 0
                          ? '0'
                          : formatter.format(response[index].active),
                          style: TextStyle(color: Colors.teal,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: '')
                        )
                      ]
                    )
                  )
                ]
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Critical Cases',style: TextStyle(color:Colors.grey[700],fontSize: 12,fontFamily: '')),
                        Text(
                          response[index].critical == 0
                          ? '0'
                          : formatter.format(response[index].critical),
                          style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: '')
                        )
                      ]
                    )
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('New Cases',style: TextStyle(color:Colors.grey[700],fontSize: 12,fontFamily: '')),
                        Text(
                          response[index].todayCases == 0
                          ? '0'
                          : formatter.format(response[index].todayCases),
                          style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: '')
                        )
                      ]
                    )
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
