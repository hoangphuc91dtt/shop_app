class ContactInfo {
  String address;
  String email;
  String phoneNumber;
  String id;

  // Constructor
  ContactInfo({
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.id,
  });

  // Phương thức chuyển đổi từ JSON sang đối tượng Dart
  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}

class Student {
  ContactInfo contactInfo;
  final String id;
  final String className;
  final List<String> registeredCourses;
  final double averageScore;
  final int dateOfBirth;
  final String fullName;

  Student({
    required this.fullName,
    required this.registeredCourses,
    required this.className,
    required this.contactInfo,
    required this.id,
    required this.averageScore,
    required this.dateOfBirth,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    List<String> courses = [];
    if (json['registeredCourses'] != null) {
      courses = List<String>.from(json['registeredCourses']);
    }

    return Student(
      contactInfo: ContactInfo.fromJson(json['contactInfo'] ?? {}),
      id: json['_id'],
      averageScore: json['averageScore'],
      dateOfBirth: json['dateOfBirth'],
      fullName: json['fullName'],
      registeredCourses: courses,
      className: json['class'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'contactInfo': contactInfo.toJson(),
      'class': className,
      'registeredCourses': registeredCourses,
      'averageScore': averageScore,
      'dateOfBirth': dateOfBirth,
      'fullName': fullName,
    };
  }
}
