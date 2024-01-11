import 'package:flutter/cupertino.dart';
import '../apis/course_api.dart'; // Import the appropriate course API
import '../models/course_model.dart'; // Import the appropriate course model

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];
  List<Course> _originalCourses = [];
  bool viewAll = false;

  List<Course> get courses => _courses;

  void setViewAll(bool value) {
    viewAll = value;
    if (value) {
      fetchAllCoursesFromApi();
    } else {
      fetchAllCoursesFromApiByLimit(10);
    }
    notifyListeners();
  }

  Future<List<String>> getRegisteredCourses(String id) async {
    // Tìm khóa học trong _originalCourses dựa trên id
    final course = _originalCourses.firstWhere((course) => course.id == id);

    // Trả về danh sách registeredCourses của khóa học tìm thấy
    return course.registeredCourses;
  }

  Future<void> fetchAllCoursesFromApi() async {
    try {
      final apiCourses =
          await CourseApi().fetchAllCourses(); // Use the appropriate method from the course API
      _courses = apiCourses;
      _originalCourses = List.from(apiCourses);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching courses: $error');
    }
  }

  Future<void> addCourse(Course course) async {
    try {
      final addedCourse =
          await CourseApi().addCourse(course); // Use the appropriate method from the course API
      _courses.add(addedCourse);
      _originalCourses = _courses;
      notifyListeners();
    } catch (error) {
      throw Exception('Error adding course: $error');
    }
  }

  Future<void> updateCourse(Course updatedCourse) async {
    try {
      await CourseApi()
          .updateCourse(updatedCourse); // Use the appropriate method from the course API
      final index = _courses.indexWhere((course) => course.id == updatedCourse.id);
      if (index != -1) {
        _courses[index] = updatedCourse;
        _originalCourses = _courses;
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Error updating course: $error');
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      await CourseApi().deleteCourse(courseId); // Use the appropriate method from the course API
      _courses.removeWhere((course) => course.id == courseId);
      notifyListeners();
    } catch (error) {
      throw Exception('Error deleting course: $error');
    }
  }

  Future<void> fetchAllCoursesFromApiByLimit(int limit) async {
    try {
      final apiCourses =
          await CourseApi().getCourses(limit); // Use the appropriate method from the course API
      _courses = apiCourses;
      _originalCourses = List.from(apiCourses);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching courses: $error');
    }
  }

  void searchCoursesByName(String searchQuery) {
    if (searchQuery.isEmpty) {
      // If the search query is empty, restore the original course list
      _courses = List.from(_originalCourses);
    } else {
      // If there is a search query, filter the list by course name
      _courses = _originalCourses
          .where((course) => course.fullName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
