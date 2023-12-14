import 'package:flutter/services.dart';

class DataClass {
  static String channel = "app.save";

  ///Get the data from Platform channel
  ///
  Future<String> sharedData() async {
    final String data = await MethodChannel(channel).invokeMethod("getData");
    return data;
  }
}