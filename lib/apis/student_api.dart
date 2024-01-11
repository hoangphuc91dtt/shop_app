import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/student_model.dart';

class StudentApi {
  final String baseUrl = "https://traning.izisoft.io/v1";

  Future<List<Student>> fetAllStudents() async {
    final uri = Uri.parse("$baseUrl/students");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Student> students = List.from(json.decode(response.body).map((studentJson) {
        return Student.fromJson(studentJson);
      }));
      return students;
    } else {
      throw Exception('Failed to load student');
    }
  }

  Future<List<Student>> getStudents(int limit) async {
    print("fffffffff");
    final uri = Uri.parse("$baseUrl/students/paginate?limit=$limit");
    final response = await http.get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Kiểm tra xem trường 'results' có tồn tại không
      if (responseData.containsKey('results')) {
        List<Student> students = List.from(responseData['results'].map((studentJson) {
          return Student.fromJson(studentJson);
        }));
        return students;
      } else {
        throw Exception('Field "results" not found in response');
      }
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<Student> addStudent(Student student) async {
    print("=_____________");
    print(student.toJson());
    final uri = Uri.parse("$baseUrl/students");
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(student.toJson()),
    );

    print(response.statusCode);

    if (response.statusCode == 201) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add student');
    }
  }

  Future<void> updateStudent(Student updatedStudent) async {
    print(updatedStudent.toJson());
    final uri = Uri.parse("$baseUrl/students/${updatedStudent.id}");
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedStudent.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    }
  }

  Future<void> deleteStudent(String studentId) async {
    final uri = Uri.parse("$baseUrl/students/$studentId");
    final response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete student');
    }
  }
}
