import 'package:flutter/material.dart';

class announcementscreen extends StatefulWidget {
  const announcementscreen({super.key});

  @override
  State<announcementscreen> createState() => _announcementscreenState();
}

class _announcementscreenState extends State<announcementscreen> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? _dropdownSelectedStudent;

  final List<String> _courses = [
    'Networking',
    'Cloud Computing',
    'Cyber Security',
    'Software Engineering',
  ];

  final List<String> _students = [
    'Arbin Shrestha',
    'Bijaya Gautam',
    'Sameet Khadka',
    'Kritika Maharjan',
  ];

  String? _selectedCourse;
  List<String> _selectedStudents = [];
  bool _selectAll = false;

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      if (_selectAll) {
        _selectedStudents = List.from(_students);
      } else {
        _selectedStudents.clear();
      }
    });
  }

  void _toggleStudent(String student, bool? value) {
    setState(() {
      if (value == true) {
        _selectedStudents.add(student);
      } else {
        _selectedStudents.remove(student);
        _selectAll = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _titlecontroller,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          prefixIcon: const Icon(Icons.title),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedCourse,
                        decoration: InputDecoration(
                          hintText: 'Select Course',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.book),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        items: _courses.map((course) {
                          return DropdownMenuItem(
                            value: course,
                            child: Text(course),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCourse = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                    value: _dropdownSelectedStudent,
                    decoration: InputDecoration(
                      hintText: 'Select Student',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                   
                    hint: const Text('Select Student'),
                    items: _students.map((student) {
                      return DropdownMenuItem(
                        value: student,
                        child: Text(student),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _dropdownSelectedStudent = value;
                      });
                    },
                  ),

                      const SizedBox(height: 10),
                      CheckboxListTile(
                        title: const Text('Select All Students'),
                        value: _selectAll,
                        onChanged: _toggleSelectAll,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),

                     
                      if (_selectAll) ...[
                        ..._students.map((student) {
                          return CheckboxListTile(
                            title: Text(student),
                            value: _selectedStudents.contains(student),
                            onChanged: (value) => _toggleStudent(student, value),
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        }).toList(),
                      ],

                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptioncontroller,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          prefixIcon: const Icon(Icons.description_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.send, color: Colors.white),
                        iconAlignment: IconAlignment.end,
                        onPressed: () {
                          String title = _titlecontroller.text;
                          String description = _descriptioncontroller.text;

                          if (_formkey.currentState!.validate()) {
                            debugPrint('Course: $_selectedCourse');
                            debugPrint('Selected Students: $_selectedStudents');
                            debugPrint('Title: $title');
                            debugPrint('Description: $description');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        label: const Text('Send'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
