import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selectedIndex = 0;

  void selectIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.black
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              color: Colors.grey[900],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Image.asset('asset/facebook.png'),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => print('Click on Search'),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.grey[700],shape: BoxShape.circle),
                          child: const Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => print('Click on Search'),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.grey[700],shape: BoxShape.circle),
                          child: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => print('Click on Search'),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.grey[700],shape: BoxShape.circle),
                          child: const Icon(Icons.menu),
                        ),
                      )
                    ]
                  )
                ]
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              color: Colors.grey[900],
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => selectIndex(0),
                    child: Icon(Icons.home,size: 28,color: selectedIndex == 0 ? Colors.blue : Colors.white),
                  ),
                  GestureDetector(
                    onTap: () => selectIndex(1),
                    child: Icon(Icons.group,size: 28,color: selectedIndex == 1 ? Colors.blue : Colors.white),
                  ),
                  GestureDetector(
                    onTap: () => selectIndex(2),
                    child: Icon(Icons.message,size: 28,color: selectedIndex == 2 ? Colors.blue : Colors.white)
                  ),
                  GestureDetector(
                    onTap: () => selectIndex(3),
                    child: Icon(Icons.video_collection,size: 28,color: selectedIndex == 3 ? Colors.blue : Colors.white)
                  ),
                  GestureDetector(
                    onTap: () => selectIndex(4),
                    child: Icon(Icons.notification_add,size: 28,color: selectedIndex == 4 ? Colors.blue : Colors.white),
                  ),
                  GestureDetector(
                    onTap: () => selectIndex(5),
                    child: Icon(Icons.group_work_rounded,size: 30,color: selectedIndex == 5 ? Colors.blue : Colors.white),
                  )
                ]
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ')
                    )
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Post a status update',
                        hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)
                      ),
                    ),
                  ),
                  const VerticalDivider(thickness: 1,color: Colors.grey,),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: const [
                          Icon(Icons.photo),
                          Text('Photo')
                        ]
                      )
                    ),
                    onTap: () => print('Add Photo'),
                  )
                ]
              )
            ),
            const Divider(height: 0.5,thickness: 0.5,color: Color(0xFF212121)),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 15,bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.edit,size: 18,color: Colors.blue),
                        SizedBox(width: 2),
                        Text('Text')
                      ]
                    )
                  )
                ),
                Container(color: Colors.grey[400],width: 1,height: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 15,bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.video_call,size: 18,color: Colors.red),
                        SizedBox(width: 2),
                        Text('Video')
                      ]
                    )
                  )
                ),
                Container(color: Colors.grey[400],width: 1,height: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 15,bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.location_pin,size: 18,color: Colors.pink),
                        SizedBox(width: 2),
                        Text('Location')
                      ]
                    )
                  )
                )
              ]
            ),
            Container(
              color: Colors.grey[700],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: () => print('$index click'),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      margin: const EdgeInsets.only(left: 8, top: 8,bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ')
                        )
                      ),
                      child: index == 0
                      ? Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: const Text('Add to Story',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: const EdgeInsets.only(top: 30),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                                ),
                                child: const Icon(Icons.add_circle,color: Colors.blue,size: 40)
                              ),
                            )
                          ]
                        )
                      : Stack(
                          children: [
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Text('Ali Hasan $index',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(3)
                                ),
                                child: Text('$index',style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            )
                          ]
                        )
                    )
                  );
                }
              )
            ),
            const Divider(height: 5,thickness: 5,color: Colors.black),
            ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 28,
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundImage: NetworkImage('https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ'),
                                  )
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Ali Hasan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    )
                                  ),
                                  Text(
                                    '28m : Facebook for Android',
                                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)
                                  )
                                ]
                              )
                            ]
                          ),
                          IconButton(
                            onPressed: () => print('Share post'),
                            icon: const Icon(Icons.more_horiz)
                          )
                        ]
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(text: 'Dominent performance by Mumbai Indian last night !'),
                            TextSpan(text: '\n\nThe mindset was positive from the start and it showed in the execution too. That is the spirit of '),
                            TextSpan(text: '#OneFamily\n\n#RRvMI',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue))
                          ]
                        ),
                      )
                    ]
                  )
                );
              },
              separatorBuilder: (context,index){
                return const Divider(thickness: 5,color: Colors.black);
              },
              itemCount: 10
            )
          ]
        ),
      ),
    );
  }
}