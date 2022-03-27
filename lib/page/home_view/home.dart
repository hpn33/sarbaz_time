import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shamsi_date/shamsi_date.dart';

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startDate = useState(
        Jalali.now().copy(hour: 0, minute: 0, second: 0, millisecond: 0));
    final todayDate = useState(
        Jalali.now().copy(hour: 0, minute: 0, second: 0, millisecond: 0));
    final totalMonth = useState(21);

    final totalMonthController =
        useTextEditingController(text: totalMonth.value.toString());

    final finalDate = startDate.value.copy().addMonths(totalMonth.value);
    final remainingDay = finalDate.distanceFrom(todayDate.value);

    final passedDay = todayDate.value.distanceFrom(startDate.value);

    final passedDayPercent = todayDate.value.distanceFrom(startDate.value) /
        startDate.value
            .copy()
            .addMonths(totalMonth.value)
            .distanceFrom(startDate.value) *
        100;

    final remaindedDayPercent = 100 - passedDayPercent;
    //${remainingDay / startDate.value.copy().addMonths(totalMonth.value).distanceFrom(startDate.value) * 100

    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Home')),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: dateInput(context, 'Start', startDate)),
            Expanded(child: Row(children: [])),
          ],
        ),
        dateInput(context, "Today", todayDate),

        const Text("Total Month"),
        TextBox(
          controller: totalMonthController,
          onChanged: (value) {
            totalMonth.value = int.parse(value);
          },
        ),

        // total days
        Text(
            'Total days: ${startDate.value.copy().addMonths(totalMonth.value).distanceFrom(startDate.value)}'),

        // pass days and percent of days
        Text('Pass days: $passedDay ($passedDayPercent%)'),

        // remaining days and percent of days
        Text('Remain days: $remainingDay ($remaindedDayPercent%)'),

        // prosess bar to show days
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[60],
              borderRadius: BorderRadius.circular(10),
            ),
            height: 10,
            width: 100,
            child: Row(
              children: [
                // passed
                Expanded(
                  flex: (passedDayPercent * 100).toInt(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[90],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 10,
                  ),
                ),

                // remainded
                Expanded(
                  flex: (remaindedDayPercent * 100).toInt(),
                  child: Container(
                      // height: 10,
                      // color: Colors.yellow,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// widget for get date input
  Widget dateInput(
      BuildContext context, String title, ValueNotifier<Jalali> date) {
    final _yearController =
        useTextEditingController(text: date.value.year.toString());
    final _monthController =
        useTextEditingController(text: date.value.month.toString());
    final _dayController =
        useTextEditingController(text: date.value.day.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title),
            // const SizedBox(width: 10),
            // Text(date.value.toString()),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormBox(
                // header: 'Year',
                placeholder: '1400',
                inputFormatters: [
                  // just number formater
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _yearController,
                onChanged: (string) {
                  final d = date.value;
                  date.value = Jalali(int.parse(string), d.month, d.day);
                },
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: TextFormBox(
                // header: 'Month',
                placeholder: '10',
                inputFormatters: [
                  // just number formater
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _monthController,
                onChanged: (string) {
                  final d = date.value;
                  date.value = Jalali(d.year, int.parse(string), d.day);
                },
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: TextFormBox(
                // header: 'Day',
                placeholder: '05',
                inputFormatters: [
                  // just number formater
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: _dayController,
                onChanged: (string) {
                  final d = date.value;
                  date.value = Jalali(d.year, d.month, int.parse(string));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
