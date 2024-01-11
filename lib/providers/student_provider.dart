import 'package:flutter/cupertino.dart';
import '../apis/student_api.dart';
import '../models/student_model.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];
  List<Student> _originalStudents = [];
  bool viewAll = false;
  Map<String, bool> activeSubjects = {
    'Lịch sử đảng': false,
    'Giải tích 2': true,
    'Reactjs': false,
    'Nodejs': false,
  };

  List<Student> get students => _students;

  void setViewAll(bool value) {
    viewAll = value;
    if (value) {
      fetchAllStudentsFromApi();
    } else {
      fetchAllStudentsFromApiByLimit(10);
    }
    notifyListeners();
  }

  void setActiveSubject(String subject, bool value) {
    activeSubjects[subject] = value;
    print(activeSubjects);
  }

  Future<void> fetchAllStudentsFromApi() async {
    try {
      final apiStudents = await StudentApi().fetAllStudents();
      _students = apiStudents;
      _originalStudents = List.from(apiStudents);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching students: $error');
    }
  }

  Future<void> addStudent(Student student) async {
    print(student.toJson());
    try {
      final addedStudent = await StudentApi().addStudent(student);
      print("=======");
      _students.add(addedStudent);
      notifyListeners();
    } catch (error) {
      throw Exception('Error adding student: $error');
    }
  }

  Future<void> updateStudent(Student updatedStudent) async {
    try {
      await StudentApi().updateStudent(updatedStudent);
      final index = _students.indexWhere((student) => student.id == updatedStudent.id);
      if (index != -1) {
        _students[index] = updatedStudent;
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Error updating student: $error');
    }
  }

  Future<void> deleteStudent(String studentId) async {
    try {
      await StudentApi().deleteStudent(studentId);
      _students.removeWhere((student) => student.id == studentId);
      notifyListeners();
    } catch (error) {
      throw Exception('Error deleting student: $error');
    }
  }

  Future<void> fetchAllStudentsFromApiByLimit(int limit) async {
    try {
      print("---------------------");
      final apiStudents = await StudentApi().getStudents(limit);
      print(apiStudents);
      print("==============");
      _students = apiStudents;
      _originalStudents = List.from(apiStudents);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching students: $error');
    }
  }

  void searchStudentsByName(String searchQuery) {
    if (searchQuery.isEmpty) {
      // Nếu truy vấn tìm kiếm rỗng, khôi phục danh sách gốc
      _students = List.from(_originalStudents);
    } else {
      // Nếu có truy vấn tìm kiếm, lọc danh sách theo tên
      _students = _originalStudents
          .where((student) => student.fullName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
