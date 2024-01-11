import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/course_provider.dart';
import 'package:untitled/providers/event_provider.dart';
import 'package:untitled/providers/student_provider.dart';
import 'package:untitled/router/router.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CourseProvider(),
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: routes,
      ),
    );
  }
}
