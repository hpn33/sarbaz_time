import 'package:fluent_ui/fluent_ui.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    Key? key,
    required this.extraDays,
    required this.minesDays,
    required this.passedDay,
    required this.totalDaysNormal,
    required this.totalDaysWithAll,
    required this.passedDayPercent,
    required this.remainingDayWithAll,
    required this.remaindedDayPercent,
  }) : super(key: key);

  final int totalDaysNormal;
  final int extraDays;
  final int minesDays;
  final int totalDaysWithAll;
  final int passedDay;
  final double passedDayPercent;
  final int remainingDayWithAll;
  final double remaindedDayPercent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // total days
        Text(
            'Total days: $totalDaysNormal + $extraDays - $minesDays = $totalDaysWithAll'),

        // pass days and percent of days
        Text('Pass days: $passedDay ($passedDayPercent%)'),

        // remaining days and percent of days
        Text('Remain days: $remainingDayWithAll ($remaindedDayPercent%)'),
      ],
    );
  }
}
