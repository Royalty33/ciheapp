import 'package:ciheapp/service/api/loginservice.dart';
import 'package:ciheapp/teacher/teacher_profile.dart';
import 'package:ciheapp/view/Grade/gradesubmission.dart';
import 'package:ciheapp/provider/courses_provider.dart';
import 'package:ciheapp/teacher/teacher_course.dart';
import 'package:ciheapp/teacher/teacher_studentlist.dart';
import 'package:ciheapp/teacher/teacherassignment.dart';
import 'package:ciheapp/view/assignments/create_assignments.dart';
import 'package:ciheapp/view/authscreen/loginscreen.dart';
import 'package:ciheapp/view/notification/announcement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({Key? key}) : super(key: key);

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TeacherProfileScreen()));
              },
              icon: Icon(Icons.person)),
          IconButton(
              onPressed: () async {
                UserService userService = UserService();
                final bool success = await userService.logout();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Successfully logged out.'
                          : 'Logout failed. Please try again.',
                      style: TextStyle(fontSize: screenwidth * 0.035),
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );

                if (success) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: courseProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Image.asset('assets/images/logo.png',
                                height: 70, width: 70),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome,Teacher  ',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Faculty,BIt',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Actions',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionCard(
                                context,
                                'Create Assignment',
                                Icons.assignment_add,
                                Colors.blue,
                                () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const CreateAssignment()));
                                },
                              ),
                            ),
                            const SizedBox(width: 16),        Expanded(
                              child: _buildActionCard(
                                context,
                                'Send Announcement',
                                Icons.campaign,
                                Colors.green,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          announcementscreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Expanded(
                            //   child: _buildActionCard(
                            //     context,
                            //     'Grade Submissions',
                            //     Icons.grading,
                            //     Colors.orange,
                            //     () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (_) =>
                            //                   GradeSubmissionCard()));
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                    
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildActionCard(
                                context,
                                'View Students',
                                Icons.people,
                                Colors.purple,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TeacherStudentList(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Courses',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TeacherCourseList(),
                                  ),
                                );
                              },
                              child: const Text('View All'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildCoursesList(courseProvider),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Assignments',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TeacherAssignmentList(),
                                  ),
                                );
                              },
                              child: const Text('View All'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildRecentAssignments(),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                radius: 24,
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoursesList(CourseProvider courseProvider) {
    final courses = courseProvider.courses;

    if (courses.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text('No courses found'),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length > 3 ? 3 : courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Card(
          child: ListTile(
            title: Text(course.name),
            subtitle: Text(course.code),
            trailing: Text(
              '${course.enrolledStudentIds.length} students',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildRecentAssignments() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.2),
              child: const Icon(
                Icons.assignment,
                color: Colors.blue,
              ),
            ),
            title: Text('Assignment ${index + 1}'),
            subtitle: Text(
                'Due: ${_formatDate(DateTime.now().add(Duration(days: index + 1)))}'),
            trailing: Text(
              '${index * 5} submissions',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {},
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
