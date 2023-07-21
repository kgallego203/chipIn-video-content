import 'package:chipin_video_content/features/events/models/event_model.dart';
import 'package:chipin_video_content/features/events/views/event_details.dart';
import 'package:chipin_video_content/themes/palette.dart';
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
          color: Colors.pink[100],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              child: Image.network(
                'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
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
                          event.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      if (showJoinButton)
                        ElevatedButton(
                          onPressed: onJoinPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.primary100,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(100, 48),
                          ),
                          child: const Text('Join'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 23.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Palette.primary100,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '$formattedDate at $formattedTime',
                        style: const TextStyle(
                          color: Colors.black87,
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
                        color: Palette.primary100,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        event.location,
                        style: const TextStyle(
                          color: Colors.black87,
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
                        color: Palette.primary100,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Created by ${event.creatorId}',
                        style: const TextStyle(
                          color: Colors.black87,
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
                        color: Palette.primary100,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Flexible(
                        child: Text(
                          event.description,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
