import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  DateTime today = DateTime.now();
  Map<DateTime, List<Event>> events = {
    DateTime(2023, 11, 1): [Event('Event 1'), Event("Event2")],
    DateTime(2023, 11, 25): [Event('Event 2')],
  };
  late final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier(_getEvents(today));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar with Emojis'),
        ),
        body: Column(
          children: [
            TableCalendar(
              focusedDay: today,
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.now(),
              daysOfWeekHeight: 30,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                ),
                headerPadding: EdgeInsets.symmetric(vertical: 4.0),
              ),
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  switch (day.weekday) {
                    case 1:
                      return const Center(
                        child: Text('월'),
                      );
                    case 2:
                      return const Center(
                        child: Text('화'),
                      );
                    case 3:
                      return const Center(
                        child: Text('수'),
                      );
                    case 4:
                      return const Center(
                        child: Text('목'),
                      );
                    case 5:
                      return const Center(
                        child: Text('금'),
                      );
                    case 6:
                      return const Center(
                        child: Text('토'),
                      );
                    case 7:
                      return const Center(
                        child: Text(
                          '일',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                  }
                },
              ),
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (day) => isSameDay(day, today),

              eventLoader: _getEvents,
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text('${value[index]}'));
                      },
                    );
              }),
            ),
          ],
        ),
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _selectedEvents.value = _getEvents(today);
      events.addAll({today: [Event('1')]});
    });
  }

  List<Event> _getEvents(DateTime today) {
    return events[today] ?? [];
  }
}

class Event {
  Event(this.title);
  final String title;
}