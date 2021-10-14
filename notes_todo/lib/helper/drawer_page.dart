import 'package:flutter/material.dart';
import 'package:notes_todo/view/notes_backup_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({ Key? key }) : super(key: key);
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  List<IconData> icons = [Icons.sync,Icons.dark_mode_outlined];
  List<String> screenName = ['Sync Notes','Dark mode'];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png')
                      )
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    bottom: 10,
                    child: Text('Notes Todo',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold))
                  )
                ],
              )
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.90,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                itemCount: icons.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: () => pageNavigation(context,index),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(icons[index],color: Colors.indigo),
                          const SizedBox(width: 10),
                          Text(screenName[index],style: const TextStyle(fontSize: 16))
                        ]
                      ),
                    )
                  );
                }
              ),
            )
          ]
        )
      )
    );
  }

  pageNavigation(BuildContext _context,int index){
    switch (index) {
      case 0:
        Navigator.pop(_context);
        Navigator.push(_context, MaterialPageRoute(builder: (_context) => const NotesBackupPage()));
        break;
      case 1:
        Navigator.pop(_context);
        break;
      default:
        Navigator.pop(_context);
    }
  }
}