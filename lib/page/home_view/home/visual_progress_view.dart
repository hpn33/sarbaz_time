import 'package:fluent_ui/fluent_ui.dart';

class VisualProgressView extends StatelessWidget {
  const VisualProgressView({
    Key? key,
    required this.extraDays,
    required this.minesDays,
    required this.totalDaysNormal,
    required this.passedDay,
    required this.remainingDayNormal,
  }) : super(key: key);

  final int totalDaysNormal;
  final int extraDays;
  final int minesDays;
  final int passedDay;
  final int remainingDayNormal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          // pure date
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[40],
              borderRadius: BorderRadius.circular(10),
            ),
            height: 10,
            child: Row(
              children: [
                // total day
                Expanded(
                  flex: totalDaysNormal,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.purple['lightest'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        (totalDaysNormal).toString(),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                ),

                if (extraDays > minesDays)
                  Expanded(
                    flex: extraDays - minesDays,
                    child: Center(
                      child: Text(
                        (extraDays - minesDays).toString(),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 2),
          // mines
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[40],
              borderRadius: BorderRadius.circular(10),
            ),
            height: 10,
            child: Row(
              children: [
                // total - mines
                Expanded(
                  flex: totalDaysNormal - minesDays,
                  child: Container(),
                ),

                // mines
                Expanded(
                  flex: minesDays,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green['lighter'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // extra
                if (extraDays > minesDays)
                  Expanded(
                    flex: extraDays - minesDays,
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

          const SizedBox(height: 2),
          // prosess bar to show days
          Container(
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
                      color: Colors.blue['lighter'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 10,
                    child: Center(
                      child: Text(
                        (passedDay).toString(),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                ),

                // remainded
                Expanded(
                  flex: remainingDayNormal - minesDays,
                  child: Center(
                    child: Text(
                      (remainingDayNormal - minesDays).toString(),
                      style: const TextStyle(fontSize: 8),
                    ),
                  ),
                ),

                // extra
                if (extraDays > 0)
                  Expanded(
                    flex: extraDays,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[90],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          (extraDays).toString(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ),
                  ),

                // mines
                if (extraDays < minesDays)
                  Expanded(
                    flex: minesDays - extraDays,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[40],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          (minesDays - extraDays).toString(),
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 2),
          // extra
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[40],
              borderRadius: BorderRadius.circular(10),
            ),
            height: 10,
            child: Row(
              children: [
                // total day
                Expanded(
                  flex: totalDaysNormal - minesDays,
                  child: Container(),
                ),

                Expanded(
                  flex: extraDays,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red['lighter'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // mines
                if (minesDays > extraDays)
                  Expanded(
                    flex: minesDays - extraDays,
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
        ],
      ),
    );
  }
}
