import 'package:intl/intl.dart';

class MyEventModel {
  String eventId;
  String title;
  DateTime dateTime;
  String location;
  String creatorId;
  String description;

  String get eventDate => DateFormat('yyyy-MM-dd').format(dateTime);
  String get eventTime => DateFormat('HH:mm:ss').format(dateTime);

  MyEventModel({
    required this.eventId,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.creatorId,
    required this.description,
  });

  factory MyEventModel.fromJson(Map<String, dynamic> json) {
    return MyEventModel(
      eventId: json['eventId'],
      title: json['title'],
      dateTime: DateTime.parse(json['date']),
      location: json['location'],
      creatorId: json['creatorId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'title': title,
      'date': dateTime.toIso8601String(),
      'location': location,
      'creatorId': creatorId,
      'description': description,
    };
  }
}
