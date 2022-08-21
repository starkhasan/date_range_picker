import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class DateRangeExample extends StatefulWidget{
  const DateRangeExample({super.key});
  @override
  State createState() => _DateRangeExampleState();
}

class _DateRangeExampleState extends State<DateRangeExample>{

  late CalendarDatePicker2Config config;
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [];

  @override
  void initState() {
    _rangeDatePickerValueWithDefaultValue = getFirstLastDay(dateTime: DateTime.now());
    config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.teal[800],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    super.initState();
  }

  List<DateTime?> getFirstLastDay({required DateTime dateTime}){
    var dateFirst = dateTime;
    var dateSecond = dateTime;
    if(dateTime.weekday == 7){
      dateFirst = dateTime;
      dateSecond = dateTime.add(const Duration(days: DateTime.daysPerWeek - 1));
    }else{
      dateFirst = dateTime.subtract(Duration(days: dateTime.weekday));
      dateSecond = dateTime.add(Duration(days: DateTime.daysPerWeek - (dateTime.weekday + 1)));
    }
    return [dateFirst, dateSecond];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text('Range Date Picker (With default value)'),
            CalendarDatePicker2(
              config: config,
              initialValue: _rangeDatePickerValueWithDefaultValue,
              onValueChanged: (values) {
                var dateTime = getFirstLastDay(dateTime: values[0]!);
                setState(() => _rangeDatePickerValueWithDefaultValue = [
                  dateTime[0],
                  dateTime[1]
                ]);
              }
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Date Range ='),
                const SizedBox(width: 10),
                Text(
                  _getValueText(
                    config.calendarType,
                    _rangeDatePickerValueWithDefaultValue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
  
  String _getValueText(CalendarDatePicker2Type datePickerType,List<DateTime?> values) {
    var valueText = '${values[0].toString().substring(0,10)} to ${values[1].toString().substring(0,10)}';
    return valueText;
  }
}