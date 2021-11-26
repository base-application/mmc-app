import 'dart:async';

import 'package:flutter/material.dart';

class St extends StatefulWidget {
  const St({Key? key}) : super(key: key);

  @override
  _StState createState() => _StState();
}

class _StState extends State<St> {
  StreamController<List<int>> controller = StreamController();

  @override
  void initState() {
    controller.add([1,2,3]);
    super.initState();
  }
  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
     body: Container(
      alignment: FractionalOffset.center,
      color: Colors.white,
      child: StreamBuilder<List<int>>(
        stream: controller.stream,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          List<Widget> children;

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                children = const <Widget>[
                  Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Select a lot'),
                  )
                ];
                break;
              case ConnectionState.waiting:
                children = const <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting bids...'),
                  )
                ];
                break;
              case ConnectionState.active:
                children = snapshot.data!.map((e) => Text(e.toString())).toList();
                break;
              case ConnectionState.done:
                children = snapshot.data!.map((e) => Text(e.toString())).toList();
                break;
            }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          );
        },
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () { controller.sink.add([123]);},
    ),
  );
}
}
