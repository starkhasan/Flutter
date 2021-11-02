import 'package:flutter/material.dart';
import 'package:inventory_control/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MainAuthenticationPage(),
    );
  }
}

class MainAuthenticationPage extends StatefulWidget {
  const MainAuthenticationPage({ Key? key }) : super(key: key);

  @override
  _MainAuthenticationPageState createState() => _MainAuthenticationPageState();
}

class _MainAuthenticationPageState extends State<MainAuthenticationPage> {

  double imageSize = 0.0;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    imageSize = MediaQuery.of(context).size.height * 0.16;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.blue),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child){
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 5,left: MediaQuery.of(context).size.width * 0.15,right: MediaQuery.of(context).size.width * 0.15,bottom: 5),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset('asset/app_icon.png',height: imageSize,width: imageSize)
                        ),
                        const Text(
                          'Authentication Users',
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => authProvider.tabSignIn(false),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 2,color: authProvider.userSignIn ? Colors.transparent : Colors.red))
                                  ),
                                  child: Text('Signup',textAlign: TextAlign.center,style: TextStyle(color: authProvider.userSignIn ? Colors.grey : Colors.black,fontWeight: FontWeight.bold))
                                ),
                              )
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => authProvider.tabSignIn(true),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 2,color: authProvider.userSignIn ? Colors.blue : Colors.transparent))
                                  ),
                                  child: Text('Signin',textAlign: TextAlign.center,style: TextStyle(color: authProvider.userSignIn ? Colors.black : Colors.grey,fontWeight: FontWeight.bold))
                                )
                              )
                            )
                          ]
                        ),
                        const SizedBox(height: 15),
                        Visibility(
                          visible: !authProvider.userSignIn,
                          child: TextField(
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 12),
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).toggleableActiveColor,
                            decoration: InputDecoration(
                              hintText: 'Inventory Name*',
                              hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).toggleableActiveColor))
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(fontSize: 12),
                          textInputAction: TextInputAction.next,
                          cursorColor: Theme.of(context).toggleableActiveColor,
                          decoration: InputDecoration(
                            hintText: 'Email*',
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).toggleableActiveColor))
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: authProvider.showPassword,
                          style: const TextStyle(fontSize: 12),
                          textInputAction: TextInputAction.done,
                          cursorColor: Theme.of(context).toggleableActiveColor,
                          decoration: InputDecoration(
                            hintText: 'Password*',
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).toggleableActiveColor)),
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: authProvider.passwordVisibility,
                              icon: authProvider.showPassword ? const Icon(Icons.lock,size: 20) : const Icon(Icons.lock_open,size: 20)
                            )
                          )
                        ),
                        const SizedBox(height: 15),
                        authProvider.authenticationProces
                        ? const CircularProgressIndicator(strokeWidth: 2.0)
                        : ElevatedButton(
                          onPressed: () => authProvider.userAuthenticate(context,nameController.text,emailController.text,passwordController.text),
                          child: const Text('Submit')
                        )
                      ]
                    )
                  ),
                )
              ]
            )
          );
        }
      )
    );
  }
}
