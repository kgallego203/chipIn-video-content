import 'package:chipin_video_content/features/authentication/services/auth_service.dart';
import 'package:chipin_video_content/features/events/models/attendee_model.dart';
import 'package:chipin_video_content/features/events/models/event_model.dart';
import 'package:chipin_video_content/features/events/services/event_service.dart';
import 'package:chipin_video_content/features/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

class JoinEventsScreen extends StatefulWidget {
  final EventService eventService;

  const JoinEventsScreen({required this.eventService});

  @override
  State<JoinEventsScreen> createState() => _JoinEventsScreenState();
}

class _JoinEventsScreenState extends State<JoinEventsScreen> {
  List<MyEventModel> allEvents = [];
  String currentUserId = '';

  Future<void> joinEvent(MyEventModel event) async {
    AttendeesModel myAttendeeModel = AttendeesModel(
      userId: currentUserId,
      eventId: event.eventId,
    );
    bool result = await EventService.joinEvent(myAttendeeModel);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully joined event!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to join event. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    fetchAllEvents();
    getCurrentUserId();
    super.initState();
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
      print('Failed to fetch all events.');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (allEvents.isEmpty) {
      return const Center(
        child: Text('No events to join'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Join Events'),
        ),
        body: ListView.builder(
          itemCount: allEvents.length,
          itemBuilder: (context, index) {
            MyEventModel event = allEvents[index];
            bool showJoinButton = event.creatorId != currentUserId;
            return EventCard(
              event: event,
              showJoinButton: showJoinButton,
              onJoinPressed: () => joinEvent(event),
            );
          },
        ),
      );
    }
  }
}
