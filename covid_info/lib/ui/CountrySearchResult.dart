import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_info/model/provider/CovidStatusProvider.dart';
import 'package:flutter/services.dart';
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
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
       widget.provider.countryCases(true);
    });
  }

  _scrollListener(){
    if (_scrollController.offset > _scrollController.position.viewportDimension) {
      if(!widget.provider.countrySearchTopVisible){
        widget.provider.topVisiblility();
      }
    } else if(widget.provider.countrySearchTopVisible){
      widget.provider.topVisiblility();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Worldwide',style: TextStyle(fontSize: 16)),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        floatingActionButton: widget.provider.countrySearchTopVisible
          ? FloatingActionButton.extended(
            isExtended: false,
            onPressed: () => _scrollController.animateTo(0.0, duration: Duration(seconds: 1), curve: Curves.bounceInOut), 
            label: Text('TOP'),
            icon: Icon(Icons.arrow_upward_sharp),
          )
          : null,
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(color: Colors.blue,blurRadius: 1.5)
                  ]
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search,size: 20,color: Colors.grey[400]),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.text,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z \u0900-\u097F]"))],
                        style: TextStyle(color: Colors.black,fontFamily: '',fontSize: 16),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search country',
                          hintStyle: TextStyle(color: Colors.grey[400],fontSize: 14,fontFamily: '')
                        ),
                        onChanged: (input){
                          widget.provider.searchCountry(input);
                        }
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
    return RefreshIndicator(
      child: ListView.builder(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemCount: response.length,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 1.5)]
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
      ),
      color: Color(0xff0B3054),
      displacement: 20.0,
      onRefresh: refresh
    );
  }

  Future<void> refresh() async {
    await widget.provider.countryCases(false);
  }

  Future<bool> backPressed() async{
    Navigator.pop(context,'Ali Hasan');
    return true;
  }
}
