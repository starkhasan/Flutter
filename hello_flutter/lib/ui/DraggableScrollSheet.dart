import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/providers/CovidProvider.dart';
import 'package:hello_flutter/utils/Helper.dart';
import 'package:provider/provider.dart';

class DraggableScrollSheet extends StatefulWidget {
  @override
  _DraggableScrollSheetState createState() => _DraggableScrollSheetState();
}

class _DraggableScrollSheetState extends State<DraggableScrollSheet> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CovidProvider>(
      create: (context) => CovidProvider(),
      child: Consumer<CovidProvider>(
        builder: (context,covidProvider,child){
          return CovidScreen(provider: covidProvider);
        }
      )
    );
  }
}


class CovidScreen extends StatefulWidget{
  final CovidProvider provider;
  CovidScreen({this.provider});
  @override
  _CovidScreen  createState() => _CovidScreen();
}

class _CovidScreen extends State<CovidScreen>{

  var countryCode = 'IN';
  var countryName = 'India';
  var countryCases = [];
  var _initialPosition = 0;
  var _initialDatePosition = 0;
  var apiDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1).toString();
  var date = "";
  var apiCountry = 'india';

  @override
  void initState() {
    super.initState();
    date = apiDate.substring(0,10).split('-').reversed.join('-');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<CovidProvider>(context,listen: false);
      provider.countryApi(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1).toString());
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Covid19 Dashboard'),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
        child:  FloatingActionButton.extended(
          onPressed: () => showCupertinoDialog(),
          icon: Icon(Icons.flag),
          label: Text('Country'),
          isExtended: false,
          elevation: 10.0,
        )
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          getBodyWidget(),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              minChildSize: 0.08,
              initialChildSize: 0.08,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(blurRadius: 0.0)
                    ]
                  ),
                  child: widget.provider.isFetchingCountry
                    ? SizedBox()
                    : ListView.builder(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.provider.countryResponse.length+1,
                    itemBuilder: (context, index) {
                      if (widget.provider.countryResponse.length > 0) {
                        return index == 0
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.45, 5, MediaQuery.of(context).size.width * 0.45, 5),
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                          )
                        : Card(
                          child: ListTile(
                            onTap: () => {
                              // countryCode = widget.provider.countryResponse[index-1].iso2,
                              // countryName = widget.provider.countryResponse[index-1].country,
                              // widget.provider.covidCountryCase(true,widget.provider.countryResponse[index-1].slug)
                            },
                            dense: true,
                            title: Text(widget.provider.countryResponse[index-1].country),
                            trailing: Image.network('https://www.countryflags.io/${widget.provider.countryResponse[index-1].iso2}/shiny/64.png',height: 20,width: 20)
                          )
                        );
                      } else {
                        return Container(child: Center(child: Text('Records not found!')));
                      }
                    }
                  )
                );
              }
            )
          )
        ]
      )
    );
  }

  Widget getBodyWidget(){
    countryCases = widget.provider.covidCountryCaseResponse;
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://www.countryflags.io/$countryCode/shiny/64.png',
                    height: 20,
                    width: 20,
                    errorBuilder: (context,exception,stackTrace){return Icon(Icons.flag);},
                  ),
                  SizedBox(width: 8),
                  Text(countryName,style: TextStyle(fontSize: 16))
                ]
              ),
              widget.provider.isFetchingCases || widget.provider.isFetchingCountry
              ? SizedBox(height: 15,width: 15,child: CircularProgressIndicator(strokeWidth: 2.0,backgroundColor: Colors.blue))
              : GestureDetector(
                  onTap: () => showDateDialog(),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(date),
                        Icon(Icons.arrow_drop_down,size: 24)
                      ],
                    ),
                  ),
                )
              ]
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Confirmed'
              ),
              Text(
                countryCases.length > 0
                ? countryCases[countryCases.length-1].confirmed.toString()
                : '0',
                style: TextStyle(fontFamily: 'PoppinsSemiBold',fontSize: 15),
              )
            ]
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deaths'
              ),
              Text(
                countryCases.length > 0
                ? countryCases[countryCases.length-1].deaths.toString()
                : '0',
                style: TextStyle(fontFamily: 'PoppinsSemiBold',fontSize: 15,color: Colors.red)
              )
            ]
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recovered'
              ),
              Text(
                countryCases.length > 0
                ? countryCases[countryCases.length-1].recovered.toString()
                : '0',
                style: TextStyle(fontFamily: 'PoppinsSemiBold',fontSize: 15,color: Colors.green)
              )
            ]
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active'
              ),
              Text(
                countryCases.length > 0
                ? countryCases[countryCases.length-1].active.toString()
                : '0',
                style: TextStyle(fontFamily: 'PoppinsSemiBold',fontSize: 15,color: Colors.blue)
              )
            ]
          ),

        ]
      )
    );
  }

  showCupertinoDialog(){
    var position = 0;
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context,setState){
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                ),
                child: Column(
                  children: [
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel',style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal)),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () => {
                            Navigator.pop(context),
                            widget.provider.covidCountryCase(true,widget.provider.countryResponse[position].slug,apiDate),
                            setState( (){
                              _initialDatePosition = 0;
                              date = apiDate.substring(0,10).split('-').reversed.join('-');
                              apiCountry = widget.provider.countryResponse[position].slug;
                              _initialPosition = position;
                              countryCode = widget.provider.countryResponse[position].iso2;
                              countryName = widget.provider.countryResponse[position].country;
                            })
                          },
                          child: Text('Submit',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal)),
                        )
                      ]
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 35,
                        useMagnifier: true,
                        magnification: 1.2,
                        scrollController: FixedExtentScrollController(initialItem: _initialPosition),
                        onSelectedItemChanged: (value){
                          position = value;
                        },
                        children: Helper.cupertinoCountryList(widget.provider.countryResponse),
                        looping: false,
                      )
                    )
                  ]
                )
              )
            );
          }
        );
      }
    );
  }


  showDateDialog(){
    var position = 0;
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context,setState){
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                ),
                child: Column(
                  children: [
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel',style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal)),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () => {
                            Navigator.pop(context),
                            widget.provider.covidCountryCase(true,apiCountry,countryCases[countryCases.length - 1 - position].date.toString()),
                            setState( (){
                              _initialDatePosition = position;
                              date = countryCases[countryCases.length - 1 - position].date.toString().substring(0,10).split('-').reversed.join('-');
                            })
                          },
                          child: Text('Submit',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal)),
                        )
                      ]
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 35,
                        useMagnifier: true,
                        magnification: 1.2,
                        scrollController: FixedExtentScrollController(initialItem: _initialDatePosition),
                        onSelectedItemChanged: (value){
                          position = value;
                        },
                        children: Helper.cupertinoDateList(countryCases),
                        looping: false,
                      )
                    )
                  ]
                )
              )
            );
          }
        );
      }
    );
  }
}