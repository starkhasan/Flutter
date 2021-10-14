import 'package:flutter/material.dart';
import 'package:notes_todo/providers/authentication_provider.dart';
import 'package:notes_todo/service/AuthenticationService.dart';
import 'package:provider/provider.dart';
import 'package:notes_todo/utils/preferences.dart';

class NotesBackupPage extends StatefulWidget {
  const NotesBackupPage({Key? key}) : super(key: key);

  @override
  _NotesBackupPageState createState() => _NotesBackupPageState();
}

class _NotesBackupPageState extends State<NotesBackupPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: Consumer<AuthenticationProvider>(builder: (context, provider, child) {
        return MainScreen(authProvider: provider);
      }),
    );
  }
}

class MainScreen extends StatefulWidget {
  final AuthenticationProvider authProvider;
  const MainScreen({Key? key,required this.authProvider}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sync Notes'),
      ),
      body: StreamBuilder(
        stream: AuthenticationService().onAuthStateChange,
        builder: (context,snapshot){
          return 
            snapshot.data == null
            ? LogoutPage(provider: widget.authProvider)
            : LoginPage(provider: widget.authProvider);
        }
      )
    );
  }
}

class LoginPage extends StatelessWidget {
  final AuthenticationProvider provider;
  const LoginPage({ Key? key,required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(provider.isSyncEnabled ? Icons.sync : Icons.sync_disabled_sharp,color: provider.isSyncEnabled ? Colors.green : Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.isSyncEnabled
                  ? 'Sync Enabled'
                  : 'Sync Disabled',
                  style: TextStyle(color: provider.isSyncEnabled ? Colors.green : Colors.red,fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'All your notes data sync with your id ',
                        style: TextStyle(color: Colors.black,fontSize: 12)
                      ),
                      TextSpan(
                        text: Preferences.getUserID(),
                        style: const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal)
                      ),
                      const TextSpan(
                        text: ' on Google Firebase. All your notes automatically sync with Firebase at the time of creating and deletion',
                        style: TextStyle(color: Colors.black,fontSize: 12)
                      )
                    ]
                  )
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      provider.isSyncEnabled
                      ? 'Disabled Sync'
                      : 'Enabled Sync'
                    ),
                    Switch(
                      value: provider.isSyncEnabled, 
                      onChanged: (value) => provider.modifySyncData()
                    )
                  ]
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => provider.logoutUser(),
                    child: const Text('Sign out')
                  )
                )
              ]
            ),
          )
        ]
      )
    );
  }
}



class LogoutPage extends StatelessWidget {
  final AuthenticationProvider provider;
  LogoutPage({ Key? key,required this.provider}) : super(key: key);

  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.sync_disabled_sharp),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Sync Notes',style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("Sync your notes with Google Firebase. you can restore them when you reinstall Notes Todo App. Your notes will also sync to your phone's internal storage"),
                    SizedBox(height: 10),
                    Text("Currenly your notes data is stored internally",style: TextStyle(color: Colors.red))
                  ]
                ),
              )
            ]
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailCont,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: passwordCont,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => provider.loginUser(context,emailCont.text,passwordCont.text), 
            child: const Text('Login')
          )
        ]
      )
    );
  }
}
