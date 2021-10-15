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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sync Notes'),
        ),
        body: StreamBuilder(
          stream: AuthenticationService().onAuthStateChange,
          builder: (context,snapshot){
            return 
              snapshot.data == null
              ? const LogoutPage()
              : const LoginPage();
          }
        )
      )
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Consumer<AuthenticationProvider>(
        builder: (context,provider,child){
          return Row(
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
                            text: Preferences.getUserEmail(),
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
                          ? 'Enabled Sync'
                          : 'Disabled Sync'
                        ),
                        Switch(
                          value: provider.isSyncEnabled, 
                          onChanged: (value) => provider.modifySyncData()
                        )
                      ]
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Preferences.getUserEmail(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            const Text('Account Linked',style: TextStyle(color: Colors.grey,fontSize: 12))
                          ]
                        ),
                        ElevatedButton(
                          onPressed: () => provider.logoutUser(),
                          child: const Text('Sign out')
                        )
                      ]
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Delete All Notes',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            Text('This will delete all your notes from Firebase Cloud',style: TextStyle(color: Colors.grey,fontSize: 12)),
                          ]
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                          onPressed: () => provider.deleteUserData(),
                          child: const Text('Delete')
                        )
                      ]
                    )
                  ]
                ),
              )
            ]
          );
        }
      )
    );
  }
}



class LogoutPage extends StatefulWidget {
  const LogoutPage({ Key? key}) : super(key: key);

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  var emailCont = TextEditingController();

  var passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('Build UI Again');
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        children: [
          Consumer<AuthenticationProvider>(
            builder: (context,provider,child){
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.sync_disabled_sharp),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sync Notes',style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const Text("Sync your notes with Google Firebase. you can restore them when you reinstall Notes Todo App. Your notes will also sync to your phone's internal storage"),
                        const SizedBox(height: 10),
                        const Text("Currenly your notes data is stored internally",style: TextStyle(color: Colors.red)),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => provider.turnSingIn(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 2.0,color: provider.isLoginUser ? Colors.transparent : Colors.indigo))
                                  ),
                                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                                  child: Text('Sign up',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: provider.isLoginUser ? Colors.grey : Colors.indigo, fontWeight: FontWeight.bold))
                                )
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => provider.turnSingIn(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 2.0,color: provider.isLoginUser ? Colors.indigo : Colors.transparent))
                                  ),
                                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                                  child: Text('Sign in',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: provider.isLoginUser ? Colors.indigo : Colors.grey,fontWeight: FontWeight.bold))
                                )
                              ),
                            )
                          ]
                        ),
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
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () => provider.userAuthenticate(provider.isLoginUser,context,emailCont.text,passwordCont.text), 
                            child: Text(
                              provider.isLoginUser
                              ? 'Sign in'
                              : 'Sign up'
                            )
                          )
                        )
                      ]
                    )
                  )
                ]
              );
            }
          )
        ]
      )
    );
  }
}
