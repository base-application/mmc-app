import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mmc/bean/concat_item_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/utils/http_request.dart';

class NetworkPersonPage extends StatefulWidget {
  const NetworkPersonPage({Key? key,required this.userId}) : super(key: key);

  final int userId;

  @override
  State<StatefulWidget> createState() {
    return _NetworkPersonPageState();
  }
}

class _NetworkPersonPageState extends State<NetworkPersonPage> {
  late List<ConcatItemEntity> _dos = [];

  final Map<String, String> _groupZ = {
    'Crystal': 'assets/image/profile_z.png',
    'Elite': 'assets/image/profile_z.png',
    'Premiere': 'assets/image/profile_z.png',
    'MMC': 'assets/image/profile_z.png',
    'Platinum': 'assets/image/profile_z.png',
    'Titanium': 'assets/image/profile_z.png',
  };
  String? _getGroupZ(String? gradeName) {
    if (gradeName == null) {
      return null;
    }
    String? z;
    _groupZ.forEach((key, value) {
      if (key.toLowerCase() == gradeName.toLowerCase()) {
        z = value;
        return;
      }
    });
    return z;
  }

  final PageController _companyPageViewController = PageController();

  final TextEditingController _introductionController = TextEditingController();
  final TextEditingController _goalsController = TextEditingController();
  final TextEditingController _accomplishmentController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _productController = TextEditingController();


  int _displayCompanyInfoIndex = 0;

  late Future<PersonalProfileInfoEntity> userInfo;

