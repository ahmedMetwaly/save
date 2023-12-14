import 'package:flutter/material.dart';
import 'package:save/view/widgets/bottom_sheet/bottom_sheet_head/drop_button.dart';


class BottomSheetHead extends StatelessWidget {
  const BottomSheetHead({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).indicatorColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child:const  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Text("New"),
          SizedBox(width: 15,),
           DropButton(),
           //SaveButton(),
        ],
      ),
    );
  }
}
