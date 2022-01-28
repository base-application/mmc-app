import 'package:flutter/material.dart';
import 'package:mmc/bean/master_class_entity.dart';
import 'package:mmc/screens/master_list_page.dart';

class MasterClassItemPage extends StatefulWidget {
  final String title;
  final List<MasterClassEntity> clazz;
  const MasterClassItemPage({Key? key, required this.title, required this.clazz}) : super(key: key);

  @override
  _MasterClassItemPageState createState() => _MasterClassItemPageState();
}

class _MasterClassItemPageState extends State<MasterClassItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16),
        child:  Wrap(
          spacing: 20,
          runSpacing: 12,
          children: classChild(),
        ),
      ),
    );
  }

  classChild() {
    List<Widget> child = [];
    for (MasterClassEntity aClass in widget.clazz) {
      child.add(SizedBox(
        width:  MediaQuery.of(context).size.width/2-26,
        height: (MediaQuery.of(context).size.width/2-26)*1.2,
        child: MasterCard(masterClassEntity: aClass,),
      ));
    }
    return child;
  }
}
