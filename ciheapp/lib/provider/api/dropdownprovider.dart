import 'package:ciheapp/service/api/dropdownservice.dart';
import 'package:flutter/material.dart';

class PosDropdownProvider with ChangeNotifier {
  List<Map<String, dynamic>> _course = [];
  List<Map<String, dynamic>> _student = [];

  int? selectedCourseId;
 int? selectedstudentId;

  List<Map<String, dynamic>> get course => _course;
  List<Map<String, dynamic>> get student => _student;

  Future<void> fetchCourses() async {
    try {
      _course = await DropdownService.fetchCourseList();
      notifyListeners();
    } catch (error) {
      print("Error fetching course list: $error");
    }
  }

   Future<void> fetchStudents() async {
    try {
      _course = await DropdownService.fetchStudentList();
      notifyListeners();
    } catch (error) {
      print("Error fetching  student list: $error");
    }
  }

  void setCourseType(String value) {
    final title = value.split('(')[0].trim(); 

    final selectedCourse = _course.firstWhere(
      (element) => element['name'] == title, 
      orElse: () => {},
    );

    if (selectedCourse.isNotEmpty) {
      selectedCourseId = selectedCourse['id'];
      notifyListeners();
    } else {
      print("Course not found for title: $title");
    }
  }
  void setStudent(String value) {
    final title = value.split('(')[0].trim(); 

    final selectedStudent = _course.firstWhere(
      (element) => element['name'] == title, 
      orElse: () => {},
    );

    if (selectedStudent.isNotEmpty) {
      selectedstudentId = selectedStudent['id'];
      notifyListeners();
    } else {
      print("student not found for title: $title");
    }
  }
 
  void clearSelections() {
    selectedCourseId = null;
    selectedstudentId = null;
    notifyListeners();
  }
}
