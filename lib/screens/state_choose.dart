import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/bean/state_item_info_entity.dart';

class StateChoose extends StatefulWidget {
  final List<StateItemInfoEntity> states;
  const StateChoose({Key? key, required this.states}) : super(key: key);

  @override
  _StateChooseState createState() => _StateChooseState();
}

class _StateChooseState extends State<StateChoose> {
  late List<StateItemInfoEntity> _states;

  @override
  void initState() {
    _states = widget.states;
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
                        _states = widget.states;
                      }else{
                        _states =widget.states.where((element) => (element.name).toLowerCase().contains(v.toLowerCase())).toList();
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
              children: _states.map<Widget>((e) =>
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
                          child: Text(e.name,style:  const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
}
