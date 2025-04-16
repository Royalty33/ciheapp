import 'package:ciheapp/view/calenderscreen/eventform.dart';
import 'package:ciheapp/model/calender_event.dart';
import 'package:ciheapp/provider/calendereventprovider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEvents();
    });
  }

  Future<void> _loadEvents() async {
    final calendarProvider = Provider.of<CalendarProvider>(context, listen: false);
    await calendarProvider.fetchEventsForMonth(_focusedDay.year, _focusedDay.month);
  }

  @override
  Widget build(BuildContext context) {
    final calendarProvider = Provider.of<CalendarProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              _loadEvents();
            },
            eventLoader: (day) => calendarProvider.events[day] ?? [],
            calendarStyle: CalendarStyle(
              markersMaxCount: 3,
              markerDecoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildEventList(calendarProvider)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEventForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventList(CalendarProvider calendarProvider) {
    final events = calendarProvider.events[_selectedDay];

    if (calendarProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (events!.isEmpty) {
      return const Center(child: Text('No events for this day'));
    }

    return ListView.builder(
      itemCount: events.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          child: ListTile(
            title: Text(event.title),
            subtitle: Text(event.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => calendarProvider.deleteEvent(event),
            ),
          ),
        );
      },
    );
  }

  void _showEventForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Event"),
          content: EventForm(selectedDay: _selectedDay!),
        );
      },
    );
  }
}
