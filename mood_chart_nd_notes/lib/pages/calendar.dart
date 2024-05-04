import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime today = DateTime.now();
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _colorDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  CalendarFormat format = CalendarFormat.month;
  late String eventsShowingText;
  final Map<DateTime, List<dynamic>> _events = {
    DateTime.utc(2024, 04, 29): [
      "I want to go home , why do you do this to me"
          "event2"
    ],
    DateTime.utc(2024, 04, 21): ["event12"],
    DateTime.utc(2024, 04, 20): ["event12", "event12", "event12"],
  };
  final Map<DateTime, Color> _holidays = {
    DateTime.utc(2024, 04, 10): Colors.green,
    DateTime.utc(2024, 04, 15): Colors.lightGreen,
    DateTime.utc(2024, 04, 18): Colors.yellow,
    DateTime.utc(2024, 04, 20): Colors.red,
    DateTime.utc(2024, 04, 21): Colors.black,
  };

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();

    eventsShowingText =
        _events[today] != null ? "${_events[today]}" : "No events selected";
  }

  @override
  Widget build(BuildContext context) {
    final Map<Color, String> items = {
      Colors.green: "Perfect",
      Colors.lightGreen: "Very good",
      Colors.yellow: "Good",
      Colors.orange: "Normal",
      Colors.red: "Bad",
      Colors.black: "Terrible"
    };

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final isHoliday = _holidays.containsKey(date);
                  if (isHoliday) {
                    return Positioned(
                      bottom: 2,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: _holidays[date],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2050, 3, 14),
              focusedDay: today,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _colorDay = selectedDay;
                  eventsShowingText = _events[selectedDay] != null
                      ? "${_events[selectedDay]}"
                      : "No events selected";
                });
                print(_events[selectedDay]);
              },
              holidayPredicate: (day) {
                return _holidays.containsKey(day);
              },
              eventLoader: (day) => _events[day] ?? [],
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              calendarStyle: const CalendarStyle(
                  // holidayTextStyle: TextStyle(color: Colors.white),

                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 206, 206, 206),
                  border: Border.all(
                    width: 1.0,
                  )),
              child: Text(eventsShowingText),
            ),
            FloatingActionButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("How was your day So ?"),
                      content: SizedBox(
                        width: double.minPositive,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: items.keys.elementAt(index),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(19))),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(items.values.elementAt(index)),
                                ],
                              ),
                              onTap: () {
                                print(items.values.elementAt(index));
                                print(_colorDay);
                                setState(() {
                                  _holidays.addAll(
                                      {_colorDay: items.keys.elementAt(index)});
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
