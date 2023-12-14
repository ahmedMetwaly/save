import "package:flutter/material.dart";

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_upward_rounded,
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Select category you want to add on it, Please!",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 20,
                  overflow: TextOverflow.clip,
                ),
          ),
        ],
      ),
    );
  }
}
