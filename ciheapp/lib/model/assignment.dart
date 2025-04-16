enum AssignmentStatus {
  pending,
  submitted,
  late,
  graded,
  returned
}

class Assignment {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String courseId;
  final String courseName;
  final int totalPoints;
  final AssignmentStatus status;
  final int? earnedPoints;
  final String? submissionUrl;
  final DateTime? submissionDate;
  final String? feedback;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.courseId,
    required this.courseName,
    required this.totalPoints,
    required this.status,
    this.earnedPoints,
    this.submissionUrl,
    this.submissionDate,
    this.feedback,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      courseId: json['courseId'],
      courseName: json['courseName'],
      totalPoints: json['totalPoints'],
      status: AssignmentStatus.values.firstWhere(
        (e) => e.toString() == 'AssignmentStatus.${json['status']}',
        orElse: () => AssignmentStatus.pending,
      ),
      earnedPoints: json['earnedPoints'],
      submissionUrl: json['submissionUrl'],
      submissionDate: json['submissionDate'] != null
          ? DateTime.parse(json['submissionDate'])
          : null,
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'courseId': courseId,
      'courseName': courseName,
      'totalPoints': totalPoints,
      'status': status.toString().split('.').last,
      'earnedPoints': earnedPoints,
      'submissionUrl': submissionUrl,
      'submissionDate': submissionDate?.toIso8601String(),
      'feedback': feedback,
    };
  }
}

