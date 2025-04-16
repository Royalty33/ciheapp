import 'package:ciheapp/admin/adminnotification.dart';
import 'package:ciheapp/model/notification_type.dart';
import 'package:flutter/material.dart';

class AdminNotificationManagement extends StatefulWidget {
  const AdminNotificationManagement({Key? key}) : super(key: key);

  @override
  State<AdminNotificationManagement> createState() =>
      _AdminNotificationManagementState();
}

class _AdminNotificationManagementState
    extends State<AdminNotificationManagement> {
  final List<AppNotification> _mockNotifications = [
    AppNotification(
      id: '1',
      title: 'Campus Closure',
      message: 'Campus will be closed on Friday for maintenance',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.collegeNotice,
      isRead: true,
    ),
    AppNotification(
      id: '2',
      title: 'Exam Schedule Update',
      message:
          'The final exam schedule has been updated. Please check the portal for details.',
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
      type: NotificationType.exam,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Management'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _mockNotifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.notifications_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No notifications sent',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _mockNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = _mockNotifications[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 0),
                        child: ListTile(
                          leading: _getNotificationIcon(notification.type),
                          title: Text(notification.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.message,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Sent: ${_formatDate(notification.timestamp)}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteConfirmationDialog(notification.id);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => AdminNotificationScreen()));
        },
        icon: const Icon(Icons.send),
        label: const Text('Send Notification'),
      ),
    );
  }

  Widget _getNotificationIcon(NotificationType type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case NotificationType.assignment:
        iconData = Icons.assignment;
        iconColor = Colors.blue;
        break;
      case NotificationType.exam:
        iconData = Icons.quiz;
        iconColor = Colors.red;
        break;
      case NotificationType.collegeNotice:
        iconData = Icons.campaign;
        iconColor = Colors.orange;
        break;
      case NotificationType.message:
        iconData = Icons.message;
        iconColor = Colors.green;
        break;
      case NotificationType.other:
      default:
        iconData = Icons.notifications;
        iconColor = Colors.purple;
        break;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.2),
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _showDeleteConfirmationDialog(String notificationId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Notification'),
          content:
              const Text('Are you sure you want to delete this notification?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  _mockNotifications.removeWhere((n) => n.id == notificationId);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSendNotificationDialog() async {
    final titleController = TextEditingController();
    final messageController = TextEditingController();
    NotificationType selectedType = NotificationType.collegeNotice;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Send Notification'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<NotificationType>(
                      value: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Notification Type',
                        border: OutlineInputBorder(),
                      ),
                      items: NotificationType.values.map((type) {
                        return DropdownMenuItem<NotificationType>(
                          value: type,
                          child: Text(_getNotificationTypeName(type)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Send'),
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        messageController.text.isNotEmpty) {
                      final newNotification = AppNotification(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text,
                        message: messageController.text,
                        timestamp: DateTime.now(),
                        type: selectedType,
                        isRead: false,
                      );

                      setState(() {
                        _mockNotifications.insert(0, newNotification);
                      });

                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Notification sent successfully')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill in all fields')),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _getNotificationTypeName(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return 'Assignment';
      case NotificationType.exam:
        return 'Exam';
      case NotificationType.collegeNotice:
        return 'College Notice';
      case NotificationType.message:
        return 'Message';
      case NotificationType.other:
        return 'Other';
    }
  }
}
