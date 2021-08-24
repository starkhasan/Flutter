import 'package:flutter/material.dart';
import 'package:covid_info/constant/HelperAbout.dart';
import 'package:covid_info/model/provider/CovidStatusProvider.dart';
import 'package:covid_info/ui/CountrySearchResult.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CovidStatus extends StatefulWidget {
  @override
  _CovidStatusState createState() => _CovidStatusState();
}

class _CovidStatusState extends State<CovidStatus> {

  @override
  void initState() {
    super.initState();
    print('called');
  }

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
  MainScreen({required this.provider});
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  
  var formatter = NumberFormat('#,##,000');
  var countryName = 'India';
  var countryCode = 'IN'; 
  var date = DateTime.now().toString();
  var refreshIndicatorMargin = 0.0;
  late BannerAd _bannerAd;
  late AdWidget adWidget;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
       widget.provider.covidStatus(true);
    });
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-9422971308124709/7654126838",
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    _bannerAd.load();
  }


  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshIndicatorMargin = kToolbarHeight+MediaQuery.of(context).padding.top;
  }

  @override
  Widget build(BuildContext context) {
    adWidget = AdWidget(ad: _bannerAd);
    return Scaffold(
      body: RefreshIndicator(
        displacement: refreshIndicatorMargin,
        color: Color(0xff0B3054),
        onRefresh: refresh,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers:[
            SliverAppBar(
              backgroundColor: Color(0xFF0B3054),
              centerTitle: true,
              floating: true,
              title: Text('Corona Status',style: TextStyle(fontSize: 16)),
              expandedHeight: kToolbarHeight,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                covidStatusWidget()
              ])
            )
          ]
        )
      )
    );
  }

  Future<void> refresh() async {
    await widget.provider.covidStatus(false);
  }
  
  Widget covidStatusWidget(){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.provider.apiCalling
                    ? 'Loading...'
                    : 'Last updated: 1 days ago',
                    style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: ''),
                  )
                ),
                Flexible(
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
                          Text(countryName,style: TextStyle(fontSize: 14,fontFamily: '')),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_drop_down_sharp,color: Colors.black,size: 28)
                        ]
                      )
                    )
                  )
                )
              ]
            )
          ),
          Visibility(
            visible: adWidget != null,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: adWidget, 
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble()
            )
          ),
          ListView.builder(
            itemCount: HelperAbout.listIcons.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10),
            physics: BouncingScrollPhysics(),
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
                            HelperAbout.listTags[index],
                            style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: ''),
                          ),
                          SizedBox(height: 5),
                          widget.provider.apiCalling
                          ? SizedBox(height: 25,width: 25, child: CircularProgressIndicator(strokeWidth: 1.5,valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B3054))))
                          : Text(
                            widget.provider.covidStatusResponse[index] == 0
                            ? '0'
                            : formatter.format(widget.provider.covidStatusResponse[index]),
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
