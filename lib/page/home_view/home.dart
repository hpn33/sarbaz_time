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

    final minesDays = useState(0);
    // extra days -is bad -the colors is red
    final extraDays = useState(0);

    final minesDaysController =
        useTextEditingController(text: minesDays.value.toString());
    final totalMonthController =
        useTextEditingController(text: totalMonth.value.toString());
    final extraDaysController =
        useTextEditingController(text: extraDays.value.toString());

    final lastDateNormal = startDate.value.copy().addMonths(totalMonth.value);

    final lastDateWithMines = lastDateNormal.copy().addDays(-minesDays.value);
    final lastDateWithExtra = lastDateNormal.copy().addDays(extraDays.value);

    final lastDateWithAll = lastDateNormal
        .copy()
        .addDays(-minesDays.value)
        .addDays(extraDays.value);

    final totalDaysNormal = startDate.value.distanceTo(lastDateNormal);
    final totalDaysWithAll = startDate.value.distanceTo(lastDateWithAll);

    final passedDay = todayDate.value.distanceFrom(startDate.value);
    final passedDayPercent =
        todayDate.value.distanceFrom(startDate.value) / totalDaysWithAll * 100;

    final remainingDayNormal = lastDateNormal.distanceFrom(todayDate.value);
    final remainingDayWithAll = lastDateWithAll.distanceFrom(todayDate.value);
    final remaindedDayPercent = 100 - passedDayPercent;

    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Home')),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: dateInput(context, 'Start', startDate)),
            const SizedBox(width: 20),
            Expanded(child: dateInput(context, "Today", todayDate)),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text("Total Month"),
                  TextBox(
                    controller: totalMonthController,
                    onChanged: (value) {
                      totalMonth.value = int.parse(value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  const Text("Mines days"),
                  TextBox(
                    controller: minesDaysController,
                    onChanged: (value) {
                      minesDays.value = int.parse(value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  const Text("Extra days"),
                  TextBox(
                    controller: extraDaysController,
                    onChanged: (value) {
                      extraDays.value = int.parse(value);
                    },
                  ),
                ],
              ),
            )
          ],
        ),

        // total days
        Text(
            'Total days: $totalDaysNormal + ${extraDays.value} - ${minesDays.value} = $totalDaysWithAll'),

        // pass days and percent of days
        Text('Pass days: $passedDay ($passedDayPercent%)'),

        // remaining days and percent of days
        Text('Remain days: $remainingDayWithAll ($remaindedDayPercent%)'),

        // prosess bar to show days
        // Expanded(
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.grey[40],
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     height: 10,
        //     child: Row(
        //       children: [
        //         // total day
        //         Expanded(
        //           flex: totaldays - minesDays.value,
        //           child: Container(
        //               // height: 10,
        //               // color: Colors.yellow,
        //               ),
        //         ),

        //         Expanded(
        //           flex: extraDays.value,
        //           child: Container(
        //             height: 10,
        //             decoration: BoxDecoration(
        //               color: Colors.red['lighter'],
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        // prosess bar to show days
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[60],
              borderRadius: BorderRadius.circular(10),
            ),
            height: 10,
            child: Row(
              children: [
                // passed
                Expanded(
                  flex: passedDay,
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
                  flex: remainingDayNormal - minesDays.value,
                  child: Container(
                      // height: 10,
                      // color: Colors.yellow,
                      ),
                ),

                // mines
                Expanded(
                  flex: minesDays.value,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[40],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

// prosess bar to show mines days
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[40],
              borderRadius: BorderRadius.circular(10),
            ),
            height: 10,
            child: Row(
              children: [
                // total - mines
                Expanded(
                  flex: totalDaysNormal - minesDays.value,
                  child: Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.grey[90],
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      // height: 10,
                      ),
                ),

                // mines
                Expanded(
                  flex: minesDays.value,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green['lighter'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // extra
                // Expanded(
                // flex: extraDays.value,
                // child: Container(
                // height: 10,
                // decoration: BoxDecoration(
                //   color: Colors.green['lighter'],
                //   borderRadius: BorderRadius.circular(10),
                // ),
                // ),
                // ),
              ],
            ),
          ),
        ),

        Text(
            "${lastDateWithAll.formatter.yyyy}/${lastDateWithAll.formatter.mm}/${lastDateWithAll.formatter.dd}"),
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
