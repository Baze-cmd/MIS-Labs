import 'package:flutter/material.dart';
import '../models/Event.dart';
import '../services/DatabaseHelper.dart';
import '../services/NotificationService.dart';
import 'MapScreen.dart';

class EventDetailScreen extends StatefulWidget
{
    final DateTime date;
    final Event event;

    EventDetailScreen({required this.date, required this.event});

    @override
    _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen>
{
    final _formKey = GlobalKey<FormState>();
    late String _time;
    late String _location;
    late String _note;
    NotificationService notificationService = NotificationService();

    final DatabaseHelper _dbHelper = DatabaseHelper();

    @override
    void initState()
    {
        super.initState();
        _time = widget.event.time;
        _location = widget.event.location;
        _note = widget.event.note;
        initNotifications();
    }

    Future<void> initNotifications() async
    {
        await notificationService.initialize();
    }

    void _saveEvent() async
    {
        final event = Event(
            id: widget.event.id,
            date: widget.date,
            time: _time,
            location: _location,
            note: _note
        );

        if (widget.event.id == null)
        {
            await _dbHelper.insertEvent(event);
        }
        else
        {
            await _dbHelper.updateEvent(event);
        }

        Navigator.pop(context);
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(title: Text("Event Details")),
            body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        children: [
                            TextFormField(
                                initialValue: _time, // Pre-fill with event time
                                decoration: InputDecoration(labelText: "Time"),
                                onSaved: (value) => _time = value!
                            ),
                            TextFormField(
                                initialValue: _location, // Pre-fill with event location
                                decoration: InputDecoration(labelText: "Location"),
                                onSaved: (value) => _location = value!
                            ),
                            TextFormField(
                                initialValue: _note, // Pre-fill with event note
                                decoration: InputDecoration(labelText: "Note"),
                                onSaved: (value) => _note = value!
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: ()
                                {
                                    _formKey.currentState!.save();
                                    _saveEvent();
                                    notificationService.scheduleNotification(widget.date);
                                },
                                child: Text("Save Event")
                            ),
                            ElevatedButton(
                                onPressed: ()
                                {
                                    final regex = RegExp(r'^[+-]?\d{1,2}(\.\d+)?,[ ]?[+-]?\d{1,3}(\.\d+)?$');
                                    if (regex.hasMatch(_location))
                                    {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(location: this._location)
                                            )
                                        );
                                    }
                                    else
                                    {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Invalid location format. Please provide a valid format like \"41.9981,21.4254\"."))
                                        );
                                    }
                                },
                                child: Text("Get route")
                            )
                        ]
                    )
                )
            )
        );
    }
}
