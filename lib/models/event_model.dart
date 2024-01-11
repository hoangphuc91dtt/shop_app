class Event {
  final String id;
  final String eventFeedback;
  final List<String> attendedEvents;
  final String attendanceStatus;
  final int eventDate;
  final String fullName;
  final String className;
  final String studentId;

  Event({
    required this.fullName,
    required this.attendanceStatus,
    required this.className,
    required this.attendedEvents,
    required this.id,
    required this.eventDate,
    required this.eventFeedback,
    required this.studentId,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    List<String> attendedEvents = [];
    if (json['attendedEvents'] != null) {
      attendedEvents = List<String>.from(json['attendedEvents']);
    }

    return Event(
      id: json['_id'],
      eventFeedback: json['eventFeedback'] ?? '',
      attendedEvents: attendedEvents,
      attendanceStatus: json['attendanceStatus'] ?? "",
      eventDate: json['eventDate'],
      fullName: json['fullName'] ?? "",
      className: json['class'] ?? "",
      studentId: json['studentId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventFeedback': eventFeedback,
      'attendedEvents': attendedEvents,
      'attendanceStatus': attendanceStatus,
      'eventDate': eventDate,
      'fullName': fullName,
      'className': className,
      'StudentId': studentId,
    };
  }
}
