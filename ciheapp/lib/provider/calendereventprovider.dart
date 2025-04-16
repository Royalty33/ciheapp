import 'package:flutter/material.dart';
import 'package:ciheapp/model/calender_event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarProvider extends ChangeNotifier {
  Map<DateTime, List<CalendarEvent>> _events = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Map<DateTime, List<CalendarEvent>> get events => _events;

  Future<void> fetchEventsForMonth(int year, int month) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://yourapi.com/events?year=$year&month=$month'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        _events = _parseEvents(data);
      } else {
        _events = {};
      }
    } catch (e) {
      _events = {};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addEvent(CalendarEvent event) async {
    final response = await http.post(
      Uri.parse('https://yourapi.com/events'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(event.toJson()),
    );

    if (response.statusCode == 201) {
      _events[event.startTime] = (_events[event.startTime] ?? [])..add(event);
      notifyListeners();
    }
  }

  Future<void> deleteEvent(CalendarEvent event) async {
    final response = await http.delete(Uri.parse('https://yourapi.com/events/${event.id}'));
    if (response.statusCode == 200) {
      _events[event.startTime]?.remove(event);
      notifyListeners();
    }
  }

  Map<DateTime, List<CalendarEvent>> _parseEvents(List<dynamic> data) {
    Map<DateTime, List<CalendarEvent>> parsedEvents = {};
    for (var item in data) {
      CalendarEvent event = CalendarEvent.fromJson(item);
      parsedEvents[event.startTime] = (parsedEvents[event.startTime] ?? [])..add(event);
    }
    return parsedEvents;
  }
}
