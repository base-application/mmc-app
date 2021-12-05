import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/router/router.gr.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF043D98),
            Color(0xFF0859D2),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Text(AppLocalizations.of(context)!.loginPageWelcome, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white,), textAlign: TextAlign.center,),
            ),
            Image.asset('assets/image/logo.png', width: MediaQuery.of(context).size.width * 0.36, height: MediaQuery.of(context).size.width * 0.36,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(1),
                      ),
                      child: Text(AppLocalizations.of(context)!.signIn, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1),),
                      onPressed: () {
                        AutoRouter.of(context).push(SignInRoute());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF657C7F)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(1),
                      ),
                      child: Text(AppLocalizations.of(context)!.signUp, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1),),
                      onPressed: () {
                        AutoRouter.of(context).push(SignUpRoute(type: 1));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                    width: MediaQuery.of(context).size.width,
                  ),
                  GestureDetector(
                    onTap: (){
                      AutoRouter.of(context).push(HomeRoute());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom+30),
                      child: Text(AppLocalizations.of(context)!.inputLoginSurfAsAGuestTip, style: const TextStyle(fontSize: 13, color: Colors.white,),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
