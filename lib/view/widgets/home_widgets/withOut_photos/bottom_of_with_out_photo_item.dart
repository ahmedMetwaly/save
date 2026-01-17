import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:save/core/theme/app_colors.dart';

import '../../../../model/database.dart';
import '../../components/button_action.dart';

class BottomOfWithOutPhotosItem extends StatelessWidget {
  const BottomOfWithOutPhotosItem({
    super.key,
    required this.data,
    required this.categoryName,
  });

  final List data;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<MySql>(
      builder: (context, value, child) {
        final isFavorite = value.favList.any((favitem) =>
            favitem["content"].toString().contains(data.toString()));

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Favorite Button
              ButtonAction(
                isDark: isDark,
               icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                 iconColor: isFavorite ? AppColors.error : null,
                label: isFavorite ? "Saved" : "Save",
                onTap: () {
                  if (isFavorite) {
                    value.deleteFromFav(content: data.toString());
                  } else {
                    value.insertToFav(
                      context,
                      content: data.toString(),
                      categoryName: categoryName,
                    );
                  }
                },
              ),
              SizedBox(width: 12.w),
              // Share Button
              ButtonAction(
                isDark: isDark,
                icon: Icons.share_rounded,
                label: "Share",
                onTap: () async {
                  try {
                    await Share.share(
                      data
                          .toString()
                          .substring(1)
                          .replaceFirst("]", "")
                          .replaceFirst(", ", "\n"),
                    );
                  } catch (error) {
                    // Handle error silently
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
