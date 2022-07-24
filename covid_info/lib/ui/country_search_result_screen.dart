import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constant/helper_about.dart';
import '../model/response/vaccine_response.dart';
import '../utils/VaccinationDialog.dart';
import '../controllers/covid_status_controller.dart';

class CountrySearchResult extends StatefulWidget {
  final bool vaccineResult;
  const CountrySearchResult({super.key, required this.vaccineResult});

  @override
  State createState() => _CountrySearchResultState();
}

class _CountrySearchResultState extends State<CountrySearchResult> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CovidStatusProvider>(
      create: (context) => CovidStatusProvider(),
      child: Consumer<CovidStatusProvider>(
        builder: (context, provider, child) {
          return CountryMainScreen(provider: provider,vaccine: widget.vaccineResult);
        },
      ),
    );
  }
}

class CountryMainScreen extends StatefulWidget {
  final bool vaccine;
  final CovidStatusProvider provider;
  const CountryMainScreen({super.key, required this.provider,required this.vaccine});
  @override
  State createState() => _CountryMainScreen();
}

class _CountryMainScreen extends State<CountryMainScreen> {

  var formatter = NumberFormat('#,##,###');
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       widget.vaccine
       ? widget.provider.worldVaccineCases(true)
       : widget.provider.countryCases(true);
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
          backgroundColor: const Color(0xFF0B3054),
          title: const Text('Worldwide',style: TextStyle(fontSize: 14)),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: [
            IconButton(
              onPressed: () => {
                if(widget.provider.showSearchBar){
                  widget.provider.searchBarVisibility(false),
                  widget.vaccine
                  ? widget.provider.searchCountryVaccine("")
                  : widget.provider.searchCountry("")
                }else{
                  widget.provider.searchBarVisibility(true)
                }
              },
              icon: Icon(
                widget.provider.showSearchBar
                ? Icons.cancel
                : Icons.search,
                color: Colors.white
              )
            )
          ]
        ),
        floatingActionButton: widget.provider.countrySearchTopVisible
          ? FloatingActionButton(
            backgroundColor: const Color(0xFF0B3054),
            isExtended: false,
            mini: true,
            onPressed: () => _scrollController.animateTo(0.0, duration: const Duration(seconds: 1), curve: Curves.bounceInOut),
            child: const Icon(Icons.arrow_upward_sharp,size: 18),
          )
          : null,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: widget.provider.showSearchBar,
              child: Container(
                margin: const EdgeInsets.only(top: 4,left: 4,right: 4,bottom: 4),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
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
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.text,
                        cursorColor: const Color(0xFF0B3054),
                        cursorWidth: 1.5,
                        autofocus: true,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z \u0900-\u097F]"))],
                        style: const TextStyle(color: Colors.black,fontFamily: '',fontSize: 14),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search country',
                          hintStyle: TextStyle(color: Colors.grey[400],fontSize: 12,fontFamily: '')
                        ),
                        onChanged: (input){
                          widget.vaccine
                          ? widget.provider.searchCountryVaccine(input)
                          : widget.provider.searchCountry(input);
                        }
                      )
                    )
                  ]
                )
              )  
            ),
            widget.vaccine
            ? Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: const Color(0xFFE3F2FD),
                    padding: const EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            'Country',
                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                          )
                        ),
                        Expanded(
                          child: Text(
                            'Vaccine',
                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right
                          )
                        ),
                        Expanded(
                          child: Text(
                            '1 Day',
                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right
                          )
                        ),
                        Expanded(
                          child: Text(
                            'Dose2',
                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right
                          )
                        ),
                        Expanded(
                          child: Text(
                            '% Dose2',
                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right
                          )
                        )
                      ]
                    )
                  ),
                  const Divider(height: 1,thickness: 1),
                  Expanded(
                    child: widget.provider.apiWorldVaccine
                    ? const Center(child: CircularProgressIndicator(strokeWidth: 1.5,valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B3054))))
                    : widget.provider.worldVaccineResponse.isNotEmpty
                      ? vaccineBodyWidget()
                      : const Center(child: Text('No result found'))
                  )
                ],
              )
            )
            : Expanded(
                child: widget.provider.apiCountry
                ? const Center(child: CircularProgressIndicator(strokeWidth: 1.5,valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B3054))))
                : widget.provider.countryResponse.isNotEmpty
                  ? coronaBodyWidget()
                  : const Center(child: Text('No result found'))
              )
          ]
        )
      )
    );
  }

  Widget vaccineBodyWidget(){
    var response = widget.provider.worldVaccineResponse;
    return RefreshIndicator(
      color: const Color(0xff0B3054),
      displacement: 20.0,
      onRefresh: refresh,
      child: Scrollbar(
        radius: const Radius.circular(15),
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: response.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            var length = response[index].data.length;
            return GestureDetector(
              onTap: () => showCountryDialog(response[index]),
              child: Container(
                color: index%2 == 0 ? Colors.white : Colors.grey[100],
                padding: const EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        response[index].country,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10)
                      )
                    ),
                    Expanded(
                      child: Text(
                        response[index].data[length - 1].totalVaccinations != null
                        ? response[index].data[length - 1].totalVaccinations.toString()
                        : 'N/A',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10)
                      )
                    ),
                    Expanded(
                      child: Text(
                        response[index].data[length - 1].dailyVaccinations != null
                        ? response[index].data[length - 1].dailyVaccinations.toString()
                        : 'N/A',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10)
                      )
                    ),
                    Expanded(
                      child: Text(
                        response[index].data[length - 1].peopleFullyVaccinated != null
                        ? response[index].data[length - 1].peopleFullyVaccinated.toString()
                        : 'N/A',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10)
      
                      )
                    ),
                    Expanded(
                      child: Text(
                        response[index].data[length - 1].peopleFullyVaccinatedPerHundred != null
                        ? response[index].data[length - 1].peopleFullyVaccinatedPerHundred! > 100.00
                          ? '100%'
                          : '${response[index].data[length - 1].peopleFullyVaccinatedPerHundred}%'
                        : 'N/A',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10)
                      )
                    )
                  ]
                )
              )
            );
          }, 
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 1,thickness: 1)
        )
      )
    );
  }

  Widget coronaBodyWidget(){
    var response = widget.provider.countryResponse;
    return RefreshIndicator(
      color: const Color(0xff0B3054),
      displacement: 20.0,
      onRefresh: refresh,
      child: Scrollbar(
        radius: const Radius.circular(15),
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: response.length,
          itemBuilder: (context,index){
            return Container(
              margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
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
                          style: const TextStyle(color: Colors.black,fontSize: 18,fontFamily: '',fontWeight: FontWeight.bold),
                        )
                      ),
                      const SizedBox(width: 5),
                      Image.network(
                        'https://flagcdn.com/w160/${HelperAbout.flagCode[response[index].country]}.png',
                        height: 22,
                        width: 22,
                        errorBuilder: (context,exception,stackTrace) => const Icon(Icons.flag)
                      )
                    ]
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cases',style: TextStyle(color:Colors.grey[700],fontSize: 11,fontFamily: '')),
                            Text(
                              response[index].cases == null
                              ? 'N/A'
                              : formatter.format(response[index].cases),
                              style: const TextStyle(color: Colors.blue,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: '')
                            )
                          ]
                        )
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Recovered',style: TextStyle(color:Colors.grey[700],fontSize: 11,fontFamily: '')),
                            Text(
                              response[index].recovered == null
                              ? 'N/A'
                              : formatter.format(response[index].recovered),
                              style: const TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: '')
                            )
                          ]
                        )
                      ) 
                    ]
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Deaths',style: TextStyle(color:Colors.grey[700],fontSize: 11,fontFamily: '')),
                            Text(
                              response[index].deaths == null
                              ? 'N/A'
                              : formatter.format(response[index].deaths),
                              style: const TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: '')
                            )
                          ]
                        )
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Active',style: TextStyle(color:Colors.grey[700],fontSize: 11,fontFamily: '')),
                            Text(
                              response[index].active == null
                              ? 'N/A'
                              : formatter.format(response[index].active),
                              style: const TextStyle(color: Colors.teal,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: '')
                            )
                          ]
                        )
                      )
                    ]
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Critical Cases',style: TextStyle(color:Colors.grey[700],fontSize: 11,fontFamily: '')),
                            Text(
                              response[index].critical == null
                              ? 'N/A'
                              : formatter.format(response[index].critical),
                              style: const TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: '')
                            )
                          ]
                        )
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('New Cases',style: TextStyle(color:Colors.grey[700],fontSize: 11,fontFamily: '')),
                            Text(
                              response[index].todayCases == null
                              ? 'N/A'
                              : formatter.format(response[index].todayCases),
                              style: const TextStyle(color: Colors.blue,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: '')
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
        )
      )
    );
  }

  Future<void> refresh() async {
    widget.vaccine
    ? await widget.provider.worldVaccineCases(false)
    : await widget.provider.countryCases(false);
  }

  Future<bool> backPressed() async{
    Navigator.pop(context,'Ali Hasan');
    return true;
  }

  showCountryDialog(VaccinationResponse response){
    showGeneralDialog(
      context: context,
      barrierLabel: 'Vaccine', 
      barrierDismissible: true,
      transitionBuilder: (context, anim, _, child){
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return VaccinationDialog(response: response);
      }
    );
  }
}
