import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
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
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                value.files[index]!,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            onPressed: () => value.removeImage(index),
                            icon: Icon(
                              Icons.disabled_by_default_rounded,
                              color: Theme.of(context).indicatorColor,
                              size: 30,
                            ),
                          )
                        ]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: value.files.length),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () => value.selectImages(),
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
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
