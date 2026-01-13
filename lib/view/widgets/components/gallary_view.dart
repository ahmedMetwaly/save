import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:save/view/widgets/components/show_alert_dialog.dart';
import '../../../model/database.dart';

class GallaryView extends StatefulWidget {
  GallaryView({
    super.key,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.inBottomSheet = false,
    this.initialIndex = 0,
    required this.galleryItems,
    this.title,
    this.categoryName,
  }) : pageController = PageController(initialPage: initialIndex);

  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final bool inBottomSheet;
  final int initialIndex;
  final String? title;
  final String? categoryName;
  final PageController pageController;
  final List<String> galleryItems;
  @override
  State<StatefulWidget> createState() {
    return _GallaryViewState();
  }
}

class _GallaryViewState extends State<GallaryView> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  updateInFav(BuildContext context, String deletedImage) {
    final value = Provider.of<MySql>(context, listen: false);
    String spContent = value
        .selectSpecificContent(
          categoryName: widget.categoryName ?? "",
          title: widget.title ?? "",
        )
        .trim();
    int endIndex = spContent.indexOf("]");
    String oldContent = "${spContent.substring(0, endIndex)}]";
    List images = value.fetchImages(oldContent);
    images.removeWhere((element) => element.toString().trim() == deletedImage);
    List updatedImages =
        images.map((image) => "File: ${image.toString().trim()}").toList();
    String updatedContent = "${widget.title},$updatedImages";

    // print("fav: ${value.favList}");
    List favContent =
        value.favList.map((favItem) => favItem["content"]).toList();
    if (favContent.contains(oldContent)) {
      value.updateFavItem(newContent: updatedContent, oldContent: oldContent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.galleryItems.length,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20.0.w,
                    height: 20.0.h,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
                scrollDirection: Axis.horizontal,
              ),
              Container(
                padding: EdgeInsets.all(20.0.w),
                child: Text(
                  "Image ${currentIndex + 1}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0.sp,
                    decoration: null,
                  ),
                ),
              ),
              widget.inBottomSheet || widget.galleryItems.length == 1
                  ? const SizedBox()
                  : Consumer<MySql>(
                      builder: (context, value, child) => Positioned(
                        top: 15.h,
                        child: IconButton(
                            onPressed: () {
                              //print("delete $currentIndex");
                              showDialog(
                                  context: context,
                                  builder: (context) => ShowAlertDialog(
                                        title: "Delete",
                                        content:
                                            "Do you want to delete this photo ?",
                                        onPressedOk: () {
                                          value
                                              .deletePhoto(context,
                                                  deletedPhoto: widget
                                                      .galleryItems[
                                                          currentIndex]
                                                      .trim(),
                                                  categoryName:
                                                      widget.categoryName ?? "",
                                                  title: widget.title ?? "")
                                              .then((val) {
                                            setState(() {
                                              widget.galleryItems.remove(widget
                                                  .galleryItems[currentIndex]);

                                              if (currentIndex ==
                                                  widget.galleryItems.length) {
                                                currentIndex -= 1;
                                              } else {
                                                currentIndex += 1;
                                              }
                                            });

                                            updateInFav(
                                                context,
                                                widget
                                                    .galleryItems[currentIndex]
                                                    .trim());

                                            Navigator.of(context).pop();
                                          });
                                        },
                                      ));
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              color: Colors.white,
                              size: 30.sp,
                            )),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final item = widget.galleryItems[index].trim().replaceAll("'", "");
    return item.contains(".svg")
        ? PhotoViewGalleryPageOptions.customChild(
            child: SizedBox(
              width: 300.w,
              height: 300.h,
              child: SvgPicture.asset(
                item,
                height: 200.0.h,
              ),
            ),
            childSize: Size(300.w, 300.h),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 4.1,
            heroAttributes: PhotoViewHeroAttributes(tag: index.toString()),
          )
        : PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(item)),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 4.1,
            heroAttributes: PhotoViewHeroAttributes(tag: index.toString()),
          );
  }
}
