import 'package:flutter/material.dart';
import 'package:notes_todo/helper/delete_notes_dialog.dart';
import 'package:notes_todo/providers/authentication_provider.dart';
import 'package:notes_todo/service/authentication_service.dart';
import 'package:notes_todo/utils/preferences.dart';
import 'package:provider/provider.dart';

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
          title: const Text('Sync Notes',style: TextStyle(fontSize: 14)),
        ),
        body: StreamBuilder(
          stream: AuthenticationService().onAuthStateChange,
          builder: (context,snapshot){
            return 
            snapshot.data == null
            ? const LogoutPage()
            : Consumer<AuthenticationProvider>(
              builder: (context,provider,child){
                return LoginPage(authProvider: provider);
              }
            );
          }
        )
      )
    );
  }
}

class LoginPage extends StatefulWidget {
  final AuthenticationProvider authProvider;
  const LoginPage({ Key? key,required this.authProvider}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Preferences.getAppTheme() ? const Color(0xFF161616) : Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(widget.authProvider.isSyncEnabled ? Icons.sync : Icons.sync_disabled_sharp,size: 22,color: widget.authProvider.isSyncEnabled ? Colors.green : Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.authProvider.isSyncEnabled
                          ? 'Sync Enabled'
                          : 'Sync Disabled',
                          style: TextStyle(fontSize: 12,color: widget.authProvider.isSyncEnabled ? Colors.green : Colors.red,fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'All your notes data sync with your registered id',
                                style: TextStyle(fontSize: 11,color: Preferences.getAppTheme() ? Colors.white : Colors.black)
                              ),
                              TextSpan(
                                text: ' on Google Firebase Cloud. Notes automatically sync with Firebase Cloud at the time of notes creating and deletion',
                                style: TextStyle(fontSize: 11,color: Preferences.getAppTheme() ? Colors.white : Colors.black)
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
                              widget.authProvider.isSyncEnabled
                              ? 'Enabled Sync'
                              : 'Disabled Sync',
                              style: const TextStyle(fontSize: 12)
                            ),
                            Switch(
                              value: widget.authProvider.isSyncEnabled, 
                              onChanged: (value) => {
                                if(value) Preferences.setSyncExplicitly(true),
                                widget.authProvider.modifySyncData()
                              }
                            )
                          ]
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Preferences.getUserEmail(),style: const TextStyle(fontSize: 12)),
                                  const Text('Account Linked',style: TextStyle(color: Colors.grey,fontSize: 10))
                                ]
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () => widget.authProvider.logoutUser(),
                                child: const Text('Sign out',style: TextStyle(fontSize: 11))
                              )
                            )
                          ]
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Delete All Notes',style: TextStyle(fontSize: 12)),
                                  Text('Delete all your notes from Firebase Cloud',style: TextStyle(color: Colors.grey,fontSize: 10)),
                                ]
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: widget.authProvider.isSyncDataDelete
                              ? SizedBox(height: 4,child: LinearProgressIndicator(backgroundColor: Preferences.getAppTheme() ? const Color(0xFF161616) : Colors.white,color: Theme.of(context).toggleableActiveColor))
                              : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red
                                ),
                                onPressed: () => deleteNotesDialog(context),
                                child: const Text('Delete',style: TextStyle(fontSize: 11))
                              )
                            )
                          ]
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

  deleteNotesDialog(BuildContext _context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return DeleteNotesDialog(
          titleDialog: 'Delete all sync data',
          contentDialog: 'Are you sure you want to delete all sync data?',
          onPressed: () => {
            widget.authProvider.deleteUserData(_context),
            Navigator.pop(context)
          }
        );
      }
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
  var nameCont = TextEditingController();
  var passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Preferences.getAppTheme() ? const Color(0xFF161616) : Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<AuthenticationProvider>(
                    builder: (context,provider,child){
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.sync_disabled_sharp,size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Sync Notes',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                                const SizedBox(height: 5),
                                const Text("Sync your notes with Google Firebase Cloud. you can restore them when you reinstall Notes Todo App. Your notes will also sync to your phone's internal storage",style: TextStyle(fontSize: 11)),
                                const SizedBox(height: 5),
                                const Text("Currently your notes data is stored internally",style: TextStyle(color: Colors.red,fontSize: 11)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => provider.turnSingIn(false,nameCont.text,emailCont.text,passwordCont.text),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 2.0,color: provider.isLoginUser ? Colors.transparent : Preferences.getAppTheme() ? Theme.of(context).toggleableActiveColor : Colors.indigo))
                                          ),
                                          padding: const EdgeInsets.only(top: 12,bottom: 12),
                                          child: Text('Sign up',textAlign: TextAlign.center,style: TextStyle(fontSize: 12,color: provider.isLoginUser ? Colors.grey : Preferences.getAppTheme() ? Theme.of(context).toggleableActiveColor : Colors.indigo, fontWeight: FontWeight.bold))
                                        )
                                      )
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => provider.turnSingIn(true,'',emailCont.text,passwordCont.text),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 2.0,color: provider.isLoginUser ? Theme.of(context).toggleableActiveColor : Colors.transparent))
                                          ),
                                          padding: const EdgeInsets.only(top: 12,bottom: 12),
                                          child: Text('Sign in',textAlign: TextAlign.center,style: TextStyle(fontSize: 12,color: provider.isLoginUser ? Theme.of(context).toggleableActiveColor : Colors.grey,fontWeight: FontWeight.bold))
                                        )
                                      )
                                    )
                                  ]
                                ),
                                const SizedBox(height: 10),
                                Visibility(
                                  visible: !provider.isLoginUser,
                                  child: TextField(
                                    controller: nameCont,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(fontSize: 12),
                                    cursorColor: Theme.of(context).toggleableActiveColor,
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).toggleableActiveColor))
                                    ),
                                    onChanged: (value) => provider.fillEmailPassword(value,emailCont.text, passwordCont.text)
                                  )
                                ),
                                TextField(
                                  controller: emailCont,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(fontSize: 12),
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Theme.of(context).toggleableActiveColor,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).toggleableActiveColor))
                                  ),
                                  onChanged: (value) => provider.fillEmailPassword(nameCont.text,value, passwordCont.text)
                                ),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: passwordCont,
                                  obscureText: provider.showPassword,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  style: const TextStyle(fontSize: 12),
                                  cursorColor: Theme.of(context).toggleableActiveColor,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: provider.passwordVisibility,
                                      icon: provider.showPassword ? const Icon(Icons.lock,size: 20,color: Colors.grey) : const Icon(Icons.lock_open,size: 20,color: Colors.grey)
                                    ),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).toggleableActiveColor))
                                  ),
                                  onChanged: (value) => provider.fillEmailPassword(nameCont.text,emailCont.text, value)
                                ),
                                const SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.center,
                                  child: provider.isAuthProcess
                                  ? Container(margin: const EdgeInsets.only(top : 10),height: 30,width: 30,child: CircularProgressIndicator(
                                      color: Theme.of(context).toggleableActiveColor,strokeWidth: 2.0
                                      )
                                    )
                                  : ElevatedButton(
                                    onPressed: provider.isEmailPasswordAvail
                                      ? () => provider.userAuthenticate(provider.isLoginUser,context,nameCont.text,emailCont.text,passwordCont.text)
                                      : null,
                                    style: ElevatedButton.styleFrom(primary: Theme.of(context).toggleableActiveColor),
                                    child: Text(
                                      provider.isLoginUser
                                      ? 'Sign in'
                                      : 'Sign up',
                                      style: TextStyle(fontSize: 12,color: Preferences.getAppTheme() ? Colors.black : Colors.white)
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
            )
          )
        ]
      )
    );
  }
}
