import 'package:block_arch/bloc/authentication_bloc.dart';
import 'package:block_arch/bloc/bloc_states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BlocAuthenticationExample extends StatelessWidget {
  const BlocAuthenticationExample({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Bloc Authentication',style: TextStyle(fontSize: 14))),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AuthenticationBloc, AuthState>(
          listener:(context, state) {
            if(state is AuthSucess){
              showSnackBar(context,'Authentication Successfull');
            }else if(state is AuthFailed){
              showSnackBar(context,'Authentication Failed');
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(label: Text('Email'),hintText: 'Email'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(label: Text('Password'),hintText: 'Password')
                ),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: () => context.read<AuthenticationBloc>().add(AuthEventLogin(email: emailController.text,password: passwordController.text)),child: const Text('Done'))
              ]
            );
          }
        )
      )
    );
  }

  void showSnackBar(BuildContext context, String messaga){
    var snackBar = SnackBar(duration: const Duration(seconds: 1),content: Text(messaga,style: const TextStyle(fontSize: 14)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
