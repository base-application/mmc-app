import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:mmc/bean/master_category_entity.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';

class MasterClassListPage extends StatefulWidget {
  const MasterClassListPage({Key? key}) : super(key: key);

  @override
  _MasterClassListPageState createState() => _MasterClassListPageState();
}

class _MasterClassListPageState extends State<MasterClassListPage> {
  late Future<List<MasterCategoryEntity>> _master;
  @override
  void initState() {
    _master = masterClass(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.masterClassLower),
      ),
      body: FutureBuilder(
        future: _master,
        builder: (BuildContext context, AsyncSnapshot<List<MasterCategoryEntity>> snapshot) {
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
            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children:  snapshot.data!.map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12,),
                      Row(
                        children: [
                          Text(e.categoryName??"",style: const TextStyle(color:  Color(0xffFBB714),fontSize: 20,fontWeight: FontWeight.bold),),
                          const Text("  (Slide LEFT)",style: TextStyle(color:  Color(0xffFBB714),fontSize: 12,fontWeight: FontWeight.bold))
                        ],
                      ),
                      const SizedBox(height: 12,),
                      SizedBox(
                        height: (MediaQuery.of(context).size.width/2-26)*1.2,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: classChild(e),
                        ),
                      ),
                    ],
                  )).toList(),
                ),
              ),
            );
          }
          return stateNoDate();

        },)
    );
  }

  classChild(MasterCategoryEntity key) {
    List<MasterCategoryCourses>? claes = key.courses;
    List<Widget> child = [];
    claes?.forEach((aClass) {
      child.add(Container(
        margin: const EdgeInsets.only(right: 16),
        width:  MediaQuery.of(context).size.width/2-26,
        height: (MediaQuery.of(context).size.width/2-26)*1.2,
        child: MasterCard(masterClassEntity: aClass,),
      ));
    });
    return child;
  }
}


class MasterCard extends StatelessWidget {
  final MasterCategoryCourses masterClassEntity;
  const MasterCard({Key? key, required this.masterClassEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(masterClassEntity.type == 1){
          AutoRouter.of(context).push(MasterDetailRoute(classId: masterClassEntity.id!));
        }
        if(masterClassEntity.type == 2){
          AutoRouter.of(context).push(MasterClassItemRoute(title: masterClassEntity.courseName!, classId: masterClassEntity.id!,));
        }
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(18),
            color: Colors.black12,
            image: DecorationImage(
              image: Image.network(
                masterClassEntity.coursePhoto!,
                loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                ){
                    return const CircularProgressIndicator();
                },
              ).image,
              fit: BoxFit.cover
            )
        ),
        child: Container(
          padding: const EdgeInsets.only(bottom: 12,top: 10,left: 10,right: 10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
            color: Colors.black38,
          ),
          child:  Text(masterClassEntity.courseName!,style: const TextStyle(color: Color(0xffFBB714),fontSize: 18,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}

