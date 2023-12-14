import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save/model/cach_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class GoToLink extends StatelessWidget {
  final String url;

  const GoToLink({super.key, required this.url});

  Future<void> _launchUrl(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0,
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw Exception('Could not launch $url0');
    }
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<CachHelper>();
    return ElevatedButton(
      onPressed: () => _launchUrl(url),
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).primaryColor),
      ),
      child: Container(
          //width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Text(
            "Go to link",
            style: read.isDark == null
                ? Theme.of(context).textTheme.bodyMedium
                : read.isDark == true
                    ? Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).indicatorColor)
                    : Theme.of(context).textTheme.bodyMedium,
          )),
    );
  }
}
