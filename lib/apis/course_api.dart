import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../models/course_model.dart';

class CourseApi {
  final String baseUrl = "https://traning.izisoft.io/v1";

  Future<List<Course>> fetchAllCourses() async {
    final uri = Uri.parse("$baseUrl/course-registrations");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Course> courses = List.from(json.decode(response.body).map((courseJson) {
        return Course.fromJson(courseJson);
      }));
      return courses;
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<List<Course>> getCourses(int limit) async {
    final uri = Uri.parse("$baseUrl/course-registrations/paginate?limit=$limit");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('results')) {
        List<Course> courses = List.from(responseData['results'].map((courseJson) {
          return Course.fromJson(courseJson);
        }));
        return courses;
      } else {
        throw Exception('Field "results" not found in response');
      }
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Course> addCourse(Course course) async {
    final uri = Uri.parse("$baseUrl/course-registrations");
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(course.toJson()),
    );
    if (response.statusCode == 201) {
      return Course.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add course');
    }
  }

  Future<void> updateCourse(Course updatedCourse) async {
    final uri = Uri.parse("$baseUrl/course-registrations/${updatedCourse.id}");
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedCourse.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update course');
    }
  }

  Future<void> deleteCourse(String courseId) async {
    final uri = Uri.parse("$baseUrl/course-registrations/$courseId");
    final response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete course');
    }
  }
}
