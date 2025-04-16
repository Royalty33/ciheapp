import 'package:ciheapp/model/assignment.dart';
import 'package:ciheapp/provider/assignment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TeacherAssignmentList extends StatefulWidget {
  const TeacherAssignmentList({Key? key}) : super(key: key);

  @override
  State<TeacherAssignmentList> createState() => _TeacherAssignmentListState();
}

class _TeacherAssignmentListState extends State<TeacherAssignmentList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadAssignments();
    });
    
  }

  Future<void> _loadAssignments() async {
    final assignmentProvider = Provider.of<AssignmentProvider>(context, listen: false);
    await assignmentProvider.fetchAssignments();
  }

  @override
  Widget build(BuildContext context) {
    final assignmentProvider = Provider.of<AssignmentProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: assignmentProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadAssignments,
              child: assignmentProvider.assignments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.assignment,
                            size: 80,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No assignments found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: assignmentProvider.assignments.length,
                      itemBuilder: (context, index) {
                        final assignment = assignmentProvider.assignments[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                          child: ListTile(
                            leading: _getAssignmentStatusIcon(assignment.status),
                            title: Text(assignment.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(assignment.courseName),
                                const SizedBox(height: 4),
                                Text(
                                  'Due: ${_formatDate(assignment.dueDate)}',
                                  style: TextStyle(
                                    color: _getDueDateColor(assignment.dueDate),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                            trailing: Text(
                              '${assignment.totalPoints} pts',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onTap: () {
                             
                            },
                          ),
                        );
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
       
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _getAssignmentStatusIcon(AssignmentStatus status) {
    IconData iconData;
    Color iconColor;
    
    switch (status) {
      case AssignmentStatus.pending:
        iconData = Icons.assignment_outlined;
        iconColor = Colors.blue;
        break;
      case AssignmentStatus.submitted:
        iconData = Icons.assignment_turned_in_outlined;
        iconColor = Colors.orange;
        break;
      case AssignmentStatus.late:
        iconData = Icons.assignment_late_outlined;
        iconColor = Colors.red;
        break;
      case AssignmentStatus.graded:
        iconData = Icons.grading;
        iconColor = Colors.green;
        break;
      case AssignmentStatus.returned:
        iconData = Icons.assignment_return_outlined;
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
  
  Color _getDueDateColor(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    
    if (difference < 0) {
      return Colors.red;
    } else if (difference <= 2) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}

