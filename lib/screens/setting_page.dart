
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:provider/src/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  final List<MenuDoItem> _menus = [];

  @override
  Widget build(BuildContext context) {
    _menus.clear();
    _menus.addAll([
      MenuDoItem(
        iconAssets: 'assets/icon/set_personal_profile.png',
        label: AppLocalizations.of(context)!.personalProfileTitle,
        onTap: () {
          AutoRouter.of(context).push(const PersonalProfileSetRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/set_business_profile.png',
        label: AppLocalizations.of(context)!.businessProfileTitle,
        onTap: () {
          AutoRouter.of(context).push(const BusinessProfileSetRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/set_change_password.png',
        label: AppLocalizations.of(context)!.changePassword,
        onTap: () {
          AutoRouter.of(context).push(const ChangePasswordRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/set_guideline.png',
        label:  AppLocalizations.of(context)!.guideline,
        onTap: () {
          AutoRouter.of(context).push(const GuidelineRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/set_about_us.png',
        label: AppLocalizations.of(context)!.aboutUs,
        onTap: () {
          AutoRouter.of(context).push(WebRoute(title: 'About Us', initUrl: 'https://mastermindcouncil.asia/'));
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/set_new_user_tour.png',
        label: AppLocalizations.of(context)!.userTour,
        onTap: () {
          // AutoRouter.of(context).push(const GuidelineRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/set_privacy_policy.png',
        label: AppLocalizations.of(context)!.privacyPolicy,
        onTap: () {
          // AutoRouter.of(context).push(const GuidelineRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/set_term_of_service.png',
        label:AppLocalizations.of(context)!.termService,
        onTap: () {
          // AutoRouter.of(context).push(const GuidelineRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/set_language.png',
        label: AppLocalizations.of(context)!.language,
        onTap: () {
          AutoRouter.of(context).push(const LanguageSetRoute());
        },
      ),
    ]);

    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              netImgWrap(context,
                width: 100,
                height: 100,
                radius: 100,
                url: context.watch<AuthService>().getLoginInfo?.avatar,
                errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 100, height: 100, fit: BoxFit.fitWidth,),
              ),
              const SizedBox(height: 16,),
              Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.name ?? '-', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
              const SizedBox(height: 4,),
              Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.concatNumber ?? '-', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87.withAlpha(120),),),
              const SizedBox(height: 28,),
              Column(
                children: _menus.map((item) => GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10,),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF043B94),
                                    Color(0xFF095BD4),
                                  ],
                                ),
                              ),
                              child: Image.asset(item.iconAssets, width: 18, height: 18,),
                            ),
                            const SizedBox(width: 12,),
                            Text(item.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.black87,),
                      ],
                    ),
                  ),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    item.onTap?.call();
                  },
                )).toList(),
              ),
              const SizedBox(height: 40,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 46,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: Text(AppLocalizations.of(context)!.loginOut, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 16, fontWeight: FontWeight.bold,),),
                  onPressed: () async {
                    ComFun.outLogin(context);
                  },
                ),
              ),
              const SizedBox(height: 60,),
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: AppLocalizations.of(context)!.setting,
      pageBg: Colors.white,
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}
