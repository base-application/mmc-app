import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef RightBtn = Map<Widget, Function(BuildContext ctx)>? Function({ int? homeIndex });

class HomeDefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeDefaultAppBar({Key? key, this.title, this.bgColor, this.initPageIndex, this.rightBtn}) : super(key: key);

  final String? title;
  final Color? bgColor;

  final int? initPageIndex;
  final RightBtn? rightBtn;

  @override
  State<StatefulWidget> createState() {
    return HomeDefaultAppBarState();
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(50);
  }
}

class HomeDefaultAppBarState extends State<HomeDefaultAppBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initPageIndex ?? 0;
  }

  changeNavigationTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  String _homeTitle(int index) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)!.appNavigatorHome;
      case 1:
        return AppLocalizations.of(context)!.appNavigatorNetwork;
      case 2:
        return AppLocalizations.of(context)!.appNavigatorCheckIn;
      case 3:
        return AppLocalizations.of(context)!.appNavigatorProfile;
    }
    return AppLocalizations.of(context)!.appNavigatorHome;
  }

  @override
  Widget build(BuildContext context) {
    List<Builder> _customRightBtn({ int? homeIndex }) {
      List<Builder> list = [];
      if (widget.rightBtn != null) {
        widget.rightBtn!.call(homeIndex: homeIndex)?.forEach((widget, fun) {
          list.add(Builder(builder: (ctx) {
            return GestureDetector(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: widget,
                constraints: const BoxConstraints(
                  minWidth: 50,
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                fun.call(ctx);
              },
            );
          }));
        });
      }
      return list;
    }
    return Container(
      color: widget.bgColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 4, right: 4,),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                const SizedBox(width: 80,),
                Expanded(
                  child: Text(widget.title ?? _homeTitle(_currentIndex), style: const TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold,), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,),
                ),
                const SizedBox(width: 80,),
              ],
            ),
          ),
          if (Navigator.canPop(context)) Positioned(
            child: GestureDetector(
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_back_ios_rounded, size: 20, color: Colors.black87,),
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            left: 0,
          ),
          if (widget.rightBtn != null) Positioned(
            child: Row(
              children: _customRightBtn(homeIndex: _currentIndex),
            ),
            right: 0,
          ),
        ],
      ),
    );
  }
}
