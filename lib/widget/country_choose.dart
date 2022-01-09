import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:provider/provider.dart';

import 'app_bar_home.dart';

class CountryChoose extends StatefulWidget {
  final List<CountryCodeInfo> curLocalData;
  const CountryChoose({Key? key, required this.curLocalData}) : super(key: key);

  @override
  _CountryChooseState createState() => _CountryChooseState();
}

class _CountryChooseState extends State<CountryChoose> {
  late List<CountryCodeInfo> country;
  @override
  void initState() {
    country = widget.curLocalData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:  const EdgeInsets.only(left: 16,top: 12,right: 16),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                    style:  const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)
                      ),
                    ),
                    onChanged: (v){
                      if(v.isEmpty){
                        country = widget.curLocalData;
                      }else{
                        country = widget.curLocalData.where((element) => (element.phonecode).toLowerCase().contains(v.toLowerCase()) || getName(element).toLowerCase().contains(v.toLowerCase())).toList();
                      }
                      setState((){});
                    },
                  )
              ),
              const SizedBox(width: 10,),
              GestureDetector(
                  onTap: (){
                    AutoRouter.of(context).pop();
                  },
                  child: const Icon(CupertinoIcons.clear_circled)
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
              physics:  const ClampingScrollPhysics(),
              padding:  const EdgeInsets.all(16),
              children: country.map<Widget>((e) =>
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      AutoRouter.of(context).pop(e);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 12,bottom: 12),
                          child: Text(getName(e),style:  const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        const Divider()
                      ],
                    ),
                  )
              ).toList()
          ),
        )
      ],
    );
  }

  String getName(CountryCodeInfo e) {
    if(context.read<SystemSetService>().appLanguage == "en"){
      return e.name + "(" +e.phonecode+")";
    }else{
      return (e.translations.cn??"") + "(" +e.phonecode+")";
    }
  }
}
