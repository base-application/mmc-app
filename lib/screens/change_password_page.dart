import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordPageState();
  }
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          child: Column(
            children: [
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: 'Change Password',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}
