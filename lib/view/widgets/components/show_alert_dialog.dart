import "package:flutter/material.dart";


class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedOk,
  });

  final String title;
  final String content;
  final Function onPressedOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () => onPressedOk(),
            child: const Text("Ok")),
      ],
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Divider(
            color: Theme.of(context).indicatorColor,
          ),
        ],
      ),
      content: Text(content),
    );
  }
}
