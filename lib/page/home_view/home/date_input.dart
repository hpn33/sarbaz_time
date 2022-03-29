import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateInput extends HookWidget {
  const DateInput(
    this.title,
    this.date, {
    Key? key,
  }) : super(key: key);

  final String title;
  final ValueNotifier<Jalali> date;

  @override
  Widget build(BuildContext context) {
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
        SizedBox(
          width: 250,
          child: Row(
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
        ),
      ],
    );
  }
}
