import 'package:flutter/material.dart';

class ComingSoonPage extends StatefulWidget {
  final  String title;
  const ComingSoonPage({Key? key, required this.title}) : super(key: key);

  @override
  _ComingSoonPageState createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Image.asset("assets/image/coming_soon1.png",width: MediaQuery.of(context).size.width*0.8,height:  MediaQuery.of(context).size.width*0.8,),
        ),
      ),
    );
  }
}
