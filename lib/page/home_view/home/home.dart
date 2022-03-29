import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sarbaz_time/page/home_view/home/date_input.dart';
import 'package:sarbaz_time/page/home_view/home/status.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'total_day_month.dart';
import 'visual_progress_view.dart';

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
    final extraDays = useState(0);

    final totalMonthController =
        useTextEditingController(text: totalMonth.value.toString());

    final lastDateNormal = startDate.value.copy().addMonths(totalMonth.value);

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
            Expanded(child: DateInput('Start', startDate)),
            const SizedBox(width: 20),
            Expanded(child: DateInput("Today", todayDate)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            TotalDayMonth(minesDays),
            const SizedBox(width: 20),
            TotalDayMonth(extraDays),
          ],
        ),
        StatusWidget(
          extraDays: extraDays.value,
          minesDays: minesDays.value,
          totalDaysNormal: totalDaysNormal,
          totalDaysWithAll: totalDaysWithAll,
          passedDay: passedDay,
          passedDayPercent: passedDayPercent,
          remainingDayWithAll: remainingDayWithAll,
          remaindedDayPercent: remaindedDayPercent,
        ),
        VisualProgressView(
            extraDays: extraDays.value,
            minesDays: minesDays.value,
            totalDaysNormal: totalDaysNormal,
            passedDay: passedDay,
            remainingDayNormal: remainingDayNormal),
        Text(
            "${lastDateWithAll.formatter.yyyy}/${lastDateWithAll.formatter.mm}/${lastDateWithAll.formatter.dd}"),
      ],
    );
  }
}
