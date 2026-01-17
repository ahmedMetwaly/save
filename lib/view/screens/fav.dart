import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/core/theme/app_colors.dart';
import 'package:save/model/database.dart';
import 'package:save/view/widgets/components/empty_widget.dart';
import 'package:save/view/widgets/components/gradient_sliver_app_bar.dart';
import 'package:save/view/widgets/components/my_drawer.dart';
import 'package:save/view/widgets/home_widgets/social_media/display_platform_item.dart';
import 'package:save/view/widgets/home_widgets/with_photos/display_item_with_photos.dart';
import '../widgets/home_widgets/withOut_photos/display_item_with_out_photo.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});
  static const String routeName = "/favScreen";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<MySql>(
      builder: (context, value, child) {
        List<String> platforms = [
          "facebook",
          "instagram",
          "twitter",
          "snapchat",
          "tiktok",
          "youtube",
          "chrome",
          "linkedin"
        ];
        List favContent =
            value.favList.map((favItem) => favItem["content"]).toList();
        List favCategoryName =
            value.favList.map((favItem) => favItem["categoryName"]).toList();

        return Scaffold(
          backgroundColor:
              isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
          drawer: const MyDrawer(),
          body: CustomScrollView(
            slivers: [
              // Gradient App Bar
              const GradientSliverAppBar(
                title: "Favorites",
                showBackButton: true,
              ),

              // Content
              if (favContent.isEmpty)
                SliverFillRemaining(
                  child: EmptyStateWidget(
                    icon: Icons.favorite_border_rounded,
                    title: 'No Favorites Yet',
                    subtitle: 'Items you save will appear here',
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        // Clear Button
                        _buildClearButton(context, value),
                        // SizedBox(height: 20.h),

                        // Favorites List
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: favContent.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            return _buildFavItem(
                              context: context,
                              value: value,
                              platforms: platforms,
                              favContent: favContent,
                              favCategoryName: favCategoryName,
                              index: index,
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildClearButton(BuildContext context, MySql value) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => value.clearFav(context),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.error.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_sweep_rounded,
                color: AppColors.error,
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                "Clear All Favorites",
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavItem({
    required BuildContext context,
    required MySql value,
    required List<String> platforms,
    required List favContent,
    required List favCategoryName,
    required int index,
  }) {
    bool isSocialItem =
        platforms.any((platform) => platform == favCategoryName[index]);

    if (isSocialItem) {
      List item = favContent[index]
          .toString()
          .replaceFirst("[", "")
          .replaceFirst("]", "")
          .split(",");
      Map itemContent = {
        for (var element in item)
          element
                  .toString()
                  .substring(0, element.toString().indexOf(":"))
                  .trim():
              element
                  .toString()
                  .substring(element.toString().indexOf(":") + 1)
                  .trim()
      };
      itemContent["id"] = int.parse(itemContent["id"]);
      return DisplayPlatformItem(
        platformItem: itemContent,
        onSearchScreen: false,
        onFavScreen: true,
      );
    } else {
      if (favContent[index].toString().contains("File")) {
        Map dataWithPhotos =
            value.fetchDataToDisplay(context, favContent[index]);
        return DisplayItemWithPhotos(
          fromSearchScreen: false,
          favScreen: true,
          labelList: dataWithPhotos["labelsList"],
          imagesList: dataWithPhotos["imagesList"],
          valuesList: dataWithPhotos["valuesList"],
          urlsList: dataWithPhotos["urlsList"],
          title: dataWithPhotos["title"],
          categoryName: favCategoryName[index],
        );
      } else {
        favContent[index].toString().replaceFirst("]", ",");

        List<String> itemContent = favContent[index].toString().split(",");
        List<String> labelList = itemContent
            .map((content) => content
                .substring(0, content.indexOf(":"))
                .trim()
                .replaceAll("[", ""))
            .toList();

        List<String> valueList = favContent[index].toString().split(",");
        valueList = valueList
            .map((value) => value
                .substring(value.indexOf(":") + 1)
                .trim()
                .replaceAll("]", ""))
            .toList();

        return DisplayItemWithOutPhoto(
          itemContent: favContent[index],
          onFavScreen: true,
          onSearchScreen: false,
          labelList: labelList,
          valueList: valueList,
          categoryName: favCategoryName[index],
        );
      }
    }
  }
}
