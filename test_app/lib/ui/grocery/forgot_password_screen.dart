import 'package:flutter/material.dart';
import 'package:test_app/utils/helper.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with Helper{

  var forgotPasswordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            centerTitle: false,
            backgroundColor: Colors.transparent,
            title: const Text('Forgot Password',style: TextStyle(color: Colors.black,fontSize: 16)),
            titleSpacing: 0,
            leading: IconButton(onPressed: () => Navigator.pop(context),icon: const Icon(Icons.arrow_back,color: Colors.black)),
          ),
          SliverList(delegate: SliverChildListDelegate([mainContent(context)]))
        ]
      )
    );
  }

  Widget mainContent(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,bottom: MediaQuery.of(context).size.height * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(alignment: Alignment.center,child: Icon(Icons.lock,color: Colors.black,size: 35)),
                TextField(
                  controller: forgotPasswordCont,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'abc@xyz.com*',
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
                    label: Text('Email'),
                    isDense: true
                  ),
                ),
                const SizedBox(height: 5),
                const Text("Enter the email associated with your account and we'll send an email to reset your password",style: TextStyle(color: Colors.grey,fontSize: 11)),
                GestureDetector(
                  onTap: () => showSnackbar(context,'Click Here to Forgot Password of account ${forgotPasswordCont.text}'),
                  child: Container(
                    margin: const EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 10),
                    height: 40,
                    decoration: const BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Center(child: Text('Forgot Password',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))
                  ),
                )
              ]
            )
          )
        ]
      )
    );
  }
}