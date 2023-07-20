import 'package:chipin_video_content/features/events/models/event_model.dart';
import 'package:chipin_video_content/features/events/views/event_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final MyEventModel event;
  final bool showJoinButton;
  final VoidCallback? onJoinPressed;

  const EventCard({
    required this.event,
    this.showJoinButton = false,
    this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE, MMM d, y').format(event.dateTime);
    final formattedTime = DateFormat('h:mm a').format(event.dateTime);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 23.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '$formattedDate at $formattedTime',
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        event.location,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Created by ${event.creatorId}',
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.description,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        event.description,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (showJoinButton)
              ElevatedButton(
                onPressed: onJoinPressed,
                child: const Text('Join'),
              ),
          ],
        ),
      ),
    );
  }
}
