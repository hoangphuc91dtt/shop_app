import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/providers/course_provider.dart';
import 'package:untitled/providers/student_provider.dart';
import 'package:untitled/screens/edit_student_screen.dart';
import '../models/student_model.dart';
import '../screens/edit_course_screen.dart';
import '../themes/colors.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  void initState() {
    super.initState();
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    courseProvider.fetchAllCoursesFromApiByLimit(10);
  }

  @override
  Widget build(BuildContext context) {
    final couseProvider = Provider.of<CourseProvider>(context);
    Future<void> _handleRefresh() async {
      await couseProvider.fetchAllCoursesFromApiByLimit(10);
    }

    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      height: 100,
      backgroundColor: Colors.white,
      color: AppColor.primaryColor,
      child: ListView.builder(
        itemCount: couseProvider.courses.length,
        itemBuilder: (context, index) {
          final course = couseProvider.courses[index];
          print("chaaaaaaaaaaaaa");
          print(course.toJson());
          return CourseRow(course: course);
        },
      ),
    );
  }
}

class CourseRow extends StatelessWidget {
  final Course course; // Declare student as a final field

  // Use named constructor to initialize student
  const CourseRow({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("cccccccccccccccccccccc${course.toJson()}");
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
                                  "${course.fullName}",
                                  style: TextStyle(
                                    color: AppColor.titleColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("${course.className}- ${course.studentId}"),
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
                                        builder: (context) => CourseEditingScreen(course: course),
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
                                                  final courseProvider =
                                                      Provider.of<CourseProvider>(context,
                                                          listen: false);
                                                  await courseProvider.deleteCourse(course.id);
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
                      "${course.creditHours}",
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
