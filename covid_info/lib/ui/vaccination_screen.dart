import 'dart:developer';

import '../constant/helper_vaccination.dart';
import '../ui/country_search_result_screen.dart';
import '../ui/show_document_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../constant/helper_about.dart';
import '../controllers/covid_status_controller.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Vaccination extends StatefulWidget {
  const Vaccination({Key? key}) : super(key: key);

  @override
  State createState() => _VaccinationState();
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
  const VaccineScreen({super.key, required this.provider});

  @override
  State createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {

  var formatter = NumberFormat('#,##,###');
  var refreshIndicatorMargin = 0.0;
  // late BannerAd _bannerAd;
  // late AdWidget adWidget;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       widget.provider.vaccination(true);
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
    // adWidget = AdWidget(ad: _bannerAd);
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
    return Scaffold(
      body: RefreshIndicator(
        displacement: refreshIndicatorMargin,
        color: const Color(0xff0B3054),
        onRefresh: refresh,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers:[
            const SliverAppBar(
              backgroundColor: Color(0xFF0B3054),
              centerTitle: true,
              floating: true,
              title: Text('Vaccination',style: TextStyle(fontSize: 14)),
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
                  widget.provider.apiVaccine
                  ? 'Loading...'
                  : 'Last updated: 1 days ago',
                  style: const TextStyle(color: Colors.grey,fontSize: 11,fontFamily: ''),
                )
              ),
              Flexible(
                child: GestureDetector(
                  onTap: ()  async {
                    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const CountrySearchResult(vaccineResult: true)));
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
                          errorBuilder: (context,exception,stackTrace) => const Icon(Icons.flag),
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
          //     margin: EdgeInsets.only(top: 10),
          //     child: adWidget, 
          //     width: _bannerAd.size.width.toDouble(),
          //     height: _bannerAd.size.height.toDouble()
          //   )
          // ),
          ListView.builder(
            itemCount: HelperAbout.listVaccineTag.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            physics: const NeverScrollableScrollPhysics(),
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
                            HelperAbout.listVaccineTag[index],
                            style: TextStyle(color: Colors.grey[800],fontSize: 11,fontFamily: ''),
                          ),
                          const SizedBox(height: 5),
                          widget.provider.apiVaccine
                          ? const SizedBox(height: 4,width: 40, child: LinearProgressIndicator(minHeight: 2,backgroundColor: Colors.white,color: Color(0xFF0B3054)))
                          : Text(
                            widget.provider.vaccineResponse[index] == 0
                            ? '0'
                            : formatter.format(widget.provider.vaccineResponse[index]),
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
                    HelperAbout.listIconsVaccine[index]
                  ]
                )
              );
            }
          ),
          Container(
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
                        'Total Sites',
                        style: TextStyle(color: Colors.grey[800],fontSize: 11,fontFamily: ''),
                      ),
                      const SizedBox(height: 5),
                      widget.provider.apiVaccine
                      ? const SizedBox(height: 4,width: 40, child: LinearProgressIndicator(minHeight: 2,backgroundColor: Colors.white,color: Color(0xFF0B3054)))
                      : Text(
                        widget.provider.sites == 0
                        ? '0'
                        : formatter.format(widget.provider.sites),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: '',
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Government',
                                  style: TextStyle(color: Colors.grey[800],fontSize: 10,fontFamily: ''),
                                ),
                                const SizedBox(height: 2),
                                widget.provider.apiVaccine
                                ? const SizedBox(height: 2,width: 40, child: LinearProgressIndicator(minHeight: 2,backgroundColor: Colors.white,color: Color(0xFF0B3054)))
                                : Text(
                                  widget.provider.sitesGovernment == 0
                                  ? '0'
                                  : formatter.format(widget.provider.sitesGovernment),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
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
                                  style: TextStyle(color: Colors.grey[800],fontSize: 10,fontFamily: ''),
                                ),
                                SizedBox(height: 2),
                                widget.provider.apiVaccine
                                ? SizedBox(height: 2,width: 40, child: LinearProgressIndicator(minHeight: 2,backgroundColor: Colors.white,color: Color(0xFF0B3054)))
                                : Text(
                                  widget.provider.sitesPrivate == 0
                                  ? '0'
                                  : formatter.format(widget.provider.sitesPrivate),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
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
            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
            decoration: BoxDecoration(
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
                        'Available vaccine in India',
                        style: TextStyle(color: Colors.grey[800],fontSize: 11,fontFamily: ''),
                      ),
                      SizedBox(height: 5),
                      widget.provider.apiVaccine
                      ? SizedBox(height: 4,width: 40, child: LinearProgressIndicator(minHeight: 2,backgroundColor: Colors.white,color: Color(0xFF0B3054)))
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
                                Flexible(child: Text(widget.provider.vaccineName[index],style: TextStyle(color: Colors.black,fontSize: 10)))
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
              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 1.0
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Register or SignIn with CoWIN Portal',
                      style: TextStyle(color: Colors.blue,fontSize: 13,fontFamily: ''),
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
              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [ BoxShadow(color: Colors.blue,blurRadius: 1.0)]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'States Report',
                      style: TextStyle(color: Colors.blue,fontSize: 13,fontFamily: ''),
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
              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [ BoxShadow(color: Colors.blue,blurRadius: 1.0)]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Verify Certificate',
                      style: TextStyle(color: Colors.blue,fontSize: 13,fontFamily: ''),
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
                    text: 'CoWIN',
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
