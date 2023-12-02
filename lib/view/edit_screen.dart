// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/edit_Provider.dart';
import 'package:student_app/helper/colors.dart';
import '../controller/db_functions_provider.dart';
import '../widgets/list_student_widget.dart';
import '../model/data_model.dart';

// ignore: must_be_immutable, camel_case_types
class edit_student extends StatefulWidget {
  var stdname;
  var stdage;
  var stdaddress;
  var stdphone;
  dynamic stdimage;

  int index;

  // ignore: use_key_in_widget_constructors
  edit_student(
      {required this.index,
      required this.stdname,
      required this.stdage,
      required this.stdaddress,
      required this.stdphone,
      required this.stdimage});

  @override
  State<edit_student> createState() => _edit_studentState();
}

// ignore: camel_case_types
class _edit_studentState extends State<edit_student> {
  final space = const SizedBox(
    height: 30,
  );

  @override
  void initState() {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    super.initState();
    editProvider.studentname = TextEditingController(text: widget.stdname);
    editProvider.studentage = TextEditingController(text: widget.stdage);
    editProvider.studentaddress =
        TextEditingController(text: widget.stdaddress);
    editProvider.studentphone = TextEditingController(text: widget.stdphone);
    editProvider.profilephoto = widget.stdimage;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ListStudentWidget())),
                icon: const Icon(Icons.home))
          ],
          title: const Text(
            "Edit List",
            style: TextStyle(fontSize: 25),
          ),
          shadowColor: kGrey,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: kRgbWhite,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 50),
                  Consumer<EditProvider>(
                    builder: (context, editProvider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: kRgblight,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                onPressed: () => editProvider.getcam(),
                                icon: const Icon(Icons.camera_alt_outlined)),
                          ),
                          Container(
                            child: editProvider.file != null
                                ? CircleAvatar(
                                    radius: 80,
                                    child: SizedBox(
                                      width: 160,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(110),
                                        child: Image.file(
                                          editProvider.file!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ))
                                : CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(widget.stdimage)),
                                    radius: 80,
                                  ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: kRgbmid ,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                onPressed: () => editProvider.getimage(),
                                icon: const Icon(Icons.photo_sharp)),
                          ),
                        ],
                      );
                    },
                  ),
                  space,
                  Consumer<EditProvider>(
                    builder: (context, value, child) {
                      return Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: value.studentname,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Name',
                                filled: true,
                              ),
                            ),
                            space,
                            TextFormField(
                              controller: value.studentage,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Age',
                                filled: true,
                              ),
                            ),
                            space,
                            TextFormField(
                              controller: value.studentphone,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Phone',
                                filled: true,
                              ),
                            ),
                            space,
                            TextFormField(
                              controller: value.studentaddress,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Address',
                                filled: true,
                              ),
                            ),
                            space,
                            SizedBox(
                              width: 400,
                              height: 50,
                              /////////////////////////////Elevated button////////////////////////////////////
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  edtingall();
                                },
                                icon: const Icon(Icons.flag),
                                label: const Text(
                                  "UPDATE",
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kBlue900),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> edtingall() async {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    final st1 = editProvider.studentname.text.trim();
    final st2 = editProvider.studentage.text.trim();
    final st3 = editProvider.studentaddress.text.trim();
    final st4 = editProvider.studentphone.text.trim();

    if (st1.isEmpty ||
        st2.isEmpty ||
        st3.isEmpty ||
        st4.isEmpty ||
        editProvider.profilephoto.isEmpty) {
      return;
    } else {
      final updation = StudentModel(
          name: st1,
          age: st2,
          phone: st3,
          address: st4,
          i_mage: editProvider.profilephoto);
      final studentProvider = Provider.of<StudentDbProvider>(context, listen: false);
      studentProvider. update(widget.index, updation);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ListStudentWidget()));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: krgb,
          content: Text("Updated")));
    }
  }
}
