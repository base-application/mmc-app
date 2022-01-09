import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebPage extends StatefulWidget {
  final String title;
  final String initUrl;
  const WebPage({Key? key, required this.title, required this.initUrl}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.initUrl)),
            onLoadStop: (c, u) {
              log("stop webview");
              setState(() => loading = false);
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
          ),
          Visibility(visible: loading, child: const LinearProgressIndicator()),
        ],
      ),
    );
  }
}
