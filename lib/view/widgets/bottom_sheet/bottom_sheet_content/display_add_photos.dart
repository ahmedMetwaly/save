import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/controller/my_provider.dart';
import '../../components/gallary_view.dart';

class DisplayAddPhotos extends StatelessWidget {
  const DisplayAddPhotos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final watch = context.watch<MyProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Consumer<MyProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<String> images = value.files
                        .toString()
                        .replaceAll("File: ", "")
                        .replaceFirst("[", "")
                        .replaceFirst("]", "")
                        .trim()
                        .split(",")
                        .toList();
                    //  print("images" + images.toString());
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              value.files[index].toString().substring(
                                  value.files[index]
                                          .toString()
                                          .lastIndexOf("/") +
                                      1,
                                  value.files[index].toString().length - 1),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GallaryView(
                                    inBottomSheet: true,
                                    galleryItems: images,
                                    backgroundDecoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.file(
                                value.files[index]!,
                                fit: BoxFit.cover,
                                width: 50.w,
                                height: 50.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          IconButton(
                            onPressed: () => value.removeImage(index),
                            icon: Icon(
                              Icons.disabled_by_default_rounded,
                              color: Theme.of(context).indicatorColor,
                              size: 30.sp,
                            ),
                          )
                        ]);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                  itemCount: value.files.length),
              SizedBox(
                height: 15.h,
              ),
              ElevatedButton(
                onPressed: () => value.selectImages(),
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.w),
                    child: Text(
                      "Select Images",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
