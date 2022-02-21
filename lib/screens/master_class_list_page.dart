import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mmc/bean/master_category_entity.dart';
import 'package:mmc/screens/master_list_page.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';

class MasterClassItemPage extends StatefulWidget {
  final String title;
  final int classId;
  const MasterClassItemPage({Key? key, required this.title, required this.classId}) : super(key: key);

  @override
  _MasterClassItemPageState createState() => _MasterClassItemPageState();
}

class _MasterClassItemPageState extends State<MasterClassItemPage> {
  late Future<List<MasterCategoryCourses>> _future;
  @override
  void initState() {
    _future = masterChild(context,widget.classId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<MasterCategoryCourses>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return LottieBuilder.asset(
              'assets/lottie/5039-planet.json',
              fit: BoxFit.contain,
            );
          }
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }
          if(snapshot.hasData){
            return  SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16),
              child:  Wrap(
                spacing: 20,
                runSpacing: 12,
                children: snapshot.data!.map((e) => SizedBox(
                  width:  MediaQuery.of(context).size.width/2-26,
                  height: (MediaQuery.of(context).size.width/2-26)*1.2,
                  child: MasterCard(masterClassEntity: e,),
                )).toList(),
              ),
            );
          }
          return stateNoDate();
        },),
    );
  }
}
