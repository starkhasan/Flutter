import 'package:flutter/material.dart';
import 'package:hello_flutter/constants/covid/HelperAbout.dart';
import 'package:hello_flutter/providers/Covid/CovidStatusProvider.dart';
import 'package:hello_flutter/ui/Covid/CountrySearchResult.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CovidStatus extends StatefulWidget {
  @override
  _CovidStatusState createState() => _CovidStatusState();
}

class _CovidStatusState extends State<CovidStatus> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CovidStatusProvider>(
      create: (context) => CovidStatusProvider(),
      child: Consumer<CovidStatusProvider>(
          builder: (context, covidProvider, child) {
        return MainScreen(provider: covidProvider);
      }),
    );
  }
}

class MainScreen extends StatefulWidget {
  final CovidStatusProvider provider;
  MainScreen({this.provider});
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  
  var formatter = NumberFormat('#,##,000');
  var countryName = 'India';
  var countryCode = 'IN'; 

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       widget.provider.covidStatus('India', DateTime.now().toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: ()  async {
                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CountrySearchResult()));
                print(result);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      'https://www.countryflags.io/$countryCode/shiny/64.png',
                      height: 25,
                      width: 25,
                      errorBuilder: (context,exception,stackTrace){return Icon(Icons.flag);},
                    ),
                    SizedBox(width: 10),
                    Text(countryName,style: TextStyle(fontSize: 18,fontFamily: '')),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_drop_down_sharp,color: Colors.black,size: 30)
                  ]
                )
              )
            )
          ),
          ListView.builder(
            itemCount: HelperAbout.listIcons.length,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          HelperAbout.listTags[index],
                          style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: ''),
                        ),
                        SizedBox(height: 5),
                        widget.provider.apiCalling
                        ? SizedBox(height: 25,width: 25, child: CircularProgressIndicator(strokeWidth: 2.0,backgroundColor: Colors.blue))
                        : Text(
                          formatter.format(widget.provider.covidStatusResponse[index]),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontFamily: '',
                            fontWeight: FontWeight.bold
                          )
                        )
                      ]
                    ),
                    HelperAbout.listIcons[index]
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
