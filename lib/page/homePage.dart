import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sarbaz_time/app_theme.dart';
import 'package:sarbaz_time/config.dart';
import 'package:sarbaz_time/page/home_view/forms.dart';
import 'package:sarbaz_time/page/home_view/home.dart';
import 'package:url_launcher/link.dart';
import 'package:window_manager/window_manager.dart';

import 'home_view/settings.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();

  // @override
  // State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with WindowListener {
  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    final appTheme = ref.watch(appThemeProvider);
    final settingsController = useScrollController();

    useEffect(() {
      windowManager.addListener(this);

      return () {
        windowManager.removeListener(this);
        // settingsController.dispose();
      };
    });

    useEffect(() {
      return () {
        settingsController.dispose();
      };
    }, []);

    return NavigationView(
      appBar: navAppBar(),
      pane: navPane(index, appTheme),
      content: navBody(context, index, settingsController),
    );
  }

  Widget body(BuildContext context) {
    return const Center(child: Text("Home"));
  }

  NavigationBody navBody(BuildContext context, ValueNotifier<int> index,
      ScrollController? settingsController) {
    return NavigationBody(
      index: index.value,
      children: [
        // body(context),
        const Home(),
        const Forms(),
        // Center(child: Text("InputsPage")),
        // Center(child: Text("Forms")),
        // Center(child: Text("ColorsPage")),
        // Center(child: Text("IconsPage")),
        // Center(child: Text("TypographyPage")),
        // Center(child: Text("Mobile")),
        // Center(child: Text("CommandBars")),
        // Center(child: Text("Others")),
        // Center(child: Text("Setting")),
        // const InputsPage(),
        // const Forms(),
        // const ColorsPage(),
        // const IconsPage(),
        // const TypographyPage(),
        // const Mobile(),
        // const CommandBars(),
        // const Others(),
        Settings(controller: settingsController),
      ],
    );
  }

  NavigationAppBar navAppBar() {
    return NavigationAppBar(
      title: () {
        if (kIsWeb) return const Text(appTitle);
        return const DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(appTitle),
          ),
        );
      }(),
      actions: kIsWeb
          ? null
          : DragToMoveArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Spacer(),
                  WindowButtons(),
                ],
              ),
            ),
    );
  }

  NavigationPane navPane(ValueNotifier<int> index, AppTheme appTheme) {
    return NavigationPane(
      selected: index.value,
      onChanged: (i) => index.value = i,
      size: const NavigationPaneSize(
        openMinWidth: 250,
        openMaxWidth: 320,
      ),
      header: Container(
        height: kOneLineTileHeight,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: const FlutterLogo(
          style: FlutterLogoStyle.horizontal,
          size: 100,
        ),
      ),
      displayMode: appTheme.displayMode,
      indicatorBuilder: () {
        switch (appTheme.indicator) {
          case NavigationIndicators.end:
            return NavigationIndicator.end;
          case NavigationIndicators.sticky:
          default:
            return NavigationIndicator.sticky;
        }
      }(),
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.home),
          title: const Text('Home'),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.text_field),
          title: const Text('Form'),
        ),
        // It doesn't look good when resizing from compact to open
        // PaneItemHeader(header: Text('User Interaction')),
        // PaneItem(
        //   icon: const Icon(FluentIcons.checkbox_composite),
        //   title: const Text('Inputs'),
        // ),
        // PaneItem(
        //   icon: const Icon(FluentIcons.text_field),
        //   title: const Text('Forms'),
        // ),
        // PaneItemSeparator(),
        // PaneItem(
        //   icon: const Icon(FluentIcons.color),
        //   title: const Text('Colors'),
        // ),
        // PaneItem(
        //   icon: const Icon(FluentIcons.icon_sets_flag),
        //   title: const Text('Icons'),
        // ),
        // PaneItem(
        //   icon: const Icon(FluentIcons.plain_text),
        //   title: const Text('Typography'),
        // ),
        // PaneItem(
        //   icon: const Icon(FluentIcons.cell_phone),
        //   title: const Text('Mobile'),
        // ),
        // PaneItem(
        //   icon: const Icon(FluentIcons.toolbox),
        //   title: const Text('Command bars'),
        // ),
        // PaneItem(
        //   icon: Icon(
        //     appTheme.displayMode == PaneDisplayMode.top
        //         ? FluentIcons.more
        //         : FluentIcons.more_vertical,
        //   ),
        //   title: const Text('Others'),
        //   infoBadge: const InfoBadge(
        //     source: Text('9'),
        //   ),
        // ),
      ],
      // autoSuggestBox: AutoSuggestBox(
      //   controller: TextEditingController(),
      //   items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
      // ),
      // autoSuggestBoxReplacement: const Icon(FluentIcons.search),
      footerItems: [
        PaneItemSeparator(),
        PaneItem(
          icon: const Icon(FluentIcons.settings),
          title: const Text('Settings'),
        ),
        // _LinkPaneItemAction(
        //   icon: const Icon(FluentIcons.open_source),
        //   title: const Text('Source code'),
        //   link: 'https://github.com/bdlukaa/fluent_ui',
        // ),
      ],
    );
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (!_isPreventClose) {
      return null;
    }

    showDialog(
      context: context,
      builder: (_) {
        return ContentDialog(
          title: const Text('Confirm close'),
          content: const Text('Are you sure you want to close this window?'),
          actions: [
            FilledButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
                windowManager.destroy();
              },
            ),
            Button(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required Widget icon,
    required this.link,
    title,
    infoBadge,
    focusNode,
    autofocus = false,
  }) : super(
          icon: icon,
          title: title,
          infoBadge: infoBadge,
          focusNode: focusNode,
          autofocus: autofocus,
        );

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
  }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        autofocus: autofocus,
      ),
    );
  }
}
