import 'package:flutter/material.dart';
import 'package:save/view/widgets/bottom_sheet/bottom_sheet_content/bottom_sheet_content.dart';

class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      height: MediaQuery.of(context).size.height * 0.515,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
      child: const BottomSheetContent(),
    );
    
  }
}
