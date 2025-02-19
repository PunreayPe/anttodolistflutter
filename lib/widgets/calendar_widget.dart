import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update _focusedDay here as well
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.black,
                // fontFamily: MyFonts.spaceGroteskBold,
              ),
              selectedDecoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                // fontFamily: MyFonts.spaceGroteskBold,
              ),
              weekendTextStyle: TextStyle(
                color: Colors.redAccent,
                // fontFamily: MyFonts.spaceGroteskBold,
              ),
              defaultTextStyle: TextStyle(
                color: Colors.white,
                // fontFamily: MyFonts.spaceGroteskBold,
              ),
              outsideTextStyle: TextStyle(
                color: Colors.white,
                // fontFamily: MyFonts.spaceGroteskBold,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonTextStyle: TextStyle(
                  // fontFamily: MyFonts.spaceGroteskBold,
                  ),
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                // fontFamily: MyFonts.spaceGroteskBold,
              ),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(
                color: Colors.redAccent,
                // fontFamily: MyFonts.spaceGroteskBold,
              ),
              weekdayStyle: TextStyle(
                color: Colors.white,
                // fontFamily: MyFonts.spaceGroteskRegular,
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     '${_focusedDay.year} - ${_focusedDay.month} - ${_focusedDay.day}',
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 20,
        // fontFamily: MyFonts.spaceGroteskBold,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                "ការងារសម្រាប់ថ្ងៃ : ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  // fontFamily: MyFonts.spaceGroteskBold,
                ),
              ),
              Text(
                DateFormat('dd MMMM, yyyy')
                    .format(_focusedDay), // Format the date here
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  // fontFamily: MyFonts.spaceGroteskBold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
