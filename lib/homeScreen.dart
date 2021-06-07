import 'package:flutter/material.dart';
import 'package:cell_calendar/cell_calendar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'components/bottomSheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CalendarEvent> _sampleEvents = [
    CalendarEvent(
        eventName: 'Task submission', eventDate: DateTime.utc(2021, 6, 7)),
  ];

  @override
  Widget build(BuildContext context) {
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Color(0xFF3F51B5)),
        backgroundColor: Color(0xFF3F51B5),
        onPressed: () {},
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF3F51B5),
        title: Text(
          'Calendar',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      body: CellCalendar(
        todayMarkColor: Color(0xFF3F51B5),
        events: _sampleEvents,
        cellCalendarPageController: cellCalendarPageController,
        daysOfTheWeekBuilder: (dayIndex) {
          final labels = ["S", "M", "T", "W", "T", "F", "S"];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[dayIndex],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          final year = datetime!.year.toString();
          final month = datetime.month.monthName;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  "$month  $year",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    cellCalendarPageController.animateToDate(
                      DateTime.now(),
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 100),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
