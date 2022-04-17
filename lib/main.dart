import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter/foundation.dart';
import 'package:sarbaz_time/config.dart';
// import 'package:system_theme/system_theme.dart';
import 'package:url_strategy/url_strategy.dart';

// import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:window_manager/window_manager.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GetAppDarkModeEnabled();

  // if (kIsWeb ||
  //     [TargetPlatform.windows, TargetPlatform.android]
  //         .contains(defaultTargetPlatform)) {
  //   SystemTheme.accentInstance;
  // }

  setPathUrlStrategy();

  if (isDesktop) {
    // await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden,
          windowButtonVisibility: false);
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(755, 545));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const ProviderScope(child: MyApp()));
}
