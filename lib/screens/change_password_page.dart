import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordPageState();
  }
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String? password;
  String? oldPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child:  Text("* Your Current Password"),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16,right: 16),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: const Color(0xffEBEBEB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffEBEBEB))
                  ),
                ),
                validator: (v){
                  if(v!= null && v.isEmpty){
                    return "不能为空";
                  }
                },
                onSaved: (v){
                  oldPassword = v;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12,top: 12),
                child: Text("* Your New Password"),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16,right: 16),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: const Color(0xffEBEBEB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffEBEBEB))
                  ),
                ),
                validator: (v){
                  if(v!= null && v.isEmpty){
                    return "不能为空";
                  }
                },
                onSaved: (v){
                  password = v;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12,top: 12),
                child: Text("*Confirm Your Password"),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 16,right: 16),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xffEBEBEB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffEBEBEB))
                  ),
                ),
                validator: (v){
                  if(v!= null && v.isEmpty){
                    return "不能为空";
                  }
                  if(password!=v){
                    return "两次输入的密码不一致";
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 45,
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xffFBB714)),
              foregroundColor: MaterialStateProperty.all(const Color(0xff013B7B)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
            ),
            onPressed: () {
              _formKey.currentState!.save();
              if(_formKey.currentState!.validate()){
                updatePassword(context,oldPassword!,password!).then((value) {
                  if(value){
                    ComFun.showToast(msg: "修改成功");
                    AutoRouter.of(context).pop();
                  }
                });
              }
            },
            child: const Text("Confirm",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}
