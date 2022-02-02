import 'package:flutter/material.dart';
import 'package:test_app/ui/transaction_page.dart';

class Crypto extends StatefulWidget {
  const Crypto({ Key? key }) : super(key: key);

  @override
  _CryptoState createState() => _CryptoState();
}

class _CryptoState extends State<Crypto> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto',style: TextStyle(color: Colors.black,fontSize: 14)),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => showSnackBar(context,'Sorry!! Click on Navigation Bar Icon'),icon: const Icon(Icons.menu,color: Colors.black)),
        actions: [
          IconButton(onPressed: () => showSnackBar(context,'Sorry!! Click on Notificaiton Icon'), icon: const Icon(Icons.notification_add,color: Colors.black))
        ]
      ),
      body: mainBody()
    );
  }

  Widget mainBody(){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text('Hello,',style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const Text('Mr. Ali Hasan',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold)),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10085e),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Account Balance',style: TextStyle(color: Colors.white,fontSize: 16)),
                              const SizedBox(height: 8),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(text: '280.07',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold)),
                                    TextSpan(text: 'ETH',style: TextStyle(fontSize: 8,color: Colors.white))
                                  ]
                                )
                              ),
                              const SizedBox(height: 5),
                              Text('Freezing Amount : 1.0782 ETH',style: TextStyle(color: Colors.grey[200],fontSize: 10)),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () => onClickCardButton(0),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: selectedIndex == 0 ? Colors.blue : Colors.transparent,
                                          border: Border.all(color: selectedIndex == 0 ? Colors.blue : Colors.grey,width: 1),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Text('Deposit',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold))
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () => onClickCardButton(1),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: selectedIndex == 1 ? Colors.blue : Colors.transparent,
                                          border: Border.all(color: selectedIndex == 1 ? Colors.blue : Colors.grey,width: 1),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Text('Cash',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold))
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () => onClickCardButton(2),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: selectedIndex == 2 ? Colors.blue : Colors.transparent,
                                          border: Border.all(color: selectedIndex == 2 ? Colors.blue : Colors.grey,width: 1),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Text('Bill',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold))
                                      )
                                    )
                                  )
                                ]
                              )
                            ]
                          )
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 10,bottom: 10),
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,top: 5,bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(blurRadius: 2,color: Colors.grey)
                            ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => showSnackBar(context,'Sorry!! Apps is now in testing mode'),
                                    child: Container(
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.001),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.add,color: Colors.white,size: 28)
                                    )
                                  ),
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(18), // Image radius
                                      child: Image.network(
                                        'https://i.picsum.photos/id/0/5616/3744.jpg?hmac=3GAAioiQziMGEtLbfrdbcoenXoWAW-zlyEAMkfEdBzQ',
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                            if(loadingProgress == null) {
                                              return child;
                                            }
                                            return const Padding(padding: EdgeInsets.all(5),child: CircularProgressIndicator(strokeWidth: 2.0));
                                        },
                                        errorBuilder: (context, child, stackTrack) {
                                          return const Icon(Icons.image);
                                        }
                                      )
                                    ),
                                  )
                                ]
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Launch a Transaction',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                  Text('3,122 Launches',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 11))
                                ]
                              )
                            ]
                          )
                        );
                      }
                    ) 
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text('Tender Transaction',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15))
                        ),
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.timelapse,color: Colors.grey,size: 22),
                              SizedBox(width: 5),
                              Text('Nearly 3 days',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12))
                            ]
                          )
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                    child: Divider(height: 1,thickness: 1,color: Colors.grey[400])
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text('Blockhain Analysis Report',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15))
                        ),
                        Text('16.00 ETH',style: TextStyle(color: Color.fromARGB(255, 16, 209, 113),fontWeight: FontWeight.bold,fontSize: 16))
                      ]
                    )
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,right: MediaQuery.of(context).size.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Created : ${DateTime.now().toString().substring(0,10).split('-').reversed.join('-')}',style: const TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.normal)),
                            const SizedBox(width: 5),
                            const Text('Originator : Ali Hasan',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12))
                          ]
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionPage())),
                          child: Container(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Text('View',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 14))
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }

  onClickCardButton(int index){
    switch (index) {
      case 0:
        selectedIndex = 0;
        break;
      case 1:
        selectedIndex = 1;
        break;
      case 2:
        selectedIndex = 2;
        break;
      default:
    }
    setState(() {});
  }

  showSnackBar(BuildContext _context,String message){
    var snackbar = SnackBar(content: Text(message),duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}

