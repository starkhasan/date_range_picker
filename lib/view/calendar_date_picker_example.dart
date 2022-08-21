import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class CalendarPickerFullExample extends StatefulWidget {
  const CalendarPickerFullExample({Key? key}) : super(key: key);

  @override
  State<CalendarPickerFullExample> createState() => _CalendarPickerFullExampleState();
}

class _CalendarPickerFullExampleState extends State<CalendarPickerFullExample> {
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(2021, 8, 10),
    DateTime(2021, 8, 13),
  ];
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [];

  DateTime? firstDay;
  DateTime? lastDay;
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [];

  List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 5)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Date Picker Example'),
      ),
      body: Center(
        child: SizedBox(
          width: 375,
          child: ListView(
            children: <Widget>[
              _buildCalendarDialogButton(),
              _buildDefaultSingleDatePickerWithValue(),
              _buildDefaultMultiDatePickerWithValue(),
              _buildDefaultRangeDatePickerWithValue(),
              _buildCalendarWithActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        var startDate = values[0].toString().replaceAll('00:00:00.000', '');
        var endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  _buildCalendarDialogButton() {
    var config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.purple[800],
      shouldCloseDialogAfterCancelTapped: true,
    );
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              var values = await showCalendarDatePicker2Dialog(
                context: context,
                config: config,
                dialogSize: const Size(325, 400),
                borderRadius: 15,
                initialValue: _dialogCalendarPickerValue,
                dialogBackgroundColor: Colors.white,
                selectableDayPredicate: (day) => !day
                    .difference(_dialogCalendarPickerValue[0]!
                        .subtract(const Duration(days: 5)))
                    .isNegative,
              );
              if (values != null) {
                // ignore: avoid_print
                print(_getValueText(
                  config.calendarType,
                  values,
                ));
                setState(() {
                  _dialogCalendarPickerValue = values;
                });
              }
            },
            child: const Text('Open Calendar Dialog'),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    var config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Colors.amber[900],
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Single Date Picker (With default value)'),
        CalendarDatePicker2(
          config: config,
          initialValue: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (values) =>
              setState(() => _singleDatePickerValueWithDefaultValue = values),
          selectableDayPredicate: (day) => !day
              .difference(DateTime.now().subtract(const Duration(days: 3)))
              .isNegative,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selection(s):  '),
            const SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _singleDatePickerValueWithDefaultValue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildDefaultMultiDatePickerWithValue() {
    var config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Colors.indigo,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Multi Date Picker (With default value)'),
        CalendarDatePicker2(
          config: config,
          initialValue: _multiDatePickerValueWithDefaultValue,
          onValueChanged: (values) =>
              setState(() => _multiDatePickerValueWithDefaultValue = values),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            const Text('Selection(s):  '),
            const SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _multiDatePickerValueWithDefaultValue,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  ///Modify this
  Widget _buildDefaultRangeDatePickerWithValue() {
    var config = CalendarDatePicker2Config(
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Range Date Picker (With default value)'),
        CalendarDatePicker2(
          config: config,
          initialValue: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (values) {
            //write your login to find week days here
            var dateTime = values[0]!;
            if(dateTime.weekday == 7){
              firstDay = dateTime;
              lastDay = dateTime.add(const Duration(days: DateTime.daysPerWeek - 1));
            }else{
              firstDay = dateTime.subtract(Duration(days: dateTime.weekday));
              lastDay = dateTime.add(Duration(days: DateTime.daysPerWeek - (dateTime.weekday + 1)));
            }
            setState(() => _rangeDatePickerValueWithDefaultValue = [
              firstDay,
              lastDay
            ]);
          }
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Date Range = '),
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
    );
  }

  Widget _buildCalendarWithActionButtons() {
    var config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Date Picker With Action Buttons'),
        CalendarDatePicker2WithActionButtons(
          config: config,
          initialValue: _rangeDatePickerWithActionButtonsWithValue,
          onValueChanged: (values) => {
            print(values),
            setState(() {_rangeDatePickerWithActionButtonsWithValue = values;}),
          }
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selection(s):  '),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                _getValueText(
                  config.calendarType,
                  _rangeDatePickerWithActionButtonsWithValue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}