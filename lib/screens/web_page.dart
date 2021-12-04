import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String title;
  final String initUrl;
  const WebPage({Key? key, required this.title, required this.initUrl}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: loading,
            child: const Center(child: CircularProgressIndicator()),
          ),
          WebView(
            initialUrl: widget.initUrl,
            onPageFinished: (_){
              loading = true;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
