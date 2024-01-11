import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/layouts/header.dart';
import 'package:untitled/providers/event_provider.dart';

import '../models/event_model.dart';
import '../models/student_model.dart';
import '../providers/student_provider.dart';
import '../themes/colors.dart';

class EventEditingScreen extends StatefulWidget {
  const EventEditingScreen({super.key, required this.event});
  final Event event;

  @override
  State<EventEditingScreen> createState() => _EventEditingScreenState();
}

class _EventEditingScreenState extends State<EventEditingScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _eventIdController = TextEditingController();
  List<String> listAttendEvents = [];

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.event?.fullName ?? "";
    _classController.text = widget.event?.className ?? "";
    _eventIdController.text = widget.event?.id ?? "";
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    eventProvider.groupEvents();
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi widget bị hủy
    _fullNameController.dispose();
    _classController.dispose();
    _eventIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Stack(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'STUDENT',
                                style: TextStyle(
                                  color: AppColor.secondColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'MANAGEMENT',
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: -15,
                  bottom: 0,
                  child: Image(
                    image:
                        AssetImage('assets/images/hand-drawn-children-back-school-background.png'),
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
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
                        'Edit Information',
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
                                hintText: "${_fullNameController.text ?? ''}",
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
                                          controller: _eventIdController,
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
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'List event',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(
                                            Colors.white,
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  999), // Set your desired border radius
                                            ),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: AppColor.secondColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'View all',
                                      style: TextStyle(
                                        color: AppColor.secondColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: TextButton(
                                        onPressed: () {
                                          // studentProvider.setViewAll(!studentProvider.viewAll);
                                          // setState(() {});
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors.white)),
                                        child:
                                            // studentProvider.viewAll
                                            //     ? Icon(
                                            //   Icons.keyboard_arrow_down_rounded,
                                            //   color: AppColor.secondColor,
                                            //   size: 20,
                                            // )
                                            //     :
                                            Icon(
                                          Icons.keyboard_arrow_up,
                                          color: AppColor.secondColor,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Fun campus',
                                        style: TextStyle(
                                          color: AppColor.secondColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '22/10/2003',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.mode_edit_outline_outlined,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
                                // final studentProvider =
                                //     Provider.of<StudentProvider>(context, listen: false);
                                // studentProvider.updateStudent(Student(
                                //     fullName: _fullNameController.text,
                                //     registeredCourses: listSubjects,
                                //     className: _classController.text,
                                //     contactInfo: ContactInfo(
                                //         id: _studentIdController.text,
                                //         address: _addressController.text,
                                //         email: _emailController.text,
                                //         phoneNumber: _phoneNumberController.text),
                                //     id: widget.student?.id ?? "",
                                //     averageScore: double.parse(_averageMarkController.text),
                                //     dateOfBirth: reverseFormatDateString(_dobController.text)));
                                // Navigator.pop(context);
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
