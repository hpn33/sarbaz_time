import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TotalDayMonth extends HookWidget {
  const TotalDayMonth(this.totalDays, {Key? key, this.title = "TotalDayMonth"})
      : super(key: key);

  final ValueNotifier<int> totalDays;
  final String title;

  @override
  Widget build(BuildContext context) {
    final totalDayController =
        useTextEditingController(text: totalDays.value.toString());

    final daysController = useTextEditingController(
        text: (totalDays.value % 30).toInt().toString());
    final monthsController =
        useTextEditingController(text: (totalDays.value ~/ 30).toString());

    return Expanded(
      child: Column(
        children: [
          Text(title),
          TextBox(
            controller: totalDayController,
            onChanged: (value) {
              totalDays.value = int.parse(value);

              daysController.text = (totalDays.value % 30).toString();
              monthsController.text = (totalDays.value ~/ 30).toString();
            },
          ),
          Row(
            children: [
              const Text('ماه'),
              Expanded(
                child: TextBox(
                  controller: monthsController,
                  onChanged: (value) {
                    totalDays.value =
                        int.parse(value) * 30 + int.parse(daysController.text);

                    totalDayController.text = totalDays.value.toString();
                  },
                ),
              ),
              const Text('روز'),
              Expanded(
                child: TextBox(
                  controller: daysController,
                  onChanged: (value) {
                    totalDays.value = int.parse(value) +
                        int.parse(monthsController.text) * 30;

                    totalDayController.text = totalDays.value.toString();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
