///for api model of dart
class Courses {
  final int id;
  final String name;
  final String? description;
  final String startDate;
  final String endDate;
  final String schedule;

  Courses({
    required this.id,
    required this.name,
    this.description,
    required this.schedule,
    required this.startDate,
    required this.endDate,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      id: json['id'],
      name: json['name']?? '',
      description: json['description']?? '',
      startDate: json['start_date']?? '',
      endDate: json['end_date']?? '',
      schedule: json['schedule']?? ''
    );
  }
}
