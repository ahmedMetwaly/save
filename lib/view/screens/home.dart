import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/model/cash_helper.dart';
import 'package:save/model/database.dart';
import 'package:save/view/screens/add_category.dart';
import 'package:save/view/screens/social_media/display_social_media.dart';
import 'package:save/view/widgets/home_widgets/withOut_photos/category_with_out_photos.dart';
import 'package:save/view/widgets/home_widgets/with_photos/display_item_with_photos.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/components/empty_widget.dart';
import '../widgets/components/loading_data.dart';
import '../widgets/components/my_app_bar.dart';
import '../widgets/home_widgets/add_data_for_first_time.dart';
import '../widgets/components/fab.dart';
import '../widgets/components/my_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Consumer<MySql>(
      builder: (context, value, child) {
        List<dynamic> categoryNames = value.data.map((category) {
          return category["categoryName"];
        }).toList();
        var read = context.read<CashHelper>();
        final isFirstTime = read.isFirstTime == null
            ? true
            : read.isFirstTime == true
                ? true
                : false;
        return isFirstTime
            ? const AddDataForFirstTime()
            : DefaultTabController(
                length: value.data.length,
                child: Scaffold(
                  appBar: myAppBar(context),
                  drawer: const MyDrawer(),
                  floatingActionButton:
                      value.data.isNotEmpty ? const FAB() : const SizedBox(),
                  body: SafeArea(
                    child: Column(children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(DisplaySocialMedia.routeName),
                              child: Container(
                                height: 70.h,
                                padding: EdgeInsets.all(10.w),
                                color: AppColors.primaryStart,
                                child: const Center(
                                  child: Text(
                                    "Social Media",
                                  ),
                                ),
                              ),
                            ),
                            TabBar(
                              isScrollable: true,
                              tabs: categoryNames
                                  .map((categoryName) => GestureDetector(
                                        onLongPress: () => value.delteCategory(
                                            context,
                                            categoryName: categoryName),
                                        child: Tab(
                                          iconMargin: EdgeInsets.zero,
                                          text: categoryName,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(AddCategory.routeName),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: 20.sp,
                                color: AppColors.primaryStart,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Add Category',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryStart,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      value.data.isNotEmpty
                          ? Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0.h,
                                    left: 15.0.w,
                                    right: 15.0.w,
                                    bottom: 60.0.h),
                                child: TabBarView(
                                  children: value.data.map((category) {
                                    String content = category["content"];
                                    List<String> contentList = [];
                                    if (category["withImage"] == "true") {
                                      contentList = content.split("]");
                                    }

                                    return category["withImage"] == "true"
                                        ? content == "Empty" || content == ""
                                            ? EmptyStateWidget(
                                                icon: Icons.inbox_rounded,
                                                title: 'No Items Yet',
                                                subtitle:
                                                    'Tap the + button to add your first item',
                                              )
                                            : ListView.separated(
                                                itemBuilder: (context, index) {
                                                  Map dataToDisplay =
                                                      value.fetchDataToDisplay(
                                                          context,
                                                          contentList[index]);
                                                  return DisplayItemWithPhotos(
                                                      fromSearchScreen: false,
                                                      favScreen: false,
                                                      labelList: dataToDisplay[
                                                          "labelsList"],
                                                      imagesList: dataToDisplay[
                                                          "imagesList"],
                                                      valuesList: dataToDisplay[
                                                          "valuesList"],
                                                      urlsList: dataToDisplay[
                                                          "urlsList"],
                                                      title: dataToDisplay[
                                                          "title"],
                                                      categoryName: category[
                                                          "categoryName"]);
                                                },
                                                itemCount:
                                                    contentList.length - 1,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(height: 10.h),
                                              )
                                        : CategoryWithOutPhotos(
                                            content: content,
                                            categoryName:
                                                category["categoryName"],
                                          );
                                  }).toList(),
                                ),
                              ),
                            )
                          : const Center(child: LoadingData()),
                    ]),
                  ),
                ),
              );
      },
    );
  }
}
