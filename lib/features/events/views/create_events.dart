import 'package:chipin_video_content/features/authentication/services/auth_service.dart';
import 'package:chipin_video_content/features/events/models/event_model.dart';
import 'package:chipin_video_content/features/events/services/event_service.dart';
import 'package:flutter/material.dart';

class EventCreationScreen extends StatefulWidget {
  final EventService eventService;

  const EventCreationScreen({required this.eventService});

  @override
  State<EventCreationScreen> createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  late final String _id = '';
  late String _title;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  late String _location;
  late String _description;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      DateTime dateTime = DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      );

      MyEventModel newEvent = MyEventModel(
        eventId: _id,
        title: _title,
        dateTime: dateTime,
        location: _location,
        description: _description,
        creatorId: await AuthService.getCreatorId(),
      );

      bool success = await widget.eventService.createEvent(newEvent);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event created successfully!'),
          ),
        );

        setState(() {
          _title = '';
          _date = DateTime.now();
          _time = TimeOfDay.now();
          _location = '';
          _description = '';
        });

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create event.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a location' : null,
              onSaved: (value) => _location = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
              onSaved: (value) => _description = value!,
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Date'),
              subtitle: Text(
                '${_date.year}-${_date.month}-${_date.day}',
              ),
              onTap: _selectDate,
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Time'),
              subtitle: Text(
                _time.format(context),
              ),
              onTap: _selectTime,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
