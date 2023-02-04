import 'package:appcenter_bundle/appcenter_bundle.dart';
import 'package:flutter/foundation.dart';

class AppcenterConfig {
  static const String appSecretAndroid = '8d4aba95-b53e-4821-8cd2-d7cd19fd44e1';
  static const String appSecretIOS = '479d0fdf-d3d7-428e-bd32-775ac5c558ca';

  void initAppCenter(TargetPlatform platform) async {

    // // (tk) TODO add package specific info
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    //
    // var appSecret = "";
    // switch (platform) {
    //   case TargetPlatform.iOS:
    //     appSecret = AppcenterConfig.appSecretIOS;
    //     break;
    //   case TargetPlatform.android:
    //     appSecret = AppcenterConfig.appSecretAndroid;
    //     break;
    // }
    //
    // if (appSecret.isNotEmpty) {
    //   await AppCenter.start(appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);
    // }

    await AppCenter.startAsync(
        appSecretAndroid: AppcenterConfig.appSecretAndroid,
        appSecretIOS: AppcenterConfig.appSecretIOS,
        enableDistribute: true
        // enableAnalytics: false, // Defaults to true
        // enableCrashes: false, // Defaults to true
        // enableDistribute: true, // Defaults to false
        // usePrivateDistributeTrack: false, // Defaults to false
        // disableAutomaticCheckForUpdate: false, // Defaults to false
        );

    await AppCenter.configureDistributeDebugAsync(enabled: false);

    // AppCenter.trackEventAsync('my event', <String, String> {
    //   'prop1': 'prop1',
    //   'prop2': 'prop2',
    // });
  }
}
