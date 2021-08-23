# Biometric Authentication in Flutter

Implementation of Biometric Authentication in Flutter using local_auth package

<img src="https://user-images.githubusercontent.com/40181783/130359040-f88c204b-7711-49e4-b6f8-57f32bf09a93.png" width="200">


Simple invoke this method to perform authentication
```
void authenticateUser() async{
  bool canCheckBiometrics = await auth.canCheckBiometrics;
  if(canCheckBiometrics){
     bool authenticate = await auth.authenticate(localizedReason: 'Scan your fingerprint to authenticate');
     if(authenticate)
        print('User Successfully Authenticated');
     else
        print('Invalid User');
  }
}
```

Integration

1. Android

In Android local_auth plugin requires the use of a FragmentActivity as opposed to Activity.

Updated MainActivity.kt
```
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
```
Update your project's AndroidManifest.xml file to include the USE_FINGERPRINT permissions:

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
  package="com.example.app">
  <uses-permission android:name="android.permission.USE_FINGERPRINT"/>
<manifest>
```
  

2. iOS
local_auth works with both Touch ID and Face ID. However, to use the latter, you need to also add:
 
```
<key>NSFaceIDUsageDescription</key>
<string>Why is my app authenticating using face id?</string>
```
to your Info.plist file.
