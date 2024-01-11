import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventApi {
  final String baseUrl = "https://traning.izisoft.io/v1";

  Future<List<Event>> fetchAllEvents() async {
    final uri = Uri.parse("$baseUrl/student-events");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Event> events = List.from(json.decode(response.body).map((eventJson) {
        return Event.fromJson(eventJson);
      }));

      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<List<Event>> getEvents(int limit) async {
    print('alo$limit');
    final uri = Uri.parse("$baseUrl/student-events/paginate?limit=$limit");
    final response = await http.get(uri);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Kiểm tra xem trường 'results' có tồn tại không
      if (responseData.containsKey('results')) {
        List<Event> events = List.from(responseData['results'].map((eventJson) {
          return Event.fromJson(eventJson);
        }));
        return events;
      } else {
        throw Exception('Field "results" not found in response');
      }
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<Event> addEvent(Event event) async {
    final uri = Uri.parse("$baseUrl/student-events");
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(event.toJson()),
    );

    if (response.statusCode == 201) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add event');
    }
  }

  Future<void> updateEvent(Event updatedEvent) async {
    print(updatedEvent.toJson());
    final uri = Uri.parse("$baseUrl/student-events/${updatedEvent.id}");
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedEvent.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update event');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    final uri = Uri.parse("$baseUrl/student-events/$eventId");
    final response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete event');
    }
  }
}
