// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/view/add_screen.dart';
import 'package:student_app/controller/db_functions_provider.dart';
import 'package:student_app/widgets/person_details.dart';

import '../view/edit_screen.dart';


class ListStudentWidget extends StatelessWidget {
  final na_me;
  final a_ge;
  //  ignore: use_key_in_widget_constructors
  const ListStudentWidget({
    this.na_me,
    this.a_ge,
  });

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentDbProvider>(context, listen: false);
    studentProvider.getAllStudents();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddScreen()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Student List"),
          leading: const Icon(Icons.person, size: 40),
        ),
        body: Consumer<StudentDbProvider>(
          builder: (context, studentProvider, child) {
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentProvider.studentList[index];
                return Container(
                  height: 70,
                  width: double.infinity,
                  color: Colors.yellow[100],
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PersonalDetails(
                              a_: data.name,
                              b_: data.age,
                              c_: data.address,
                              d_: data.phone,
                              e_: data.i_mage,
                            ))),
                    title: Text(
                      data.name,
                    ),
                    subtitle: Text(data.age),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.i_mage)),
                    ),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => edit_student(
                                      index: index,
                                      stdname: data.name,
                                      stdage: data.age,
                                      stdaddress: data.address,
                                      stdphone: data.phone,
                                      stdimage: data.i_mage),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                              onPressed: () {
                                studentProvider.deleteStudent(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount:studentProvider.studentList.length,
            );
          },
        ),
      ),
    );
  }
}
