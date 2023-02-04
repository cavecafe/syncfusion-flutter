import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'config/appcenter_config.dart';
import 'model/model.dart';
import 'sample_browser.dart';

Future<void> main() async {

  final appcenter = AppcenterConfig();
  appcenter.initAppCenter(defaultTargetPlatform);

  WidgetsFlutterBinding.ensureInitialized();
  await updateControlItems();
  runApp(const SampleBrowser());
}
