import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TwitterPage extends StatefulWidget {
  const TwitterPage({ Key? key }) : super(key: key);

  @override
  _TwitterPageState createState() => _TwitterPageState();
}

class _TwitterPageState extends State<TwitterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
        )
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () => print('Click on Drawer Icon'),icon: const Icon(Icons.menu),color: Colors.blue),
                SizedBox(width: 20,height: 20, child: Image.asset('asset/twitter.png')),
                IconButton(onPressed: () => print('Star is Clicked'),icon: const Icon(Icons.star,color: Colors.blue))
              ]
            )
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: const Color(0xFF323232),
                  floating: true,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.10,
                  title: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    padding: EdgeInsets.zero,
                    child: ListView.builder(
                      itemCount: 50,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const CircleAvatar(
                            backgroundColor: Colors.teal,
                            radius: 32,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xFF323232),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ'),
                              ),
                            ),
                          ),
                        );
                      }
                    )
                  ),
                  expandedHeight: kToolbarHeight,
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([ mainBody()])
                )
              ],
            )
          )
        ]
      )
    );
  }

  Widget mainBody(){
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(text: 'Peter Perz'),
                            TextSpan(text: ' @PeterPetraz  1h',style: TextStyle(color: Colors.grey))
                          ]
                        )
                      ),
                      InkWell(
                        onTap: () => print('Click on Tweet'),
                        child: const Icon(Icons.more_horiz,color: Colors.grey)
                      )
                    ]
                  ),
                  Container(padding: EdgeInsets.zero,color: Colors.red,height: 20,width: 20),
                  Container(
                    padding: EdgeInsets.zero,
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ')
                      )
                    ),
                  )
                ]
              )
            ]
          )
        );
      },
      separatorBuilder: (context, index){
        return const Divider(height: 1,thickness: 1,color: Colors.grey);
      }
    );
  }
}