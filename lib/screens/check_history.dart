import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/check_log_entity.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CheckHistoryPage extends StatefulWidget {
  const CheckHistoryPage({Key? key}) : super(key: key);

  @override
  _CheckHistoryPageState createState() => _CheckHistoryPageState();
}

class _CheckHistoryPageState extends State<CheckHistoryPage> with SingleTickerProviderStateMixin {
  late Future<List<CheckLogEntity>> _future;

  @override
  void initState() {
    _future = checkHistory(context,1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.checkInHistoryTitle),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<CheckLogEntity>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return  ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF043B94),
                        Color(0xFF095BD4),
                      ],
                    ),
                  ),
                  child:Row(
                    children: [
                      getIcon(snapshot.data![index]),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data![index].eventTitle??"",style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,)),
                          Text(DateFormat('EEE, d MMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data![index].createTime??0)),
                            style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }else{
            return  stateNoDate(inRef: true);
          }

        },)
    );
  }

  getIcon(CheckLogEntity checkLogEntity) {
    if(checkLogEntity.checkType == 1){
      return Image.asset("assets/icon/check_in.png",width: 40,height: 40,);
    }else{
      return Image.asset("assets/icon/check_out.png",width: 40,height: 40,);
    }

  }
}
