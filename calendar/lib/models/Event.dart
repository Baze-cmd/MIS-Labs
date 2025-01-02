class Event
{
    int? id;
    DateTime date;
    String time;
    String location;
    String note;

    Event({
        this.id,
        required this.date,
        required this.time,
        required this.location,
        this.note = ''
    });

    Map<String, dynamic> toMap()
    {
        return
        {
            'id': id,
            'date': date.toIso8601String(),
            'time': time,
            'location': location,
            'note': note
        };
    }

    static Event fromMap(Map<String, dynamic> map)
    {
        return Event(
            id: map['id'],
            date: DateTime.parse(map['date']),
            time: map['time'],
            location: map['location'],
            note: map['note']
        );
    }
}
