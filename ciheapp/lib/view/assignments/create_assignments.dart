import 'package:flutter/material.dart';

class CreateAssignment extends StatefulWidget {
  const CreateAssignment({super.key});

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _assignmentTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Assignment'),
       
      ),
      body:SingleChildScrollView(scrollDirection: Axis.vertical,child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10,vertical: 30),
        child: Container(
        
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 120, 119, 119).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3), 
                  ),
                ],
              
            ),
          
          
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:Form(child:  Column(
                children: [
                  TextFormField(
                    controller: _courseNameController,
                    decoration: const InputDecoration(
                       prefixIcon: Icon(Icons.subject_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      labelText: 'Course Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter course name';
                      }
                      return null;
                    },
                    
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    
                    controller:_assignmentTitleController,
                    decoration: const InputDecoration(labelText: 'Assignment Title',
                    prefixIcon: Icon(Icons.assignment_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter assignment title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      labelText: 'Description'),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 26),
                 ElevatedButton(
                            
                           
                            onPressed: () {
                              if (_formKey.currentState?.validate()?? false)  {
                                setState(() {
                                  _isLoading = true;
                                });
                               
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                              String courseName = _courseNameController.text;
                              String assignment = _assignmentTitleController.text;
                              String description = _descriptionController.text;
                             
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Upload'),
                          
                        ),
                ],
              ),)
            ),
          ),
        ),
      ),
    );
  }
}