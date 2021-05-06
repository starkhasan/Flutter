import 'package:flutter/material.dart';
import 'package:hello_flutter/providers/CovidProvider.dart';
import 'package:provider/provider.dart';

class DraggableScrollSheet extends StatefulWidget {
  @override
  _DraggableScrollSheetState createState() => _DraggableScrollSheetState();
}

class _DraggableScrollSheetState extends State<DraggableScrollSheet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Covid19 Dashboard'),
      ),
      body: ChangeNotifierProvider<CovidProvider>(
        create: (context) => CovidProvider(),
        child: Consumer<CovidProvider>(
          builder: (context,covidProvider,child){
            return CovidScreen(provider: covidProvider);
          }
        )
      )
    );
  }
  Widget getTile(){
    return Card(
      child: ListTile(
        title: Text('India'),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<CovidProvider>(context,listen: false);
      provider.countryApi();
    });
  }

  @override
  Widget build(BuildContext context){
    return Stack(
      fit: StackFit.expand,
      children: [
        getBodyWidget(),
        SizedBox.expand(
          child: DraggableScrollableSheet(
            minChildSize: 0.15,
            initialChildSize: 0.15,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                ),
                child: widget.provider.isFetchingCountry
                  ? Container(height: 15,width: 15, child: Center(child: CircularProgressIndicator(strokeWidth: 3.0,backgroundColor: Colors.blue)))
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
                            print(widget.provider.countryResponse[index-1].iso2),
                            countryCode = widget.provider.countryResponse[index-1].iso2,
                            countryName = widget.provider.countryResponse[index-1].country,
                            widget.provider.covidCountryCase(true,widget.provider.countryResponse[index-1].slug)
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
    );
  }

  Widget getBodyWidget(){
    countryCases = widget.provider.covidCountryCaseResponse;
    return Container(
      color: Colors.white,
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
                  SizedBox(width: 10),
                  Text(countryName,style: TextStyle(fontSize: 16))
                ],
              ),
              widget.provider.isFetchingCases || widget.provider.isFetchingCountry
              ? SizedBox(height: 15,width: 15,child: CircularProgressIndicator(strokeWidth: 2.0,backgroundColor: Colors.blue))
              : Text(DateTime.now().toString().substring(0,11).split('-').reversed.join('-'))
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
          )
        ],
      )
    );
  }
}