import 'package:flutter/material.dart';
import 'package:mmc/bean/network_item_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/src/provider.dart';

class NetworkPersonPage extends StatefulWidget {
  const NetworkPersonPage({Key? key, required this.itemInfo}) : super(key: key);

  final NetworkItemInfoEntity itemInfo;

  @override
  State<StatefulWidget> createState() {
    return _NetworkPersonPageState();
  }
}

class _NetworkPersonPageState extends State<NetworkPersonPage> {
  bool _isLike = false;
  final List<String> _dos = [
    'assets/icon/call.png',
    'assets/icon/wechat.png',
    'assets/icon/facebook.png',
    'assets/icon/in.png',
    'assets/icon/video.png',
    'assets/icon/photo_mei.png',
  ];

  bool _doIsCan(int index) {
    if (index == 0) {
      return widget.itemInfo.concatNumber != null && widget.itemInfo.concatNumber!.isNotEmpty;
    }
    if (index == 1) {
      return widget.itemInfo.whatsapp != null && widget.itemInfo.whatsapp!.isNotEmpty;
    }
    if (index == 2) {
      return widget.itemInfo.facebook != null && widget.itemInfo.facebook!.isNotEmpty;
    }
    if (index == 3) {
      return widget.itemInfo.linkedin != null && widget.itemInfo.linkedin!.isNotEmpty;
    }
    if (index == 4) {
      return widget.itemInfo.youtube != null && widget.itemInfo.youtube!.isNotEmpty;
    }
    if (index == 5) {
      return widget.itemInfo.instagram != null && widget.itemInfo.instagram!.isNotEmpty;
    }
    return false;
  }

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

  List<PersonalProfileInfoCompanyVos> companyVos = [];

  int _displayCompanyInfoIndex = 0;
  PersonalProfileInfoCompanyVos? _displayCompanyInfo;

