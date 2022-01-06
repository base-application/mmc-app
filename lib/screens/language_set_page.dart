import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:provider/provider.dart';

class LanguageSetPage extends StatefulWidget {
  const LanguageSetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LanguageSetPageState();
  }
}

class _LanguageSetPageState extends State<LanguageSetPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Language"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              changeAppLanguageInfo(context,language:"en");
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
              margin: const EdgeInsets.only(left: 16,right: 16,top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF043B94),
                    Color(0xFF0D66E5),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("English",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  getMark("en")
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              changeAppLanguageInfo(context,language:"zh");
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
              margin: const EdgeInsets.only(left: 16,right: 16,top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF043B94),
                    Color(0xFF0D66E5),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("中文",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  getMark("zh")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getMark(String language) {
    if(Provider.of(context).read<SystemSetService>().appLanguage == language){
      return const Icon(CupertinoIcons.check_mark_circled,color: Colors.white,);
    }else{
      return const Icon(CupertinoIcons.check_mark_circled,color: Colors.transparent,);
    }
  }
}
