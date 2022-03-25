import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _clearController = useTextEditingController();

    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Home')),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormBox(
                header: 'Year',
                placeholder: 'Type your email here :)',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormBox(
                header: 'Month',
                placeholder: 'Type your email here :)',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormBox(
                header: 'Day',
                placeholder: 'Type your email here :)',
              ),
            ),
          ],
        ),
        TextBox(
          maxLines: null,
          controller: _clearController,
          suffixMode: OverlayVisibilityMode.always,
          minHeight: 100,
          suffix: _clearController.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(FluentIcons.chrome_close),
                  onPressed: () {
                    _clearController.clear();
                  },
                ),
          placeholder: 'Text box with clear button',
        ),
      ],
    );
  }
}
