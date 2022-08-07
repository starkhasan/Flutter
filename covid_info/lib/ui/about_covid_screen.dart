import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant/helper_about.dart';


class AboutCovid extends StatefulWidget {
  const AboutCovid({Key? key}) : super(key: key);


  @override
  State createState() => _AboutCovidState();
}

class _AboutCovidState extends State<AboutCovid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers:[
          const SliverAppBar(
            backgroundColor: Color(0xFF0B3054),
            centerTitle: true,
            floating: true,
            title: Text('About',style: TextStyle(fontSize: 16)),
            expandedHeight: kToolbarHeight,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              infoWidget()
            ])
          )
        ]
      )
    );
  }

  Widget infoWidget(){
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is Corona',
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            HelperAbout.aboutCrona
          ),
          const Text(
            '\nSymptoms',
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            HelperAbout.aboutSymptoms1,
            style: const TextStyle(color: Colors.black),
          ),
          const Text(
            '\nLess  common symptoms',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 5,top: 2),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listLessSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.circle,color: Colors.green,size: 8),
                    const SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listLessSymptoms[index],style: const TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          ),
          const Text(
            '\nMost common symptoms',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 5,top: 2),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listCommonSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.circle,color: Colors.amber,size: 8),
                    const SizedBox(width: 5),
                    Text(HelperAbout.listCommonSymptoms[index],style: const TextStyle(color: Colors.black))
                  ]
                )
              );
            }
          ),
          const Text(
            '\nSerious common symptoms',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 5,top: 2),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listSeriousSymptoms.length,
            itemBuilder: (context,index){
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.circle,color: Colors.red,size: 8),
                    const SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listSeriousSymptoms[index],style: const TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          ),
          Text(
            HelperAbout.aboutSymptoms2,
            style: const TextStyle(color: Colors.black)
          ),
          const SizedBox(height: 20),
          Center(child: Image.asset('assets/images/symptoms.jpg',height: MediaQuery.of(context).size.height * 0.15)),
          const SizedBox(height: 20),
          const Text(
            'Prevention',
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: '')
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 5,top: 2),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: HelperAbout.listPreventation.length,
            itemBuilder: (context,index){
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.circle,color: Colors.blue,size: 8),
                    const SizedBox(width: 5),
                    Flexible(child: Text(HelperAbout.listPreventation[index],style: const TextStyle(color: Colors.black)))
                  ]
                )
              );
            }
          ),
          Center(child: Image.asset('assets/images/prevention.jpg',height: MediaQuery.of(context).size.height * 0.40,width: MediaQuery.of(context).size.width * 0.70))
        ]
      )
    );
  }
}