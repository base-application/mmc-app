
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:provider/provider.dart';

GlobalKey<_HomeAppBarState> childKeyHomeAppBar = GlobalKey();
class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeAppBarState();
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(80);
  }
}

class _HomeAppBarState extends State<HomeAppBar> {

  changeNavigationTo(int index) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 26, right: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.homeIndexHello, style: const  TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87,),),
              const SizedBox(height: 2,),
              GestureDetector(
                onTap: (){
                },
                child: Text(Provider.of(context)
                    .watch<PersonalProfileService>().getPersonalProfileInfo?.name ?? '-', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87,),),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: netImgWrap(context,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              url: Provider.of(context)
                  .watch<AuthService>().getLoginInfo?.avatar,
              errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 50, height: 50, fit: BoxFit.fitWidth,),
            ),
          )
        ],
      ),
    );
  }
}


class CountryCodeInfo {
  final int id;
  final String iso2;
  final String phonecode;
  final String nativeName;
  final String name;
  final List<CountryCodeTimezonesInfo>? timezones;
  final Translations translations;

  CountryCodeInfo.fromJson(Map<String, dynamic> result):
        id = result.containsKey('id') && result['id'] != null ? result['id'] : 0,
        iso2 = result.containsKey('iso2') && result['iso2'] != null ? result['iso2'] : '',
        phonecode = result.containsKey('phonecode') && result['phonecode'] != null ? result['phonecode'] : '',
        nativeName = result.containsKey('nativeName') && result['nativeName'] != null ? result['nativeName'] : '',
        name = result.containsKey('name') && result['name'] != null ? result['name'] : '',
        translations = result.containsKey('translations') && result['translations'] != null ? Translations.fromJson(jsonDecode(result['translations'])) : Translations(),
        timezones = result.containsKey('nativeName') ? (json.decode(result['timezones']) as List).map((v) => CountryCodeTimezonesInfo.fromJson(v)).toList() : [];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iso2'] = iso2;
    data['phonecode'] = phonecode;
    data['nativeName'] = nativeName;
    data['timezones'] = timezones;
    data['name'] = name;
    return data;
  }
}

class Translations{

  String? cn;
  Translations.fromJson(Map<String, dynamic> result):
  cn =  result.containsKey('cn') && result['cn'] != null ? result['cn'] : null
  ;

  Translations();
}

class CountryCodeTimezonesInfo {
  final String zoneName;
  final String abbreviation;

  CountryCodeTimezonesInfo.fromJson(Map<String, dynamic> result):
        zoneName = result.containsKey('zoneName') && result['zoneName'] != null ? result['zoneName'] : '',
        abbreviation = result.containsKey('abbreviation') && result['abbreviation'] != null ? result['abbreviation'] : '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zoneName'] = zoneName;
    data['abbreviation'] = abbreviation;
    return data;
  }
}
