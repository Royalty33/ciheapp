import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationModel {
  final String title;
  final String body;
  final String sender;
  final DateTime timestamp;

  NotificationModel({
    required this.title,
    required this.body,
    required this.sender,
    required this.timestamp,
  });
}

class StudentNotificationScreen extends StatelessWidget {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "Exam Notice",
      body: "The final exam will begin from 5th May.",
      sender: "Administrator",
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    NotificationModel(
      title: "Class Cancellation",
      body: "Tomorrow's DSA class is cancelled.",
      sender: "Teacher - Mr. Reza",
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    NotificationModel(
      title: "Event Invitation",
      body: "You are invited to participate in the AI Exhibition.",
      sender: "Administrator",
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  StudentNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications_active, color: Colors.blue),
              title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.body),
                  const SizedBox(height: 4),
                  Text(
                    "${notification.sender} • ${timeago.format(notification.timestamp)}",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
