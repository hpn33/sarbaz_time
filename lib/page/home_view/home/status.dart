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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // total days
        Text(
            'کل روزها: $totalDaysNormal + $extraDays - $minesDays = $totalDaysWithAll'),

        // pass days and percent of days
        Text(
            'روزهای گذشته: $passedDay (${passedDayPercent.toStringAsFixed(2)}%)'),

        // remaining days and percent of days
        Text(
            'روزهای باقی مانده: $remainingDayWithAll (${remaindedDayPercent.toStringAsFixed(2)}%)'),
      ],
    );
  }
}
