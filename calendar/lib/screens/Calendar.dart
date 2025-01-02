import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/Event.dart';
import '../services/DatabaseHelper.dart';
import 'EventDetails.dart';

class CalendarScreen extends StatefulWidget
{
    @override
    _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
{
    final DatabaseHelper _dbHelper = DatabaseHelper();
    List<Event> events = [];
    DateTime _focusedDay = DateTime.now();

    @override
    void initState()
    {
        super.initState();
        _loadEvents();
    }

    void _loadEvents() async
    {
        final events = await _dbHelper.getAllEvents();
        setState(()
            {
                this.events = events;
            }
        );
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text("Calendar App")
            ),
            body: Column(
                children: [
                    TableCalendar(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: CalendarFormat.month,
                        eventLoader: (day)
                        {
                            return events.where((event)
                                {
                                    final eventDate = DateTime(event.date.year, event.date.month, event.date.day);
                                    return eventDate == DateTime(day.year, day.month, day.day);
                                }
                            ).toList();
                        },
                        calendarBuilders: CalendarBuilders(
                            singleMarkerBuilder: (context, date, event)
                            {
                                final color = date.isBefore(DateTime.now()) ? Colors.grey : Colors.red;
                                return Container(
                                    margin: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: color
                                    ),
                                    width: 5.0,
                                    height: 5.0
                                );
                            }
                        ),
                        onDaySelected: (selectedDay, focusedDay)
                        {
                            final date = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                            final eventsForSelectedDay = events.where((e) => DateTime(e.date.year, e.date.month, e.date.day) == date).toList();
                            final event = Event(date: date, time: '', location: '', note: '');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EventDetailScreen(
                                        date: date,
                                        event: eventsForSelectedDay.isEmpty ? event : eventsForSelectedDay.first
                                    )
                                )
                            ).then((_) => _loadEvents()); // Reload events after returning.
                        }
                    )
                ]
            )
        );
    }
}