  @override
  void initState() {
    userInfo = getUserDetailData(context, userId: widget.userId,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo,
      builder: (BuildContext context, AsyncSnapshot<PersonalProfileInfoEntity> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("加载中");
        }
        if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()),);
        }
        if(snapshot.hasData){
          PersonalProfileInfoEntity info = snapshot.data!;
          _dos = [
            ConcatItemEntity(info.concatNumber,'assets/icon/call.png'),
            ConcatItemEntity(info.whatsapp,'assets/icon/wechat.png'),
            ConcatItemEntity(info.facebook,'assets/icon/facebook.png'),
            ConcatItemEntity(info.linkedin,'assets/icon/in.png'),
            ConcatItemEntity(info.youtube,'assets/icon/video.png'),
            ConcatItemEntity(info.instagram,'assets/icon/photo_mei.png')
          ];
          return WillPopScope(
              onWillPop: () async {
                AutoRouter.of(context).popForced(info);
                return true;
              },
              child: Scaffold(
              appBar: AppBar(
                title: Text(info.name ?? '-'),
                actions: [
                  IconButton(onPressed: (){like(info);}, icon: Icon(info.friend == true ? Icons.favorite_rounded : Icons.favorite_border_rounded, size: 26,))
                ],
              ),
              body: SingleChildScrollView(
                child:  Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30),)
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4, left: 26, right: 26,),
                            height: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF043B94),
                                  Color(0xFF095BD4),
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Image.asset('assets/image/profile_logo_bg.png', width: 140, height: 140,),
                                  bottom: 20,
                                  right: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18,),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 120,
                                        height: double.infinity,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: netImgWrap(context,
                                          width: 120,
                                          height: double.infinity,
                                          url: info.picture,
                                          errorWidget: Image.asset('assets/image/personal_head_empty.png', fit: BoxFit.fitWidth,),
                                        ),
                                      ),
                                      const SizedBox(width: 14,),
                                      Expanded(child: Stack(
                                        children: [
                                          if (_getGroupZ(info.gradeName) != null) Positioned(
                                            child: Image.asset(_getGroupZ(info.gradeName)!, width: 90, height: 90,),
                                            top: 0,
                                            right: -12,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10,),
                                              Text(info.name ?? '-', style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold,),),
                                              const SizedBox(height: 5,),
                                              Text('ID:${info.userId}', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                                              const SizedBox(height: 12,),
                                              Text(info.industry ?? '-', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                                              const SizedBox(height: 6,),
                                              Text(info.occupation ?? '-', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 26, right: 26,),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                            ),
                            itemCount: _dos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  if( _dos[index].text !=null && _dos[index].text!.isNotEmpty){
                                    Clipboard.setData(ClipboardData(text: _dos[index].text));
                                    ComFun.showToast(msg: "copy success");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xFFF1F1EF),
                                  ),
                                  child: Image.asset(_dos[index].image, color: _dos[index].text!=null && _dos[index].text!.isNotEmpty ? null : Colors.grey, colorBlendMode: _dos[index].text!=null && _dos[index].text!.isNotEmpty ? null : BlendMode.srcATop,),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    company(info.companyVos)
                  ],
                ),
              )
          )
          );
        }
        return  const Center();

      },);
  }

  _changeDisplayCompanyInfo(PersonalProfileInfoCompanyVos vos) {
    _introductionController.text = vos.companyIntroduction ?? '';
    _goalsController.text = vos.companyGoals ?? '';
    _accomplishmentController.text = vos.companyAccomplishments ?? '';
    _interestController.text = vos.companyInterests ?? '';
    _productController.text = vos.serviceIntroduction ?? '';
  }

  like(PersonalProfileInfoEntity info){
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(180),
      barrierDismissible: true,
      builder: (BuildContext ctx) {
        return DialogWidget(
          title: '',
          content: '',
          slideMargin: 4,
          showTitle: false,
          showBottomDo: false,
          borderRadius: 14,
          outTapDismiss: true,
          contentExtend: Row(
            children: [
              Expanded(child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14,),
                    child: Text(info.friend == true ? AppLocalizations.of(ctx)!.confirmUndoApplyFriend : AppLocalizations.of(ctx)!.confirmApplyFriend, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
                  ),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 48,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Text(AppLocalizations.of(ctx)!.yes, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            userFollowAdd(context, userId: info.userId, result: () {
                              ComFun.showToast(msg: info.friend == true ? AppLocalizations.of(context)!.friendUndoApplySuccessToast : AppLocalizations.of(context)!.friendApplySuccessToast);
                              setState(() {
                                info.friend = !(info.friend??false);
                              });
                              eventBus.fire(FollowUserStateChangeEvent(isFollow: info.friend == true, userId: info.userId));
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        width: 130,
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: const Color(0xFF346295)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Text(AppLocalizations.of(ctx)!.cancel, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),
                ],
              )),
            ],
          ),
        );
      },
    );
  }

  company(List<PersonalProfileInfoCompanyVos> companies) {
   return Column(
      children: [
        const SizedBox(height: 16,),
        Row(
          children: [
            const SizedBox(width: 24,),
            Container(
              width: 5,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12,),
            const Text('My Business Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
          ],
        ),
        const SizedBox(height: 8,),
        Container(
          margin: const EdgeInsets.only(top: 4, left: 26, right: 26,),
          height: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF043B94),
                Color(0xFF095BD4),
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              ScrollConfiguration(
                behavior: CusBehavior(),
                child: PageView.builder(
                  controller: _companyPageViewController,
                  itemCount: companies.length,
                  itemBuilder: (BuildContext context, int index) {
                    PersonalProfileInfoCompanyVos companyItem = companies[index];
                    late List<ConcatItemEntity> _cdos = [
                      ConcatItemEntity(companyItem.companyPhone,'assets/icon/call.png'),
                      ConcatItemEntity(companyItem.companyWhatsapp,'assets/icon/wechat.png'),
                      ConcatItemEntity(companyItem.companyFacebook,'assets/icon/facebook.png'),
                      ConcatItemEntity(companyItem.companyLinkedin,'assets/icon/in.png'),
                      ConcatItemEntity(companyItem.companyYoutube,'assets/icon/video.png'),
                      ConcatItemEntity(companyItem.companyInstagram,'assets/icon/photo_mei.png')
                    ];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 18, right: 18,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4,),
                          Row(
                            children: [
                              netImgWrap(context,
                                width: 26,
                                height: 26,
                                radius: 14,
                                url: companyItem.companyLogo,
                                errorWidget: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.amber,
                                  ),
                                  child: Image.asset('assets/image/logo.png', width: 26, height: 26,),
                                ),
                              ),
                              const SizedBox(width: 12,),
                              Expanded(child: Text(companyItem.companyName ?? '-', style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500,), overflow: TextOverflow.ellipsis,),),
                            ],
                          ),
                          const SizedBox(height: 14,),
                          Text(companyItem.companyIntroduction ?? '-', style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                          const SizedBox(height: 12,),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(companyItem.companyWebsite ?? '-', style: TextStyle(fontSize: 13, color: Colors.amber.withAlpha(200), fontWeight: FontWeight.w300,),),
                              Text(companyItem.companyEmail ?? '-', style: TextStyle(fontSize: 13, color: Colors.amber.withAlpha(200), fontWeight: FontWeight.w300,),),
                            ],
                          )),
                          const SizedBox(height: 6,),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(left: 2, right: 2,),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                            ),
                            itemCount: _cdos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  if( _cdos[index].text !=null && _cdos[index].text!.isNotEmpty){
                                    Clipboard.setData(ClipboardData(text: _cdos[index].text));
                                    ComFun.showToast(msg: "copy success");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xFFF1F1EF),
                                  ),
                                  child: Image.asset(_cdos[index].image, color: _cdos[index].text !=null && _cdos[index].text!.isNotEmpty ? null : Colors.grey, colorBlendMode:  _cdos[index].text !=null && _cdos[index].text!.isNotEmpty ? null : BlendMode.srcATop,),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  onPageChanged: (page) {
                    _displayCompanyInfoIndex = page;
                    _changeDisplayCompanyInfo(companies[_displayCompanyInfoIndex]);
                    setState(() {});
                  },
                ),
              ),
              if (_displayCompanyInfoIndex > 0) Positioned(
                child: GestureDetector(
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(Icons.navigate_before_rounded, size: 18, color: Color(0xFF013B7B),),
                  ),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _companyPageViewController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
                  },
                ),
                left: -10,
              ),
              if (_displayCompanyInfoIndex < companies.length - 1) Positioned(
                child: GestureDetector(
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(Icons.navigate_next_rounded, size: 18, color: Color(0xFF013B7B),),
                  ),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _companyPageViewController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
                  },
                ),
                right: -10,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 26, right: 26,),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.networkPersonSimpleIntroduction, style: const TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w500,),),
                  const SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.only(left: 10, right: 10,),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                    ),
                    child: TextFormField(
                      controller: _introductionController,
                      keyboardType: TextInputType.text,
                      maxLines: 6,
                      readOnly: true,
                      cursorColor: Colors.blueAccent,
                      style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                      decoration: const InputDecoration(
                        // hintText: AppLocalizations.of(context)!.networkPersonSimpleIntroductionHint,
                        hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                        contentPadding: EdgeInsets.only(top: 10,),
                        counterText: '',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 26, right: 26,),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.networkPersonGoals, style: const TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w500,),),
                  const SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.only(left: 10, right: 10,),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                    ),
                    child: TextFormField(
                      controller: _goalsController,
                      keyboardType: TextInputType.text,
                      maxLines: 6,
                      readOnly: true,
                      cursorColor: Colors.blueAccent,
                      style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                      decoration: const InputDecoration(
                        // hintText: AppLocalizations.of(context)!.networkPersonGoalsHint,
                        hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                        contentPadding: EdgeInsets.only(top: 10,),
                        counterText: '',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 26, right: 26,),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.networkPersonAccomplishments, style: const TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w500,),),
                  const SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.only(left: 10, right: 10,),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                    ),
                    child: TextFormField(
                      controller: _accomplishmentController,
                      keyboardType: TextInputType.text,
                      maxLines: 6,
                      readOnly: true,
                      cursorColor: Colors.blueAccent,
                      style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                      decoration: const InputDecoration(
                        // hintText: AppLocalizations.of(context)!.networkPersonAccomplishmentsHint,
                        hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                        contentPadding: EdgeInsets.only(top: 10,),
                        counterText: '',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 26, right: 26,),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.networkPersonInterests, style: const TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w500,),),
                  const SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.only(left: 10, right: 10,),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                    ),
                    child: TextFormField(
                      controller: _interestController,
                      keyboardType: TextInputType.text,
                      maxLines: 6,
                      readOnly: true,
                      cursorColor: Colors.blueAccent,
                      style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                      decoration: const InputDecoration(
                        // hintText: AppLocalizations.of(context)!.networkPersonInterestsHint,
                        hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                        contentPadding: EdgeInsets.only(top: 10,),
                        counterText: '',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 26, right: 26,),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.networkPersonProduct, style: const TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w500,),),
                  const SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.only(left: 10, right: 10,),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                    ),
                    child: TextFormField(
                      controller: _productController,
                      keyboardType: TextInputType.text,
                      maxLines: 6,
                      readOnly: true,
                      cursorColor: Colors.blueAccent,
                      style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                      decoration: const InputDecoration(
                        // hintText: AppLocalizations.of(context)!.networkPersonProductHint,
                        hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                        contentPadding: EdgeInsets.only(top: 10,),
                        counterText: '',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),),
            ],
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.only(left: 24, right: 24,),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: companies[_displayCompanyInfoIndex].producePictures.length,
          itemBuilder: (BuildContext context, int index) {
            PersonalProfileInfoCompanyVosProducePictures item = companies[_displayCompanyInfoIndex].producePictures[index];
            return Container(
              margin: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: netImgWrap(context,
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.width - 2 * 24) * 9 / 16,
                  url: item.producePicture,
                  errorWidget: Container(color: Colors.grey.shade300,),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 120,),
      ],
    );
  }
}
