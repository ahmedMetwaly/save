import 'package:flutter/material.dart';
import 'package:save/view/widgets/components/link_preview.dart';


class HeadOfItem extends StatelessWidget {
  const HeadOfItem({
    super.key,
    required this.labelList,
    required this.urls,
    required this.valuesList,
  });

  final List<String> labelList;
  final List urls;
  final List<String> valuesList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true, // to prevent unbounded height of the list view widget
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // print("contentSendedToAddPhoto : ${content[index].substring(
        //         0, content[index].lastIndexOf(")") + 1)}");
        return DefaultTextStyle(
          style: Theme.of(context).textTheme.labelMedium??const TextStyle(),
          child: Row(
            children: [
              Text("${labelList[index].trim().toUpperCase()} : "),
              Expanded(
                child: urls.contains(valuesList[index].trim())
                    ? LinkPreviewWidget(urlLink: valuesList[index].trim())
                    : Text(
                        valuesList[index].trim(),
                      ),
              )
            ],
          ),
        );
      },
      itemCount: labelList.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 5,
      ),
    );
  }
}
