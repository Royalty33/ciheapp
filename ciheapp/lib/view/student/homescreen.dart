import 'package:ciheapp/calender_screen.dart';
import 'package:ciheapp/service/api/loginservice.dart';
import 'package:ciheapp/view/assignments/assignmentslist.dart';
import 'package:ciheapp/view/assignmentscreen.dart';
import 'package:ciheapp/view/authscreen/loginscreen.dart';
import 'package:ciheapp/view/message/message_screen.dart';
import 'package:ciheapp/profilescreen.dart';
import 'package:ciheapp/view/notification/notificationscreen.dart';
import 'package:ciheapp/view/student/studentenrollement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<NotificationProvider>().initialize();
    // });
    _screens = [
      const MessagesScreen(),
       AssignmentScreen(),
      // const StudentEnrollmentScreen(),
      const CalendarScreen(),
      const ProfileScreen(),
    ];
  }

  // Future<void> _initializeData() async {

  //   final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
  //   await notificationProvider.initialize();
  // }

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    // final notificationProvider = Provider.of<NotificationProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CIHE'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StudentNotificationScreen()));
              }),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: _getNavigationItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavigationItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: 'Message',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.assignment),
        label: 'Assignments',
      ),
      // const BottomNavigationBarItem(
      //   icon: Icon(Icons.how_to_reg),
      //   label: 'Enrollement',
      // ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label: 'Calender',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];
  }

  Widget _buildNotificationIcon(int unreadCount) {
    return Stack(
      children: [
        const Icon(Icons.notifications),
        if (unreadCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
                '$unreadCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final double screenwidth = MediaQuery.of(context).size.width;
        final double screenheight = MediaQuery.of(context).size.height;
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
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
        );
      },
    );
  }
}
