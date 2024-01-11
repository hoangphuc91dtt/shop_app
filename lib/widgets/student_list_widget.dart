import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/student_provider.dart';
import 'package:untitled/screens/edit_student_screen.dart';
import '../models/student_model.dart';
import '../themes/colors.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  void initState() {
    super.initState();
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    studentProvider.fetchAllStudentsFromApiByLimit(10);
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    Future<void> _handleRefresh() async {
      await studentProvider.fetchAllStudentsFromApi();
    }

    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      height: 100,
      backgroundColor: Colors.white,
      color: AppColor.primaryColor,
      child: ListView.builder(
        itemCount: studentProvider.students.length,
        itemBuilder: (context, index) {
          final student = studentProvider.students[index];
          return StudentRow(student: student);
        },
      ),
    );
  }
}

class StudentRow extends StatelessWidget {
  final Student student; // Declare student as a final field

  // Use named constructor to initialize student
  const StudentRow({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    color: Color(0xffF3F4F6),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                        top: 10,
                        bottom: 10,
                        right: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${student.fullName}",
                                  style: TextStyle(
                                    color: AppColor.titleColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("${student.className}- ${student.contactInfo.email}"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentEditingScreen(student: student),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.edit_note),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actionsPadding:
                                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                          actionsAlignment: MainAxisAlignment.spaceBetween,
                                          title: Text(
                                            'Are you sure to delete this student?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                          actions: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  // color: AppColor.primaryColor,
                                                  // borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                              child: TextButton(
                                                onPressed: () async {
                                                  final studentProvider =
                                                      Provider.of<StudentProvider>(context,
                                                          listen: false);
                                                  await studentProvider.deleteStudent(student.id);
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor: AppColor.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: AppColor.primaryColor,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: AppColor.primaryColor,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: AppColor.primaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.delete),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Positioned(
              left: 2,
              top: 20,
              child: Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${student.averageScore}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
