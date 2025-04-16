import 'package:flutter/material.dart';
import 'package:ciheapp/model/notification_type.dart';

class AdminNotificationScreen extends StatefulWidget {
  const AdminNotificationScreen({Key? key}) : super(key: key);

  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  NotificationType selectedType = NotificationType.collegeNotice;

  final List<String> semesters = [
    'First',
    'Second',
    'Third',
    'Fourth',
    'Fifth',
    'Sixth',
    'Seventh'
  ];
  final List<String> teachers = [
    'Reza Rafeh',
    'Pradip Bhandari',
    'Mutaz Barika',
    'Ashraf Uddin',
    'Marjan'
  ];
  final List<String> students = [
    'Bijaya Gautam',
    'Arbind Shrestha',
    'Sameet Khadka',
    'Kritika Maharjan'
  ];

  List<String> selectedFaculties = [];
  List<String> selectedTeachers = [];
  List<String> selectedStudents = [];

  void _sendNotification() {
    if (_titleController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    debugPrint('Notification Type: ${_getNotificationTypeName(selectedType)}');
    debugPrint('Faculties: $selectedFaculties');
    debugPrint('Teachers: $selectedTeachers');
    debugPrint('Students: $selectedStudents');
    debugPrint('Title: ${_titleController.text}');
    debugPrint('Message: ${_messageController.text}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification sent successfully!')),
    );

    setState(() {
      selectedFaculties.clear();
      selectedTeachers.clear();
      selectedStudents.clear();
      _titleController.clear();
      _messageController.clear();
    });
  }

  Future<void> _selectMultipleItems(
      BuildContext context, List<String> items, List<String> selectedItems) async {
    final List<String> selected = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return MultiSelectDialog(
          items: items,
          selectedItems: selectedItems,
        );
      },
    ) ?? [];
    setState(() {
      selectedItems.clear();
      selectedItems.addAll(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Notification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<NotificationType>(
              value: selectedType,
              decoration: const InputDecoration(
                labelText: 'Notification Type',
                border: OutlineInputBorder(),
              ),
              items: NotificationType.values.map((type) {
                return DropdownMenuItem(
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
            GestureDetector(
              onTap: () => _selectMultipleItems(context, semesters, selectedFaculties),
              child: _buildMultiSelectDropdown('Select Faculty', selectedFaculties),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectMultipleItems(context, teachers, selectedTeachers),
              child: _buildMultiSelectDropdown('Select Teacher', selectedTeachers),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectMultipleItems(context, students, selectedStudents),
              child: _buildMultiSelectDropdown('Select Student', selectedStudents),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Message'),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _sendNotification,
              icon: const Icon(Icons.send,color:Colors.white,), 
            iconAlignment: IconAlignment.end,
              label: const Text('Send Notification'),
            
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiSelectDropdown(String label, List<String> selectedItems) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      child: Wrap(
        spacing: 8.0,
        children: selectedItems.map((item) {
          return Chip(
            label: Text(item),
          );
        }).toList(),
      ),
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
      default:
        return 'Unknown';
    }
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  const MultiSelectDialog({
    Key? key,
    required this.items,
    required this.selectedItems,
  }) : super(key: key);

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _selectedItems;
  late bool _selectAll;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
    _selectAll = widget.items.length == _selectedItems.length;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Items'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Select All'),
              value: _selectAll,
              onChanged: (value) {
                setState(() {
                  _selectAll = value!;
                  if (_selectAll) {
                    _selectedItems = List.from(widget.items);
                  } else {
                    _selectedItems.clear();
                  }
                });
              },
            ),
            ...widget.items.map((item) {
              return CheckboxListTile(
                title: Text(item),
                value: _selectedItems.contains(item),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedItems.add(item);
                    } else {
                      _selectedItems.remove(item);
                    }
                    _selectAll = widget.items.length == _selectedItems.length;
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedItems);
          },
          child: const Text('Done'),
        ),
      ],
    );
  }
}
