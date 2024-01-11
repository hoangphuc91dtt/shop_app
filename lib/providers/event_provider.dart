import 'package:flutter/cupertino.dart';
import '../apis/event_api.dart';
import '../models/event_model.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [];
  List<Event> _originalEvents = [];
  bool viewAll = false;
  Map<String, List<Map<String, dynamic>>> groupedEvents = {};

  List<Event> get events => _events;

  void setViewAll(bool value) {
    viewAll = value;
    if (value) {
      fetchAllEventsFromApi();
    } else {
      fetchAllEventsFromApiByLimit(10);
    }
    notifyListeners();
  }

  Future<void> fetchAllEventsFromApi() async {
    try {
      final apiEvents = await EventApi().fetchAllEvents();
      _events = apiEvents;
      _originalEvents = List.from(apiEvents);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching events: $error');
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      final addedEvent = await EventApi().addEvent(event);
      _events.add(addedEvent);
      notifyListeners();
    } catch (error) {
      throw Exception('Error adding event: $error');
    }
  }

  Future<void> updateEvent(Event updatedEvent) async {
    try {
      await EventApi().updateEvent(updatedEvent);
      final index = _events.indexWhere((event) => event.id == updatedEvent.id);
      if (index != -1) {
        _events[index] = updatedEvent;
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Error updating event: $error');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await EventApi().deleteEvent(eventId);
      _events.removeWhere((event) => event.id == eventId);
      notifyListeners();
    } catch (error) {
      throw Exception('Error deleting event: $error');
    }
  }

  Future<void> fetchAllEventsFromApiByLimit(int limit) async {
    print("===fffffffffffffffffffffffffff");
    try {
      final apiEvents = await EventApi().getEvents(limit);
      print("fdsaf$apiEvents");
      _events = apiEvents;
      _originalEvents = List.from(apiEvents);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching events: $error');
    }
  }

  void searchEventsByName(String searchQuery) {
    if (searchQuery.isEmpty) {
      // Nếu truy vấn tìm kiếm rỗng, khôi phục danh sách gốc
      _events = List.from(_originalEvents);
    } else {
      // Nếu có truy vấn tìm kiếm, lọc danh sách theo tên
      _events = _originalEvents
          .where((event) => event.fullName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchEventByName(String searchQuery) {
    if (searchQuery.isEmpty) {
      // Nếu truy vấn tìm kiếm rỗng, khôi phục danh sách gốc
      _events = List.from(_originalEvents);
    } else {
      // Nếu có truy vấn tìm kiếm, lọc danh sách theo tên
      _events = _originalEvents
          .where((event) => event.fullName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> groupEvents() async {
    final apiEvents = await EventApi().fetchAllEvents();
  }
}
