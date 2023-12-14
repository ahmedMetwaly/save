import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          value: 99,
          semanticsLabel: "Loading",
        ),
        const SizedBox(
          height: 15,
        ),
        const Text("Loading")
      ],
    );
          
        
  }
}
