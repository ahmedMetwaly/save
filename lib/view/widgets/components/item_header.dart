import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save/core/theme/app_colors.dart';

/// A reusable gradient header widget for item cards
/// Used in both DisplayItemWithPhotos and DisplayItemWithOutPhoto
class ItemHeader extends StatelessWidget {
  const ItemHeader({
    super.key,
    required this.title,
    required this.onEdit,
    this.onDelete,
    this.showActions = true,
    this.showDelete = true,
  });

  final String title;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;
  final bool showActions;
  final bool showDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          // Title
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Action Buttons
          if (showActions) ...[
            _buildHeaderButton(
              icon: Icons.edit_rounded,
              onTap: onEdit,
            ),
            if (showDelete && onDelete != null) ...[
              SizedBox(width: 8.w),
              _buildHeaderButton(
                icon: Icons.delete_rounded,
                onTap: onDelete!,
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
