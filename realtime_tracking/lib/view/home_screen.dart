import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:realtime_tracking/provider/home_provider.dart';
import 'package:realtime_tracking/service/location_sevice.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  var remoteAddressController = TextEditingController();
  var collectionUser = FirebaseFirestore.instance.collection('users');
  Stream userDocStream = FirebaseFirestore.instance.collection('users').doc('979234').snapshots();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      LocationService().getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tracking'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => LocationService().getCurrentLocation(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: userDocStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return const Center(child: Text('Something Went Wrong'));
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else{
            var mapData = snapshot.data.data();
            return Container(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        decoration: const BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your Address',style: TextStyle(color: Colors.white)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '979 234',
                                  style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(2),
                                  onPressed: () => print('Click Here to Share your address to other device'),
                                  icon: const Icon(Icons.share,color: Colors.white)
                                )
                              ]
                            )
                          ]
                        )
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey, width: 1.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: remoteAddressController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  labelText: 'Remote Address', isDense: true),
                            ),
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () => {
                                  provider.connectDevice(context, remoteAddressController.text, '979234')
                                },
                                child: Container(
                                  decoration: const BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                  padding: const EdgeInsets.only(top: 12, left: 18, bottom: 12, right: 18),
                                  child: const Text('Connect',style: TextStyle(color: Colors.white)),
                                )
                              ),
                            )
                          ]
                        )
                      )
                    ]
                  ),
                  Visibility(
                    visible: mapData['request'],
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5.0)),boxShadow: [BoxShadow(blurRadius: 5.0,color: Colors.grey)]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.cast,size: 20),
                                SizedBox(width: 15),
                                Expanded(child: Text('User want to acess your location')),
                              ]
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () => collectionUser.doc('979234').update({'request': false}),
                                  child: Container(
                                    decoration: const BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                    padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 8),
                                    child: const Text('Reject',style: TextStyle(color: Colors.white)),
                                  )
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: () => print('Click Here to Reject'),
                                  child: Container(
                                    decoration: const BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                    padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 8),
                                    child: const Text('Accept',style: TextStyle(color: Colors.white)),
                                  )
                                )
                              ]
                            )
                          ]
                        )
                      )
                    )
                  )
                ]
              )
            );
          }
        }
      )
    );
  }
}
