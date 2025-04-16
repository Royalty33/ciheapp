import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Assignment {
  final String title;
  final String subject;
  final DateTime dueDate;
  final String submitLink;

  Assignment({
    required this.title,
    required this.subject,
    required this.dueDate,
    required this.submitLink,
  });
}

class AssignmentScreen extends StatelessWidget {
  AssignmentScreen({super.key});

  final List<Assignment> assignments = [
    Assignment(
      title: 'DSA Assignment 1',
      subject: 'DSA',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      submitLink: '',
    ),
    Assignment(
      title: 'TOC Assignments',
      subject: 'TOC',
      dueDate: DateTime.now().add(const Duration(days: 4)),
      submitLink: '',
    ),
    Assignment(
      title: 'Advanced Java Assignments',
      subject: 'Advanced Java',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      submitLink: '',
    ),
  ];

void _launchURL(BuildContext context, String url) async {
  if (url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(' OOPS! Submission link has not been provided yet.'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not launch the submission link.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: assignments.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Text("Subject: ${assignment.subject}", style: const TextStyle( color: Color.fromARGB(255, 12, 201, 5)),),
                  Text("Due: ${assignment.dueDate.toLocal().toString().split(' ')[0]}",style: const TextStyle( color: Color.fromARGB(255, 247, 159, 7))),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(context,assignment.submitLink),
                      icon: const Icon(Icons.open_in_new,color: Colors.white,),
                      label: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
