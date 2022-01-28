import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/bean/master_class_entity.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/master_data.dart';

class MasterClassListPage extends StatefulWidget {
  const MasterClassListPage({Key? key}) : super(key: key);

  @override
  _MasterClassListPageState createState() => _MasterClassListPageState();
}

class _MasterClassListPageState extends State<MasterClassListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.masterClass),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MasterData.category.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12,),
              Text(MasterData.category[index],style: const TextStyle(color:  Color(0xffFBB714),fontSize: 22,fontWeight: FontWeight.bold),),
              const SizedBox(height: 12,),
              Wrap(
                spacing: 20,
                runSpacing: 12,
                children: classChild(MasterData.category[index]),
              ),
            ],
          );
        },
      ),
    );
  }

  classChild(String key) {
    List<MasterClassEntity>? claes = MasterData.masterData[key];
    List<Widget> child = [];
    claes?.forEach((aClass) {
      child.add(SizedBox(
        width:  MediaQuery.of(context).size.width/2-26,
        height: (MediaQuery.of(context).size.width/2-26)*1.2,
        child: MasterCard(masterClassEntity: aClass,),
      ));
    });
    return child;
  }
}


class MasterCard extends StatelessWidget {
  final MasterClassEntity masterClassEntity;
  const MasterCard({Key? key, required this.masterClassEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(masterClassEntity.type == 1){
          AutoRouter.of(context).push(MasterDetailRoute(masterClassEntity: masterClassEntity));
        }
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: Image.network("https://alifei05.cfp.cn/creative/vcg/800/version23/VCG41175510742.jpg").image,
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
          child:  Text(masterClassEntity.title!,style: const TextStyle(color: Color(0xffFBB714),fontSize: 18,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}