  @override
  void initState() {
    super.initState();
    _isLike = widget.itemInfo.isFriend == true;
    _initCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return Column(
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
                                url: widget.itemInfo.picture,
                                errorWidget: Image.asset('assets/image/personal_head_empty.png', fit: BoxFit.fitWidth,),
                              ),
                            ),
                            const SizedBox(width: 14,),
                            Expanded(child: Stack(
                              children: [
                                if (_getGroupZ(widget.itemInfo.gradeName) != null) Positioned(
                                  child: Image.asset(_getGroupZ(widget.itemInfo.gradeName)!, width: 90, height: 90,),
                                  top: 0,
                                  right: -12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10,),
                                    Text(widget.itemInfo.name ?? '-', style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold,),),
                                    const SizedBox(height: 5,),
                                    Text('ID:${widget.itemInfo.userId}', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                                    const SizedBox(height: 12,),
                                    Text(widget.itemInfo.industry ?? '-', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                                    const SizedBox(height: 6,),
                                    Text(widget.itemInfo.occupation ?? '-', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 3, overflow: TextOverflow.ellipsis,),
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
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0xFFF1F1EF),
                      ),
                      child: Image.asset(_dos[index], color: _doIsCan(index) ? null : Colors.grey, colorBlendMode: _doIsCan(index) ? null : BlendMode.srcATop,),
                    );
                  },
                ),
              ],
            ),
          ),
          if (companyVos.isNotEmpty) const SizedBox(height: 16,),
          if (companyVos.isNotEmpty) Row(
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
              Text('My Business Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
            ],
          ),
          if (companyVos.isNotEmpty) const SizedBox(height: 8,),
          if (companyVos.isNotEmpty) Container(
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
                    itemCount: companyVos.length,
                    itemBuilder: (BuildContext context, int index) {
                      PersonalProfileInfoCompanyVos companyItem = companyVos[index];
                      bool _businessDoIsCan(int index) {
                        if (index == 0) {
                          return companyItem.companyPhone != null && companyItem.companyPhone!.isNotEmpty;
                        }
                        if (index == 1) {
                          return companyItem.companyWhatsapp != null && companyItem.companyWhatsapp!.isNotEmpty;
                        }
                        if (index == 2) {
                          return companyItem.companyFacebook != null && companyItem.companyFacebook!.isNotEmpty;
                        }
                        if (index == 3) {
                          return companyItem.companyLinkedin != null && companyItem.companyLinkedin!.isNotEmpty;
                        }
                        if (index == 4) {
                          return companyItem.companyYoutube != null && companyItem.companyYoutube!.isNotEmpty;
                        }
                        if (index == 5) {
                          return companyItem.companyInstagram != null && companyItem.companyInstagram!.isNotEmpty;
                        }
                        return false;
                      }
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
                              itemCount: _dos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xFFF1F1EF),
                                  ),
                                  child: Image.asset(_dos[index], color: _businessDoIsCan(index) ? null : Colors.grey, colorBlendMode: _businessDoIsCan(index) ? null : BlendMode.srcATop,),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    onPageChanged: (page) {
                      _displayCompanyInfoIndex = page;
                      setState(() {
                        _displayCompanyInfo = companyVos[page];
                      });
                      _changeDisplayCompanyInfo();
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
                if (_displayCompanyInfoIndex < companyVos.length - 1) Positioned(
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
          if (companyVos.isNotEmpty) Padding(
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
          if (companyVos.isNotEmpty) Padding(
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
          if (companyVos.isNotEmpty) Padding(
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
          if (companyVos.isNotEmpty) Padding(
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
          if (companyVos.isNotEmpty) Padding(
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
          if ((_displayCompanyInfo?.producePictures.length ?? 0) > 0) const SizedBox(height: 20,),
          if (companyVos.isNotEmpty && _displayCompanyInfo != null) ListView.builder(
            padding: const EdgeInsets.only(left: 24, right: 24,),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _displayCompanyInfo!.producePictures.length,
            itemBuilder: (BuildContext context, int index) {
              PersonalProfileInfoCompanyVosProducePictures item = _displayCompanyInfo!.producePictures[index];
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
          if (companyVos.isNotEmpty) const SizedBox(height: 120,),
        ],
      );
    }

    return PageContainer(
      title: widget.itemInfo.name ?? '-',
      titleBarBgColor: Colors.white,
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: SingleChildScrollView(
          child: _scroll(),
        ),
      ),
      rightBtn: ({ int? homeIndex }) {
        return {
          Icon(_isLike ? Icons.favorite_rounded : Icons.favorite_border_rounded, size: 26,): (BuildContext ctx) {
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
                            child: Text(_isLike ? AppLocalizations.of(ctx)!.confirmUndoApplyFriend : AppLocalizations.of(ctx)!.confirmApplyFriend, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
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
                                    userFollowAdd(context, userId: widget.itemInfo.userId, result: () {
                                      ComFun.showToast(msg: _isLike ? AppLocalizations.of(context)!.friendUndoApplySuccessToast : AppLocalizations.of(context)!.friendApplySuccessToast);
                                      setState(() {
                                        _isLike = !_isLike;
                                      });
                                      eventBus.fire(FollowUserStateChangeEvent(isFollow: _isLike, userId: widget.itemInfo.userId));
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
          },
        };
      },
    );
  }

  _initCompanyData() async {
    PersonalProfileInfoEntity info =  await getUserDetailData(context, userId: widget.itemInfo.userId, silence: false);

    companyVos = info.companyVos;
    _displayCompanyInfo = null;
    if (companyVos.isNotEmpty) {
      _displayCompanyInfoIndex = 0;
      _displayCompanyInfo = companyVos.first;
      _changeDisplayCompanyInfo();
    }
    setState(() {});
  }

  _changeDisplayCompanyInfo() {
    _introductionController.text = _displayCompanyInfo!.companyIntroduction ?? '';
    _goalsController.text = _displayCompanyInfo!.companyGoals ?? '';
    _accomplishmentController.text = _displayCompanyInfo!.companyAccomplishments ?? '';
    _interestController.text = _displayCompanyInfo!.companyInterests ?? '';
    _productController.text = _displayCompanyInfo!.serviceIntroduction ?? '';
  }
}
