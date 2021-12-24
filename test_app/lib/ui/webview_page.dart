import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test_app/utils/helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> with SingleTickerProviderStateMixin , Helper{ 
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  List<IconData> menuItems = [Icons.remove,Icons.home,Icons.notification_add,Icons.settings];
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.notification_add;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    menuAnimation = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
  }

  Widget flowMenuItem(IconData icon) {
    return GestureDetector(
      onTap: (){
        updateMenu(icon);
          menuAnimation.status == AnimationStatus.completed
          ? {
            menuItems[menuItems.length - 1] = Icons.add,
            menuAnimation.reverse()
          }
          : {
            menuItems[menuItems.length - 1] = Icons.settings,
            menuAnimation.forward()
          };
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30.0
        )
      )
    );
  }

  updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      if(icon == Icons.settings) {
        showSnackbar(context, 'Settings Click');
      } else if(icon == Icons.notification_add){
        showSnackbar(context, 'Notification Click');
      }else if(icon == Icons.home){
        showSnackbar(context, 'Home Click');
      }
      setState((){});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('WebView Page'),actions: [ NavigationController(webViewController: _controller.future)]),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: WebView(
              initialUrl: 'https://www.google.co.in/',
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              }
            )
          ),
          Flow(
            delegate: FlowMenuDelegate(menuAnimation: menuAnimation,parentContext: context),
            children: menuItems.map<Widget>((IconData icon) => flowMenuItem(icon)).toList(),
          )
        ]
      )
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.menuAnimation,required this.parentContext}) : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;
  final BuildContext parentContext;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dy = 0.0;
    double horizontalAxis = MediaQuery.of(parentContext).size.width * 0.80;
    double verticalAxis = MediaQuery.of(parentContext).size.height * 0.78;
    for (int i = 0; i < context.childCount; ++i) {
      dy = context.getChildSize(i)!.width * (-i);
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          horizontalAxis,
          dy * menuAnimation.value + verticalAxis,
          0,
        ),
      );
    }
  }
}

class NavigationController extends StatelessWidget with Helper{
  final Future<WebViewController> webViewController;
  NavigationController({Key? key, required this.webViewController}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: webViewController,
      builder: (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        var webViewReady = snapshot.connectionState == ConnectionState.done;
        WebViewController? controller = snapshot.data;
        return Row(
          children: [
            IconButton(
              onPressed: !webViewReady
                ? null
                : () async {
                  if(await controller!.canGoBack()){
                    await controller.goBack();
                  }else{
                    showSnackbar(context, 'No Previous Page Found');
                  }
                },
              icon: const Icon(Icons.arrow_back_ios)
            ),
            IconButton(
              onPressed: !webViewReady
                ? null
                : () async {
                  if(await controller!.canGoForward()){
                    await controller.goForward();
                  }else{
                    showSnackbar(context, 'No Next Page Found');
                  }
                },
              icon: const Icon(Icons.arrow_forward_ios)
            ),
            IconButton(
              onPressed: !webViewReady
                ? null
                : () => controller!.reload(),
              icon: const Icon(Icons.replay)
            )
          ]
        );
      }
    );
  }
}
