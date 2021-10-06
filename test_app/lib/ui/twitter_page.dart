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
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_rounded)
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.search_sharp)
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.notifications_none_rounded)
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.email_outlined)
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () => print('Click on Drawer Icon'),icon: const Icon(Icons.menu),color: Colors.lightBlue),
                SizedBox(width: 20,height: 20, child: Image.asset('asset/twitter.png')),
                IconButton(onPressed: () => print('Star is Clicked'),icon: const Icon(Icons.star,color: Colors.lightBlue))
              ]
            )
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  titleSpacing: 0,
                  backgroundColor: const Color(0xFF323232),
                  floating: true,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.12,
                  title: Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    padding: EdgeInsets.zero,
                    child: ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8,right: 8),
                              child: const CircleAvatar(
                                backgroundColor: Colors.lightBlue,
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
                            ),
                            const SizedBox(height: 5),
                            const Text('Ali',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),)
                          ]
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
                radius: 28,
                backgroundImage: NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(text: 'Ali Hasan'),
                              TextSpan(text: ' @alihasan226  1h',style: TextStyle(color: Colors.grey))
                            ]
                          )
                        ),
                        IconButton(
                          onPressed: () => print('Click on Tweet'),
                          padding: const EdgeInsets.only(left: 8),
                          icon: const Icon(Icons.more_horiz,color: Colors.grey)
                        )
                      ]
                    ),
                    const Text('Do martians make science fiction about people on Earth, and if they do, are we always the bad guys?',style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.zero,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ')
                        )
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.chat_bubble_outline,size: 20,color: Colors.grey),
                            SizedBox(width: 2),
                            Text('270',style:TextStyle(color: Colors.grey,fontSize: 11))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.repeat_outlined,size: 20,color: Colors.grey),
                            SizedBox(width: 2),
                            Text('317',style:TextStyle(color: Colors.grey,fontSize: 11))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.favorite_border,size: 20,color: Colors.grey),
                            SizedBox(width: 2),
                            Text('270',style:TextStyle(color: Colors.grey,fontSize: 11))
                          ],
                        ),
                        InkWell(
                          onTap: () => print('Share'),
                          child: const Icon(Icons.share,size: 20,color: Colors.grey)
                        )
                      ]
                    ),
                    const SizedBox(height: 5)
                  ]
                ),
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