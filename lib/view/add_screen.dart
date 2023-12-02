// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/add_provider.dart';
import 'package:student_app/controller/db_functions_provider.dart';
import 'package:student_app/helper/colors.dart';
import 'package:student_app/widgets/list_student_widget.dart';
import 'package:student_app/model/data_model.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentDbProvider>(context, listen: false);
    studentProvider. getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person_add_alt_1, size: 35),
          title: const Text("Add Student"),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Consumer<AddProvider>(
              builder: (context, value, child) {
                return ListView(
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: CircleAvatar(
                        radius: 80,
                        child: value.file == null
                            ? const CircleAvatar(
                                radius: 90,
                                backgroundImage:
                                    AssetImage("assets/download (2).png"),
                              )
                            : SizedBox(
                                height: 200,
                                width: 180,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    value.file!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kBlue900),
                              onPressed: () {
                                value.getcam();
                              },
                              child: const Text(
                                "Take picture",
                                style: TextStyle(
                                  color:kWhite,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 160,
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:kBlue900),
                              onPressed: () {
                                value.getgall();
                              },
                              child: const Text(
                                "From gallery",
                                style: TextStyle(
                                  color:kWhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: value.nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: value.ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Age',
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: value.phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone',
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: value.addressController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Address',
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:kBlue900),
                        onPressed: () {
                          onAddStudentButtonCliked(context);
                          value.addressController.clear();
                          value.ageController.clear();
                          value.phoneController.clear();
                          value.nameController.clear();
                          value.file = null;
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("ADD STUDENT"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonCliked(BuildContext context) async {
    final addProvider = Provider.of<AddProvider>(context, listen: false);
    final _name = addProvider.nameController.text.trim();
    final _age = addProvider.ageController.text.trim();
    final _phone = addProvider.phoneController.text.trim();
    final _address = addProvider.addressController.text.trim();

    if (_name.isEmpty ||
        _age.isEmpty ||
        _phone.isEmpty ||
        _address.isEmpty ||
        addProvider.file!.path.isEmpty) {
      return;
    } else {
      final _student = StudentModel(
          name: _name,
          age: _age,
          phone: _phone,
          address: _address,
          i_mage: addProvider.file!.path);


         final studentProvider = Provider.of<StudentDbProvider>(context, listen: false);
     studentProvider.addStudent(_student);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => ListStudentWidget(
                a_ge: _age,
                na_me: _name,
              )),
        ),
      );
    }
  }
}
