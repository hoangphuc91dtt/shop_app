import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/course_provider.dart';
import 'package:untitled/providers/event_provider.dart';
import 'package:untitled/screens/placeholder_screen.dart';
import 'package:untitled/themes/colors.dart';
import '../providers/student_provider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final keyword = _searchController.text;
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    studentProvider.searchStudentsByName(keyword);
    eventProvider.searchEventByName(keyword);
    courseProvider.searchCoursesByName(keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF3F4F6),
                          filled: true,
                          hintText: 'Enter keyword to find output',
                          suffixIcon: Icon(
                            Icons.search,
                            color: AppColor.secondColor,
                            size: 40,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffF3F4F6),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffF3F4F6),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.only(left: 70),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PlaceHolderScreen();
                          },
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0), // Đặt border radius
                          ),
                        ),
                      ),
                      child: Image(
                        image: AssetImage('assets/images/icons8-customize-30.png'),
                        width: 30,
                        height: 30,
                        color: AppColor.secondColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: -15,
          bottom: 0,
          child: Image(
            image: AssetImage('assets/images/hand-drawn-children-back-school-background.png'),
            height: 150,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
