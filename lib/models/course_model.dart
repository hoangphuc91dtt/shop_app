class Course {
  String id;
  String registrationStatus;
  int creditHours;
  String semester;
  List<String> registeredCourses;
  String className;
  String fullName;
  String studentId;

  Course({
    required this.id,
    required this.registrationStatus,
    required this.creditHours,
    required this.semester,
    required this.registeredCourses,
    required this.className,
    required this.fullName,
    required this.studentId,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      registrationStatus: json['registrationStatus'],
      creditHours: json['creditHours'],
      semester: json['semester'],
      registeredCourses: List<String>.from(json['registeredCourses']),
      className: json['class'],
      fullName: json['fullName'],
      studentId: json['studentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // '_id': id,
      'registrationStatus': registrationStatus,
      'creditHours': creditHours,
      'semester': semester,
      'registeredCourses': registeredCourses,
      'class': className,
      'fullName': fullName,
      'studentId': studentId,
    };
  }
}
