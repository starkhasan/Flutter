import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';
import 'package:hello_flutter/utils/LanguageSettings/LanguagesData.dart';
import 'package:hello_flutter/utils/LanguageSettings/locale_constant.dart';

class MultiLanguages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MultiLanguages();
}

class _MultiLanguages extends State<MultiLanguages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text(Languages.of(context).labelSelectLanguage), centerTitle: true),
      body: Container(padding: EdgeInsets.all(15), child: _languageList()),
    );
  }

  Widget _languageList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: LanguagesData.languageList().length,
      itemBuilder: (context, index) {
        return Card(
            child: InkWell(
          onTap: () {
            changeLanguage(context, LanguagesData.languageList()[index].languageCode);
          },
          child: ListTile(
            leading: Icon(Icons.language),
            title: Text(LanguagesData.languageList()[index].name),
            trailing: Languages.of(context).chooseLanguage == LanguagesData.languageList()[index].name
                ? Icon(Icons.check, color: Colors.green)
                : null,
          ),
        ));
      },
    );
  }
}
