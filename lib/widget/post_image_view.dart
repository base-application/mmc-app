

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/bean/image_vo_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/src/provider.dart';

class PosterView extends StatefulWidget {
  final List<ImageVoEntity> images;
  const PosterView({Key? key, required this.images}) : super(key: key);

  @override
  _PosterViewState createState() => _PosterViewState();
}

class _PosterViewState extends State<PosterView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white24,
        child: const Icon(CupertinoIcons.left_chevron),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child:  Container(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: Image.network(context.read<SystemSetService>().baseUrl + widget.images[index].url,width: MediaQuery.of(context).size.width,fit: BoxFit.fitWidth,).image,
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes: PhotoViewHeroAttributes(tag: index),
                );
              },
              itemCount: widget.images.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded / (event.expectedTotalBytes??0),
                  ),
                ),
              ),
              // backgroundDecoration: widget.backgroundDecoration,
              // pageController: widget.pageController,
              // onPageChanged: onPageChanged,
            )
        ),
      )
    );
  }
}
