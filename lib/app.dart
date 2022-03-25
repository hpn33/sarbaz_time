import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sarbaz_time/app_theme.dart';
import 'package:sarbaz_time/config.dart';
import 'package:sarbaz_time/page/homePage.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final appTheme = ref.watch(appThemeProvider);

    return FluentApp(
      title: appTitle,
      themeMode: appTheme.mode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (_) => const HomePage()},
      color: appTheme.color,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: appTheme.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      theme: ThemeData(
        accentColor: appTheme.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: appTheme.textDirection,
          child: NavigationPaneTheme(
            data: const NavigationPaneThemeData(
                // backgroundColor:
                //     appTheme.windowEffect != flutter_acrylic.WindowEffect.disabled
                //         ? Colors.transparent
                //         : null,
                ),
            child: child!,
          ),
        );
      },
    );
  }
}
