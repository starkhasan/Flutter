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
  Widget build(BuildContext context) {
    return Container();
  }
}
