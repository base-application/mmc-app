import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mmc/screens/shining_board_page.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';

class ShiningBoardDetailPage extends StatefulWidget {
  const ShiningBoardDetailPage({Key? key, required this.about}) : super(key: key);

  final ShiningBoardInfo about;

  @override
  State<StatefulWidget> createState() {
    return _ShiningBoardDetailPageState();
  }
}

class _ShiningBoardDetailPageState extends State<ShiningBoardDetailPage> with TickerProviderStateMixin {
  late TabController _controller;
  List<Widget> pageTabs = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _updateTab();
    setState(() {});
    _controller = TabController(length: pageTabs.length, initialIndex: _currentPage, vsync: this);
    _controller.addListener(() {
      _currentPage = _controller.index;
      _updateTab();

      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _updateTab() {
    pageTabs.clear();
    pageTabs.addAll([
      const Tab(
        key: ValueKey('weeks'),
        child: Text('2 weeks',),
      ),
      const Tab(
        key: ValueKey('quarterly'),
        child: Text('quarterly',),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Widget _page(ValueKey key) {
      return SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 4,),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(child: Image.asset('assets/icon/rank_2.png', width: 28,), top: -19,),
                          Container(
                            width: 80,
                            height: 80,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              border: Border.all(width: 3, color: const Color(0xFF6E99C1))
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: CachedNetworkImage(
                                imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F30%2F20180730163717_gbqnc.thumb.700_0.jpg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639325025&t=f8fc41fac91d230208aba57888274cb4',
                                placeholder: (BuildContext context, String url,) {
                                  return Container(color: Colors.grey.shade300,);
                                },
                                fit: BoxFit.fill,
                                errorWidget: (BuildContext context, String url, dynamic error,) {
                                  return Container(color: Colors.grey.shade300,);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18,),
                      Text('Cecelia', style: TextStyle(fontSize: 18, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                      const SizedBox(height: 8,),
                      Text('Product Manager', style: TextStyle(fontSize: 13, color: Colors.black87.withAlpha(180), fontWeight: FontWeight.w400),),
                      const SizedBox(height: 14,),
                      Text('6,000', style: TextStyle(fontSize: 24, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(child: Image.asset('assets/icon/rank_1.png', width: 28,), top: -19,),
                          Container(
                            width: 100,
                            height: 100,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                border: Border.all(width: 3, color: const Color(0xFFFEAA29))
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: CachedNetworkImage(
                                imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F30%2F20180730163717_gbqnc.thumb.700_0.jpg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639325025&t=f8fc41fac91d230208aba57888274cb4',
                                placeholder: (BuildContext context, String url,) {
                                  return Container(color: Colors.grey.shade300,);
                                },
                                fit: BoxFit.fill,
                                errorWidget: (BuildContext context, String url, dynamic error,) {
                                  return Container(color: Colors.grey.shade300,);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18,),
                      Text('Cecelia Tay', style: TextStyle(fontSize: 22, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                      const SizedBox(height: 8,),
                      Text('Product Manager', style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(180), fontWeight: FontWeight.w400),),
                      const SizedBox(height: 14,),
                      Text('8,000', style: TextStyle(fontSize: 24, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(child: Image.asset('assets/icon/rank_3.png', width: 28,), top: -19,),
                          Container(
                            width: 80,
                            height: 80,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                border: Border.all(width: 3, color: const Color(0xFFCDA659))
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: CachedNetworkImage(
                                imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F30%2F20180730163717_gbqnc.thumb.700_0.jpg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639325025&t=f8fc41fac91d230208aba57888274cb4',
                                placeholder: (BuildContext context, String url,) {
                                  return Container(color: Colors.grey.shade300,);
                                },
                                fit: BoxFit.fill,
                                errorWidget: (BuildContext context, String url, dynamic error,) {
                                  return Container(color: Colors.grey.shade300,);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18,),
                      Text('Cec', style: TextStyle(fontSize: 18, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                      const SizedBox(height: 8,),
                      Text('Product Manager', style: TextStyle(fontSize: 13, color: Colors.black87.withAlpha(180), fontWeight: FontWeight.w400),),
                      const SizedBox(height: 14,),
                      Text('5,000', style: TextStyle(fontSize: 24, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                const SizedBox(width: 4,),
              ],
            ),
            const SizedBox(height: 30,),
            Container(
              padding: const EdgeInsets.all(8).copyWith(right: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: CachedNetworkImage(
                          width: 80,
                          height: 80,
                          imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F30%2F20180730163717_gbqnc.thumb.700_0.jpg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639325025&t=f8fc41fac91d230208aba57888274cb4',
                          placeholder: (BuildContext context, String url,) {
                            return Container(color: Colors.grey.shade300,);
                          },
                          fit: BoxFit.fill,
                          errorWidget: (BuildContext context, String url, dynamic error,) {
                            return Container(color: Colors.grey.shade300,);
                          },
                        ),
                      ),
                      const SizedBox(width: 12,),
                      Column(
                        children: [
                          Text('Cecelia Tay', style: TextStyle(fontSize: 22, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                          const SizedBox(height: 8,),
                          Text('Product Manager', style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(180), fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ],
                  ),
                  Text('4,000', style: TextStyle(fontSize: 24, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(8).copyWith(right: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: CachedNetworkImage(
                          width: 80,
                          height: 80,
                          imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F30%2F20180730163717_gbqnc.thumb.700_0.jpg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639325025&t=f8fc41fac91d230208aba57888274cb4',
                          placeholder: (BuildContext context, String url,) {
                            return Container(color: Colors.grey.shade300,);
                          },
                          fit: BoxFit.fill,
                          errorWidget: (BuildContext context, String url, dynamic error,) {
                            return Container(color: Colors.grey.shade300,);
                          },
                        ),
                      ),
                      const SizedBox(width: 12,),
                      Column(
                        children: [
                          Text('Cecelia Tay', style: TextStyle(fontSize: 22, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                          const SizedBox(height: 8,),
                          Text('Product Manager', style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(180), fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ],
                  ),
                  Text('4,000', style: TextStyle(fontSize: 24, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(8).copyWith(right: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: CachedNetworkImage(
                          width: 80,
                          height: 80,
                          imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F30%2F20180730163717_gbqnc.thumb.700_0.jpg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639325025&t=f8fc41fac91d230208aba57888274cb4',
                          placeholder: (BuildContext context, String url,) {
                            return Container(color: Colors.grey.shade300,);
                          },
                          fit: BoxFit.fill,
                          errorWidget: (BuildContext context, String url, dynamic error,) {
                            return Container(color: Colors.grey.shade300,);
                          },
                        ),
                      ),
                      const SizedBox(width: 12,),
                      Column(
                        children: [
                          Text('Cecelia Tay', style: TextStyle(fontSize: 22, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                          const SizedBox(height: 8,),
                          Text('Product Manager', style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(180), fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ],
                  ),
                  Text('4,000', style: TextStyle(fontSize: 24, color: Color(0xFF013B7B), fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _itemPage(ValueKey key) {
      return ScrollConfiguration(
        behavior: CusBehavior(),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20,),
          child: _page(key),
        ),
      );
    }

    Widget _scroll() {
      return IndexedStack(
        index: _currentPage,
        children: pageTabs.map((e) {
          return _itemPage(e.key as ValueKey);
        }).toList(),
      );
    }

     PageContainer(
      title: widget.about.label.replaceAll('\n', ' '),
      pageBg: const Color(0xFFEBEEF3),
      titleBarBgColor: Colors.white,
      body: _scroll(),
      bodyTop: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
        ),
        width: MediaQuery.of(context).size.width,
        height: 52,
        child: TabBar(
          controller: _controller,
          tabs: pageTabs,
          unselectedLabelColor: Colors.black26,
          labelColor: const Color(0xFF013B7B),
          labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: const BoxDecoration(
            color: Color(0xFF013B7B),
          ),
          indicatorPadding: const EdgeInsets.only(left: 10, right: 10, top: 46, bottom: 0),
          onTap: (int tabIndex) {
          },
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.about.label.replaceAll("\n"," " )),
      ),
      body: stateNoDate(),
    );
  }
}
