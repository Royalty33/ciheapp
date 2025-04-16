import 'package:ciheapp/model/user.dart';
import 'package:ciheapp/view/message/chat_screen.dart';
import 'package:ciheapp/view/message/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherStudentList extends StatefulWidget {
  const TeacherStudentList({Key? key}) : super(key: key);

  @override
  State<TeacherStudentList> createState() => _TeacherStudentListState();
}

class _TeacherStudentListState extends State<TeacherStudentList> {
  final List<User> _mockStudents = [
    User(
      id: 1,
      firstname: 'Bijaya ',
      lastname: 'Gautam',
      name: 'Bijaya Gautam',
      email: 'bijaya@example.com',
      role: UserRole.student,
      status: 'active',
      notificationPreferences: NotificationPreferences(),
    ),
    User(
      id: 2,
      firstname: 'Arbin',
      lastname: 'Shrestha',
      name: 'Arbin Shrestha',
      email: 'arbin@example.com',
      role: UserRole.student,
      status: 'active',
      notificationPreferences: NotificationPreferences(),
    ),
    User(
      id: 3,
      firstname: 'Kritika',
      lastname: 'Maharjan',
      name: 'Kritika Maharjan',
      email: 'kritika@example.com',
      role: UserRole.student,
      status: 'active',
      notificationPreferences: NotificationPreferences(),
    ),
    User(
      id: 4,
      firstname: 'Sameet',
      lastname: 'Khadka',
      name: 'Sameet Khadka',
      email: 'sameet@example.com',
      role: UserRole.student,
      status: 'active',
      notificationPreferences: NotificationPreferences(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search students...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _mockStudents.length,
              itemBuilder: (context, index) {
                final student = _mockStudents[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: student.profileImageUrl != null
                          ? NetworkImage(student.profileImageUrl!)
                          : null,
                      child: student.profileImageUrl == null
                          ? Text(student.name.substring(0, 1).toUpperCase())
                          : null,
                    ),
                    title: Text(student.name),
                    subtitle: Text(student.email),
                    trailing: IconButton(
                      icon: const Icon(Icons.message),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>ChatScreen(userId: student.id.toString(), userName: student.name),));
                      },
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
