import 'package:chipin_video_content/features/authentication/services/auth_service.dart';
import 'package:chipin_video_content/features/events/models/event_model.dart';
import 'package:chipin_video_content/features/events/services/event_service.dart';
import 'package:chipin_video_content/features/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

class MyCreatedEventsScreen extends StatefulWidget {
  final EventService eventService;

  const MyCreatedEventsScreen({required this.eventService});

  @override
  State<MyCreatedEventsScreen> createState() => _MyCreatedEventsScreenState();
}

class _MyCreatedEventsScreenState extends State<MyCreatedEventsScreen> {
  List<MyEventModel> myCreatedEvents = [];
  bool loading = true;

  @override
  void initState() {
    fetchMyCreatedEvents();
    super.initState();
  }

  Future<void> fetchMyCreatedEvents() async {
    try {
      String userId = await AuthService.getCreatorId();
      List<MyEventModel> events =
          await widget.eventService.getMyCreatedEvents(userId);
      setState(() {
        myCreatedEvents = events;
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (myCreatedEvents.isEmpty) {
      return const Center(
        child: Text('You do not have events created'),
      );
    } else {
      return ListView.builder(
        itemCount: myCreatedEvents.length,
        itemBuilder: (context, index) {
          MyEventModel event = myCreatedEvents[index];
          return EventCard(event: event, showJoinButton: false);
        },
      );
    }
  }
}
