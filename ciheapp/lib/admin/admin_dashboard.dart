import 'package:ciheapp/admin/course/admincourse_management.dart';
import 'package:ciheapp/admin/enrollement/enrollement.dart';
import 'package:ciheapp/admin/group/groupscreen.dart';
import 'package:ciheapp/service/api/loginservice.dart';
import 'package:ciheapp/view/authscreen/loginscreen.dart';
import 'package:ciheapp/admin/adminnotification.dart';
import 'package:flutter/material.dart';

import 'usersmanagement/admin_user_management.dart';
import 'admin_notification_management.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final Map<String, int> _mockStats = {
    'students': 250,
    'faculty': 30,
    'courses': 45,
    'activeUsers': 180,
  };

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AdminNotificationManagement()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Administrator',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard(context, 'Students', _mockStats['students']!,
                    Icons.school, Colors.blue),
                _buildStatCard(context, 'Faculty', _mockStats['faculty']!,
                    Icons.people, Colors.green),
                _buildStatCard(context, 'Courses', _mockStats['courses']!,
                    Icons.book, Colors.orange),
                _buildStatCard(context, 'Active Users',
                    _mockStats['activeUsers']!, Icons.person, Colors.purple),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Management',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildManagementCard(
              context,
              'User Management',
              'Add, edit, or remove users',
              Icons.manage_accounts,
              Colors.blue,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminUserManagement(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildManagementCard(
              context,
              'Course Management',
              'Manage courses and enrollments',
              Icons.book,
              Colors.green,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminCourseManagement(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildManagementCard(
              context,
              'Enrollment Management',
              'Manage course enrollments',
              Icons.assignment_turned_in,
              Colors.red,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnrollmentScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildManagementCard(
              context,
              'Group',
              'Add, edit, or remove groups',
              Icons.settings,
              Colors.purple,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildManagementCard(
              context,
              'Notification Management',
              'Send announcements and notifications',
              Icons.notifications,
              Colors.orange,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminNotificationManagement(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    int value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 16),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementCard(
    BuildContext context,
    String title,
    String subtitle,
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
          child: Row(
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
