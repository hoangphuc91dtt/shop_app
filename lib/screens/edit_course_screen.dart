import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/layouts/header.dart';
import '../models/course_model.dart';
import '../providers/course_provider.dart';
import '../themes/colors.dart';

class CourseEditingScreen extends StatefulWidget {
  const CourseEditingScreen({super.key, required this.course});
  final Course course;

  @override
  State<CourseEditingScreen> createState() => _CourseEditingScreenState();
}

class _CourseEditingScreenState extends State<CourseEditingScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _registrationStatusController = TextEditingController();
  TextEditingController _creditHoursController = TextEditingController();
  TextEditingController _semesterController = TextEditingController();
  TextEditingController _studentController = TextEditingController();
  TextEditingController _newSubjectController = TextEditingController();
  List<String> registeredCourses = [];
  String selectedTerm = 'Term 1/2024';
  List<String> listTerm = ['Term 1/2024', 'Term 2/2024'];
  String selectedStatus = "CONFIRMED";
  List<String> listStatus = ["CONFIRMED", "PENDING", "CANCELLED"];

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.course?.fullName ?? "";
    _classController.text = widget.course?.className ?? "";
    _registrationStatusController.text = widget.course?.registrationStatus ?? "";
    _creditHoursController.text = widget.course?.creditHours.toString() ?? '0';
    _semesterController.text = widget.course?.semester ?? "";
    _studentController.text = widget.course?.studentId ?? "";
    registeredCourses = widget.course?.registeredCourses ?? [];
    selectedTerm = widget.course?.semester ?? "";
    selectedStatus = widget.course?.registrationStatus ?? "";
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi widget bị hủy
    _fullNameController.dispose();
    _classController.dispose();
    _registrationStatusController.dispose();
    _creditHoursController.dispose();
    _semesterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final couseProvider = Provider.of<CourseProvider>(context, listen: true);

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
                                hintText: "${widget.course?.fullName ?? ''}",
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
                                          controller: _studentController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: '',
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
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'School term',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20)),
                                        child: DropdownButton<String>(
                                          value: selectedTerm,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 30,
                                          isExpanded: true,
                                          items: listTerm.map((term) {
                                            return DropdownMenuItem(
                                              child: Text(term),
                                              value: term,
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            // Handle value change
                                            setState(() {
                                              selectedTerm = value ?? '';
                                            });
                                          },
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
                                        'Quantity of credits',
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
                                          controller: _creditHoursController,
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
                            SizedBox(height: 10),
                            Text(
                              'Registering status',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: DropdownButton<String>(
                                value: selectedStatus,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                isExpanded: true,
                                items: listStatus.map((status) {
                                  return DropdownMenuItem(child: Text(status), value: status);
                                }).toList(),
                                onChanged: (value) {
                                  // Handle value change
                                  setState(() {
                                    selectedStatus = value ?? '';
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'List subjects',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                            SizedBox(height: 5),
                            Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: [
                                FutureBuilder<List<String>>(
                                  future: couseProvider.getRegisteredCourses(widget.course.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      // Hiển thị một widget khi dữ liệu đang được tải
                                      return Container();
                                    } else if (snapshot.hasError) {
                                      // Hiển thị một widget khi có lỗi xảy ra
                                      return Text('Error: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      List<String> registeredCourses = snapshot.data!;
                                      List<Widget> buttons = registeredCourses.map((courseName) {
                                        return Container(
                                          child: TextButton(
                                            onPressed: () {
                                              // Xử lý sự kiện khi nút được nhấn
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(Colors.white),
                                            ),
                                            child: Text(courseName),
                                          ),
                                        );
                                      }).toList();
                                      buttons.add(Container(
                                        child: TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Add more subjects'),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(20),
                                                        bottomLeft: Radius.circular(20)),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        if (_newSubjectController.text.trim() !=
                                                            "") {
                                                          registeredCourses
                                                              .add(_newSubjectController.text);
                                                          setState(() {});
                                                          Navigator.pop(context);
                                                        }
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all(
                                                            Colors.amberAccent),
                                                      ),
                                                      child: Text(
                                                        'Save',
                                                        style: TextStyle(
                                                          color: AppColor.primaryColor,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                          color: AppColor.primaryColor,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  content: TextField(
                                                    controller: _newSubjectController,
                                                    decoration: InputDecoration(
                                                      hintText: "new subject ...",
                                                      fillColor: Colors.black12,
                                                      filled: true,
                                                      contentPadding: EdgeInsets.symmetric(
                                                          vertical: 1.0, horizontal: 10.0),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.black12,
                                                        ),
                                                        borderRadius: BorderRadius.circular(15.0),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.black12,
                                                        ),
                                                        borderRadius: BorderRadius.circular(15.0),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors.white),
                                            shape: MaterialStateProperty.all(
                                              CircleBorder(),
                                            ),
                                          ),
                                          child: Icon(Icons.add),
                                        ),
                                      ));

                                      // Hiển thị danh sách các nút
                                      return Wrap(
                                        spacing: 5.0,
                                        runSpacing: 5.0,
                                        children: buttons,
                                      );
                                    } else {
                                      // Hiển thị một widget mặc định khi không có dữ liệu
                                      return Text('No registered courses');
                                    }
                                  },
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
                              onPressed: () async {
                                try {
                                  print("chaubui00");
                                  await couseProvider.updateCourse(Course(
                                    id: widget.course!.id,
                                    registrationStatus: _registrationStatusController.text,
                                    creditHours: int.tryParse(_creditHoursController.text) ?? 0,
                                    semester: selectedTerm,
                                    registeredCourses: registeredCourses,
                                    className: _classController.text,
                                    fullName: _fullNameController.text,
                                    studentId: widget.course!.studentId,
                                  ));
                                  Navigator.pop(context);
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Please check values"),
                                      );
                                    },
                                  );
                                }
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
