import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/bean/guide_line_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:provider/src/provider.dart';

class GuidelineDetailPage extends StatefulWidget {
  final GuideLineEntity guideLineEntity;
  const GuidelineDetailPage({Key? key, required this.guideLineEntity}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuidelineDetailPageState();
  }
}

class _GuidelineDetailPageState extends State<GuidelineDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.guideLineEntity.guideLineTitle),
      ),
      body: Image.network(
        context.read<SystemSetService>().baseUrl + widget.guideLineEntity.guideLineImage,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      ),

    );
  }
}
