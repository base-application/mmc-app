import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputSelect extends StatefulWidget {
  final List<String> name;
  const InputSelect({Key? key, required this.name}) : super(key: key);

  @override
  _InputSelectState createState() => _InputSelectState();
}

class _InputSelectState extends State<InputSelect> {

  late List<String> name;

  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    name = widget.name;
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
                    controller: _controller,
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
                        name = widget.name;
                      }else{
                        name = widget.name.where((element) => (element).toLowerCase().contains(v.toLowerCase())).toList();
                      }
                      setState((){});
                    },
                  )
              ),
              const SizedBox(width: 10,),
              TextButton(
                  onPressed: (){ AutoRouter.of(context).pop(_controller.text);},
                  child:  Text(AppLocalizations.of(context)!.hintLoginConfirmBtn,style:  const TextStyle(fontWeight: FontWeight.bold),)
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
              physics:  const ClampingScrollPhysics(),
              padding:  const EdgeInsets.all(16),
              children: name.map<Widget>((e) =>
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      _controller.text = e;
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 12,bottom: 12),
                          child: Text(e,style:  const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
