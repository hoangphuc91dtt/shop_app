import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/layouts/header.dart';

import '../models/student_model.dart';
import '../providers/student_provider.dart';
import '../themes/colors.dart';

class StudentEditingScreen extends StatefulWidget {
  const StudentEditingScreen({super.key, required this.student});
  final Student student;

  @override
  State<StudentEditingScreen> createState() => _StudentEditingScreenState();
}

class _StudentEditingScreenState extends State<StudentEditingScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _studentIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _averageMarkController = TextEditingController();
  List<String> listSubjects = [];

  int reverseFormatDateString(String formattedDateString) {
    List<String> parts = formattedDateString.split('/');

    // Kết hợp các phần thành chuỗi "ddMMyyyy"
    if (parts.length >= 3) {
      String reversedDateString = "${parts[0]}${parts[1]}${parts[2]}";
      return int.parse(reversedDateString);
    }
    return int.parse(formattedDateString);
  }

  String formatDateString(String inputString) {
    // Cắt chuỗi thành các phần tương ứng
    if (inputString.length == 8) {
      String day = inputString.substring(0, 2);
      String month = inputString.substring(2, 4);
      String year = inputString.substring(4, 8);

      // Kết hợp các phần với dấu "/"
      String formattedDate = "$day/$month/$year";

      return formattedDate;
    }
    return inputString;
  }

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.student?.fullName ?? "";
    _classController.text = widget.student?.className ?? "";
    _studentIdController.text = widget.student?.contactInfo.id ?? "";
    _emailController.text = widget.student?.contactInfo.email ?? "";
    _dobController.text = formatDateString(widget.student?.dateOfBirth.toString() ?? "");
    _addressController.text = widget.student?.contactInfo.address ?? "";
    _phoneNumberController.text = widget.student?.contactInfo.phoneNumber ?? "";
    _averageMarkController.text = widget.student?.averageScore?.toString() ?? "";
    listSubjects = widget.student?.registeredCourses ?? [];
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi widget bị hủy
    _fullNameController.dispose();
    _classController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _averageMarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Student? student = ModalRoute.of(context)?.settings.arguments as Student?;
    final studentProvider = Provider.of<StudentProvider>(context, listen: true);
    print("========================");
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Header(),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Student Information',
                        style: TextStyle(
                          color: Color(0xff96C0FF),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fullname',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _fullNameController,
                              decoration: InputDecoration(
                                hintText: "${student?.fullName ?? ''}",
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Class',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: TextField(
                                          controller: _classController,
                                          decoration: InputDecoration(
                                            hintText: 'enter new value',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 1.0, horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Student ID',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: TextField(
                                          controller: _studentIdController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: 'enter new value ...',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 1.0, horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            hintText: 'enter new value ...',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 1.0, horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date of birth',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: TextField(
                                          controller: _dobController,
                                          decoration: InputDecoration(
                                            hintText: 'enter new value ...',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 1.0, horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Address',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: TextField(
                                          controller: _addressController,
                                          decoration: InputDecoration(
                                            hintText: 'enter new value ...',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 1.0, horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone number',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: TextField(
                                          controller: _phoneNumberController,
                                          decoration: InputDecoration(
                                            hintText: 'enter new value ...',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 1.0, horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Average mark',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                            TextField(
                              controller: _averageMarkController,
                              decoration: InputDecoration(
                                hintText: 'enter new value ...',
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            Text(
                              'List subjects',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                            Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: [
                                for (String subject in listSubjects)
                                  Container(
                                    child: TextButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.white),
                                      ),
                                      child: Text(subject),
                                    ),
                                  ),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Wrap(
                                              children: [
                                                for (var entry
                                                    in studentProvider.activeSubjects.entries)
                                                  CheckboxListTile(
                                                    title: Text(entry.key),
                                                    value: entry.value,
                                                    onChanged: (value) {
                                                      studentProvider.setActiveSubject(
                                                          entry.key, value ?? false);
                                                    },
                                                  ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {},
                                                child: Text('Save'),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: Text('Cancel'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all(
                                        CircleBorder(),
                                      ),
                                    ),
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            width: 70,
                            child: TextButton(
                              onPressed: () {
                                final studentProvider =
                                    Provider.of<StudentProvider>(context, listen: false);
                                studentProvider.updateStudent(Student(
                                    fullName: _fullNameController.text,
                                    registeredCourses: listSubjects,
                                    className: _classController.text,
                                    contactInfo: ContactInfo(
                                        id: _studentIdController.text,
                                        address: _addressController.text,
                                        email: _emailController.text,
                                        phoneNumber: _phoneNumberController.text),
                                    id: widget.student?.id ?? "",
                                    averageScore: double.parse(_averageMarkController.text),
                                    dateOfBirth: reverseFormatDateString(_dobController.text)));
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color(0xffFFD566)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 2,
                                      color: Color(0xff1F3F9F),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 40,
                            width: 70,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(AppColor.primaryColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 2,
                                      color: Color(0xffFFFFFF),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
