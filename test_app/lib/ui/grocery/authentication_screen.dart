import 'package:flutter/material.dart';
import 'package:test_app/ui/grocery/forgot_password_screen.dart';
import 'package:test_app/utils/helper.dart';
import 'package:test_app/utils/page_view_label_indicator.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({ Key? key }) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> with SingleTickerProviderStateMixin{

  late PageController pageController;
  List<String>  page = ['Signup','Signin'];
  final currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar(backgroundColor: Colors.green)),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(color: Colors.white,height: MediaQuery.of(context).size.height * 0.20,child: const Align(alignment: Alignment.center,child: Text('Grocery Plus',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)))),
            PageViewLabelIndicator(
              height: MediaQuery.of(context).size.height * 0.08,
              label: page,
              currentPageNotifier: currentPageNotifier,
              selectedColor: Colors.green,
              onPageSelect: (index) => {
                pageController.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.linear),
                currentPageNotifier.value = index
              }
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.72,
              padding: const EdgeInsets.all(15),
              child: PageView(
                controller: pageController,
                children: const [Signup(),Signin()],
                onPageChanged: (value) => currentPageNotifier.value = value,
              )
            )
          ]
        )
      )
    );
  }
}

class Signin extends StatefulWidget {
  const Signin({ Key? key }) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> with Helper{

  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: emailCont,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'abc@xyz.com*',
            hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
            prefixIcon: Icon(Icons.email)
          )
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordCont,
          obscureText: true,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(
            hintText: '********',
            hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
            prefixIcon: Icon(Icons.password)
          )
        ),
        GestureDetector(
          onTap: () => showSnackbar(context,'Click Here to Singin'),
          child: Container(
            margin: const EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 10),
            height: 40,
            decoration: const BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(5))),
            child: const Center(child: Text('Signin',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword())),
          child: const Align(alignment: Alignment.center,child: Text('Forgot your password?',style: TextStyle(fontSize: 14,color: Colors.grey)))
        )
      ]
    );
  }
}

class Signup extends StatefulWidget {

  const Signup({ Key? key }) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with Helper{

  var nameCont = TextEditingController();
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nameCont,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            hintText: 'Ali Hasan*',
            hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
            prefixIcon: Icon(Icons.person)
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: emailCont,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'abc@xyz.com*',
            hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
            prefixIcon: Icon(Icons.email)
          )
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordCont,
          obscureText: true,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(
            hintText: '********',
            hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
            prefixIcon: Icon(Icons.password)
          )
        ),
        GestureDetector(
          onTap: () => showSnackbar(context, 'Click Here to Singup'),
          child: Container(
            margin: const EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 10),
            height: 40,
            decoration: const BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(5))),
            child: const Center(child: Text('Signup',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)))
          )
        )
      ]
    );
  }
}