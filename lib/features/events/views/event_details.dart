import 'package:chipin_video_content/features/authentication/services/auth_service.dart';
import 'package:chipin_video_content/features/events/models/attendee_model.dart';
import 'package:chipin_video_content/features/events/models/event_model.dart';
import 'package:chipin_video_content/features/events/services/event_service.dart';
import 'package:chipin_video_content/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  final MyEventModel event;
  const EventDetailsScreen({required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  List<MyEventModel> allEvents = [];
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
    fetchAllEvents();
  }

  Future<void> getCurrentUserId() async {
    currentUserId = await AuthService.getCreatorId();
  }

  Future<void> fetchAllEvents() async {
    try {
      List<MyEventModel> events = await EventService.getAllEvents();
      setState(() {
        allEvents = events;
      });
    } catch (error) {
      print('Failed to get all events: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d, y');
    final timeFormat = DateFormat('h:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event Details',
          style: TextStyle(
            color: Palette.neutral10,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      widget.event.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      joinEvent(widget.event);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.primary100,
                    ),
                    child: const Text(
                      'Join Event',
                      style: TextStyle(
                        color: Palette.neutral0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                border: TableBorder.symmetric(
                  inside: BorderSide.none,
                  outside: BorderSide.none,
                ),
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
              Center(
                child: Image.network(
                  'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TableRow _buildTableRow(String label, String value, IconData icon) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Palette.primary100,
            ),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: const TextStyle(
                color: Palette.primary100,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
            color: Palette.neutral70,
            fontSize: 15.0,
          ),
        ),
      ),
    ],
  );
}
