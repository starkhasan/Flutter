import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constant/helper_about.dart';
import '../controllers/covid_status_controller.dart';
import '../ui/country_search_result_screen.dart';

class CovidStatus extends StatefulWidget {
  const CovidStatus({super.key});

  @override
  State createState() => _CovidStatusState();
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
  const MainScreen({super.key, required this.provider});
  @override
  State createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  
  var formatter = NumberFormat('#,##,###');
  var date = DateTime.now().toString();
  var refreshIndicatorMargin = 0.0;
  // late BannerAd _bannerAd;
  // late AdWidget adWidget;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       widget.provider.covidStatus(true);
    });
    // _bannerAd = BannerAd(
    //   adUnitId: "ca-app-pub-9422971308124709/7654126838",
    //   request: const AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (Ad ad) {
    //       widget.provider.adMobVisibility(true);
    //       log('$BannerAd loaded.');
    //     },
    //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
    //       widget.provider.adMobVisibility(false);
    //       log('$BannerAd failedToLoad: $error');
    //       ad.dispose();
    //     },
    //     onAdOpened: (Ad ad) => log('$BannerAd onAdOpened.'),
    //     onAdClosed: (Ad ad) => log('$BannerAd onAdClosed.'),
    //   ),
    // );
    // _bannerAd.load();
  }


  @override
  void dispose() {
    super.dispose();
    //_bannerAd.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshIndicatorMargin = kToolbarHeight+MediaQuery.of(context).padding.top;
  }

  @override
  Widget build(BuildContext context) {
    //adWidget = AdWidget(ad: _bannerAd);
    return Scaffold(
      body: RefreshIndicator(
        displacement: refreshIndicatorMargin,
        color: const Color(0xff0B3054),
        onRefresh: refresh,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverAppBar(
              backgroundColor: Color(0xFF0B3054),
              centerTitle: true,
              floating: true,
              title: Text('Status',style: TextStyle(fontSize: 14)),
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
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.provider.apiCalling
                  ? 'Loading...'
                  : 'Last updated: 1 days ago',
                  style: const TextStyle(color: Colors.grey,fontSize: 11,fontFamily: ''),
                )
              ),
              Flexible(
                child: GestureDetector(
                  onTap: ()  async {
                    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const CountrySearchResult(vaccineResult: false)));
                    log(result);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          'https://flagcdn.com/w160/in.png',
                          height: 24,
                          width: 24,
                          errorBuilder: (context,exception,stackTrace) => const Icon(Icons.flag)
                        ),
                        const SizedBox(width: 10),
                        const Text('India',style: TextStyle(fontSize: 11,fontFamily: '')),
                        const SizedBox(width: 5),
                        const Icon(Icons.arrow_drop_down_sharp,color: Colors.black,size: 26)
                      ]
                    )
                  )
                )
              )
            ]
          ),
          // Visibility(
          //   visible: widget.provider.showBanner,
          //   child: Container(
          //     margin: const EdgeInsets.only(top: 10), 
          //     width: _bannerAd.size.width.toDouble(),
          //     height: _bannerAd.size.height.toDouble(),
          //     child: adWidget
          //   )
          // ),
          ListView.builder(
            itemCount: HelperAbout.listIcons.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 5),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index){
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0
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
                            style: TextStyle(color: Colors.grey[800],fontSize: 11,fontFamily: ''),
                          ),
                          const SizedBox(height: 5),
                          widget.provider.apiCalling
                          ? const SizedBox(height: 4,width: 40, child: LinearProgressIndicator(minHeight: 2,backgroundColor: Colors.white,color: Color(0xFF0B3054)))
                          : Text(
                            widget.provider.covidStatusResponse[index] == 0
                            ? '0'
                            : formatter.format(widget.provider.covidStatusResponse[index]),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: '',
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      )
                    ),
                    HelperAbout.listIcons[index]
                  ]
                )
              );
            }
          )
        ]
      )
    );
  }
}
