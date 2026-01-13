import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save/model/database.dart';
import '../../../../controller/my_provider.dart';

class DropButton extends StatelessWidget {
  const DropButton({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<MyProvider>();
    final make = context.watch<MyProvider>();
    final readSql = context.read<MySql>();
    final makeSql = context.watch<MySql>();
    return Expanded(
      child: DropdownButton(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        dropdownColor: Theme.of(context).indicatorColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
        hint: Text(
          "Select",
          style: TextStyle(
            fontSize: 20.sp,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        value: read.dropDownButtonItem,
        isExpanded: true,
        items: readSql.data.map((category) {
          return DropdownMenuItem(
            value: category["categoryName"],
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0.h),
              child: Text(
                category["categoryName"],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          make.changeDropButtomItem(value);
          makeSql.selectSpecificCategory(categoryName: value.toString());
        },
      ),
    );
  }
}
