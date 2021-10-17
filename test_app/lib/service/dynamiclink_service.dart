import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future<void> handleDynamicLink() async {
    //get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();

    //handle the link that has been reterived
    _handleDeepLink(data);
    
    //Register a link callback if the app is opened from background using the dynamic link
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        _handleDeepLink(dynamicLink);
      }, 
      onError: (OnLinkErrorException e) async {
        print('LinkErro ${e.message}');
      }
    );
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    var deepLink = data!.link;
    if (deepLink != null) {
      print('_handleDeepLink : deeplink $deepLink');
    }
  }
}
