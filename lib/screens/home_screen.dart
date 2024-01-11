import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/layouts/header.dart';
import 'package:untitled/screens/course_registration_sceen.dart';
import 'package:untitled/screens/create_student_if_screen.dart';
import 'package:untitled/widgets/course_list_widget.dart';
import 'package:untitled/widgets/event_list_widget.dart';
import 'package:untitled/widgets/student_list_widget.dart';
import '../providers/student_provider.dart';
import '../themes/colors.dart';
import '../widgets/button_nav_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isActiveBtn = 0;
  late List<ButtonNav> listButtonNav;

  void setActiveButton(id) {
    setState(() {
      isActiveBtn = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    listButtonNav = [
      ButtonNav(name: 'Students', isActive: isActiveBtn == 0, onPressed: () => setActiveButton(0)),
      ButtonNav(name: 'Subject', isActive: isActiveBtn == 1, onPressed: () => setActiveButton(1)),
      ButtonNav(
          name: 'Evaluation', isActive: isActiveBtn == 2, onPressed: () => setActiveButton(2)),
      ButtonNav(name: 'Event', isActive: isActiveBtn == 3, onPressed: () => setActiveButton(3)),
    ];
    List<Widget> listChooses = [
      Expanded(
        child: StudentList(),
      ),
      Expanded(
        child: CourseList(),
      ),
      Text(
        'Đang phát triển...',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      Expanded(
        child: EventList(),
      ),
    ];
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Header(),
          SizedBox(
            height: 25,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var buttonNav in listButtonNav) ...[
                  buttonNav,
                  SizedBox(
                    width: 10,
                  )
                ],
              ],
            ),
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
                    'List students',
                    style: TextStyle(
                      color: AppColor.titleColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: TextButton(
                      onPressed: () {
                        if (isActiveBtn == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateStudentInfoScreen(),
                              ));
                        } else if (isActiveBtn == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseRegistrationScreen(),
                              ));
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(999), // Set your desired border radius
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
                    style: TextStyle(color: AppColor.secondColor),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: TextButton(
                      onPressed: () {
                        studentProvider.setViewAll(!studentProvider.viewAll);
                        setState(() {});
                      },
                      child: studentProvider.viewAll
                          ? Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColor.secondColor,
                              size: 20,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColor.secondColor,
                              size: 20,
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
          listChooses[isActiveBtn]
        ],
      ),
    );
  }
}
