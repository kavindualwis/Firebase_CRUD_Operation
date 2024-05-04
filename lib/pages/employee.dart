// ignore_for_file: use_build_context_synchronously

import 'package:firebase_crud/components/my_button.dart';
import 'package:firebase_crud/components/my_text_field.dart';
import 'package:firebase_crud/services/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final locationController = TextEditingController();
  final jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.purple[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple[100],
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ADD',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'DETAILS',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name Input
                MyTextField(
                  controller: nameController,
                  text: 'Name',
                ),

                //Age Input
                MyTextField(
                  controller: ageController,
                  text: 'Age',
                ),

                //Location Input
                MyTextField(
                  controller: locationController,
                  text: 'Location',
                ),

                //Job Input
                MyTextField(
                  controller: jobController,
                  text: 'Job Details',
                ),

                //Update Button

                Center(
                  child: MyButton(
                    onPressed: () async {
                      String id = randomAlpha(10);
                      Map<String, dynamic> employeeInfoMap = {
                        "Name": nameController.text,
                        "Age": ageController.text,
                        "Id": id,
                        "Location": locationController.text,
                        "Job": jobController.text,
                      };
                      await DatabaseMethods()
                          .addEmployeeDetails(employeeInfoMap, id)
                          .then(
                            (value) => showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                title: Text(
                                  'Emplyee details added succesfully!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
