class Enrollment {
  final int id;
  final String status;
  final String courseName;
  final String studentName;

  Enrollment({
    required this.id,
    required this.status,
    required this.courseName,
    required this.studentName,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    final course = json['course'];
    final student = json['student'];
    return Enrollment(
      id: json['id'] ?? 0,
      status: json['status'],
      courseName: course != null
          ? course['name'] ?? 'Unknown Course'
          : 'Unknown Course',
      studentName: student != null
          ? student['first_name'] ?? 'Unknown Student'
          : 'Unknown Student',
    );
  }
}

class Group {
  final int id;
  final int userid;
  final int groupid;
  final String groupname;
  final String courseName;
  final List<GroupMember> membersNames;

  Group({
    required this.id,
    required this.groupid,
    required this.userid,
    required this.groupname,
    required this.courseName,
    required this.membersNames,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    final course = json['course'];
    final members = json['members'] as List<dynamic> ?? [];

    final membersNames = members.map<GroupMember>((member) {
      final user = member['user'];
      final mId = member['id'] ?? 0;
      final groupId = member['group_id'] ?? 0;
      final userId = member['user_id'] ?? 0;
      final id = user['id'] ?? 0;

      final firstName = user['first_name'] ?? '';
      final lastName = user['last_name'] ?? '';
      final name = '$firstName $lastName'.trim();
      return GroupMember(mId: mId, groupId: groupId, userId: userId, name: name);
    }).toList();

    return Group(
      id: json['id'] ?? 0,
      userid: json['user_id'] ?? 0,
      groupid: json['group_id'] ?? 0,
      groupname: json['group_name'] ?? '',
      courseName: course != null
          ? course['name'] ?? 'Unknown Course'
          : 'Unknown Course',
      membersNames: membersNames,
    );
  }
}

class GroupMember {
  final int mId;
  final int groupId;
  final int userId;
  final String name;

  GroupMember({
    required this.mId,
    required this.groupId,
    required this.userId,
    required this.name,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final mid = json['id'] ?? 0; 
    final groupId = json['group_id'] ?? 0; 
    final userId = json['user_id'] ?? 0;
    final firstName = user['first_name'] ?? '';
    final lastName = user['last_name'] ?? '';
    final name = '$firstName $lastName'.trim();
    return GroupMember(mId: mid, groupId: groupId, userId: userId, name: name);
  }
}
