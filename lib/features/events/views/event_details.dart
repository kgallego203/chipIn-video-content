import 'package:chipin_video_content/features/authentication/services/auth_service.dart';
import 'package:chipin_video_content/features/events/models/attendee_model.dart';
import 'package:chipin_video_content/features/events/models/event_model.dart';
import 'package:chipin_video_content/features/events/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  final MyEventModel event;
  const EventDetailsScreen({required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String currentUserId = '';

  Future<void> joinEvent(MyEventModel event) async {
    AttendeesModel myAttendeeModel = AttendeesModel(
      eventId: event.eventId,
      userId: currentUserId,
    );
    bool result = await EventService.joinEvent(myAttendeeModel);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully joined event!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
  }

  Future<void> getCurrentUserId() async {
    currentUserId = await AuthService.getCreatorId();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d, y');
    final timeFormat = DateFormat('h:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.event.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16.0),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              border: TableBorder.all(),
              children: [
                _buildTableRow(
                  'Date',
                  dateFormat.format(widget.event.dateTime),
                  Icons.calendar_today,
                ),
                _buildTableRow(
                  'Time',
                  timeFormat.format(widget.event.dateTime),
                  Icons.access_time,
                ),
                _buildTableRow(
                  'Location',
                  widget.event.location,
                  Icons.location_on,
                ),
                _buildTableRow(
                  'Description',
                  widget.event.description,
                  Icons.description,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Image.network(
              'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80',
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => joinEvent(widget.event),
              child: const Text('Join Event'),
            ),
          ],
        ),
      ),
    );
  }
}

TableRow _buildTableRow(String label, String value, IconData icon) {
  return TableRow(
    children: [
      TableCell(
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8.0),
            Text(label),
          ],
        ),
      ),
      TableCell(
        child: Text(value),
      ),
    ],
  );
}
