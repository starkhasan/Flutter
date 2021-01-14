import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_flutter/ui/MultiLanguages.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeDrawer();
}

class _HomeDrawer extends State<HomeDrawer> {
  List<String> listLanguage;
  @override
  Widget build(BuildContext context) {
    listLanguage = [Languages.of(context).language];
    return Drawer(
      elevation: 15.0,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                height: 200,
                child: Container(
                    color: Colors.blue[400],
                    child: Center(
                        child: Text(Languages.of(context).homeDrawerTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )
                          )
                        )
                      )
                    ),
            Expanded(
              child: _listViewBuilder(),
            )
          ],
        ),
      ),
    );
  }

  Widget _listViewBuilder() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: listLanguage.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          color: Colors.lightBlue[100],
          child: InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiLanguages()));
                  break;
                default:
              }
            },
            child: Ink(
              color: Colors.black,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.language, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    listLanguage[index],
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
