import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('WebView Page'),actions: [ NavigationController(webViewController: _controller.future)]),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: WebView(
          initialUrl: 'https://www.google.co.in/',
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        )
      ),
    );
  }
}

class NavigationController extends StatelessWidget {
  final Future<WebViewController> webViewController;
  const NavigationController({Key? key, required this.webViewController})
      : super(key: key);

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
