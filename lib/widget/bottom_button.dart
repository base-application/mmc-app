import 'dart:io';

import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget{

  final Widget child;

  const BottomButton({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(top: 0,left: 16,right: 16),
      margin: EdgeInsets.only(bottom: Platform.isIOS ? 0 : 16),
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Container(
          child: child,
        ),
      ),
    );
  }

}