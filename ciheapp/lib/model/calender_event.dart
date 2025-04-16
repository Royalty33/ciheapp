enum EventType {
  assignment,
  exam,
  holiday,
  lecture,
  other
}

class CalendarEvent {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime? endTime;
  final EventType type;
  final String? location;
  final String? courseId;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    this.endTime,
    required this.type,
    this.location,
    this.courseId,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      type: EventType.values.firstWhere(
        (e) => e.toString() == 'EventType.${json['type']}',
        orElse: () => EventType.other,
      ),
      location: json['location'],
      courseId: json['courseId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'type': type.toString().split('.').last,
      'location': location,
      'courseId': courseId,
    };
  }
}

