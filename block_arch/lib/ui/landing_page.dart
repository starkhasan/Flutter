import 'package:block_arch/ui/block/bloc_consumer_example.dart';
import 'package:block_arch/ui/block/weather_report_screen.dart';
import 'package:block_arch/ui/contact_details.dart';
import 'package:block_arch/ui/list_slidable.dart';
import 'package:block_arch/ui/multi_select_list.dart';
import 'package:block_arch/ui/single_select.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _listScreen = ['Counter Bloc','Weather Bloc','Contact Details','Single Select','Multi Select','List Slidable'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Landing Page'),
      ),
      body: ListView.builder(
        itemCount: _listScreen.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: () {
              switch (index) {
                case 0:
                  navigateScreen(context, const BlocConsumerExample());
                  break;
                case 1:
                  navigateScreen(context, const WeatherReportScreen());
                  break;
                case 2:
                  navigateScreen(context, const ContactDetails());
                  break;
                case 3:
                  navigateScreen(context, const SingleSelect());
                  break;
                case 4: 
                  navigateScreen(context, const MultiSelectList());
                  break;
                case 5:
                  navigateScreen(context, const ListSlidable());
                  break;
                default:
              }
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 2.0)]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_listScreen[index]),
                  const Icon(Icons.arrow_forward_ios)
                ]
              ),
            ),
          );
        }
      )
    );
  }

  navigateScreen(BuildContext context,Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}