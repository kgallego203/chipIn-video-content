import 'package:chipin_video_content/features/authentication/services/auth_service.dart';
import 'package:chipin_video_content/features/events/models/event_model.dart';
import 'package:chipin_video_content/features/events/services/event_service.dart';
import 'package:chipin_video_content/themes/palette.dart';
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
            content: Text(
              'Event created successfully!',
              style: TextStyle(color: Palette.success100),
            ),
            backgroundColor: Palette.success10,
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
            content: Text(
              'Failed to create event.',
              style: TextStyle(color: Palette.warning100),
            ),
            backgroundColor: Palette.warning10,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Event',
          style: TextStyle(color: Palette.neutral0),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Palette.neutral70),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.primary100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.neutral50),
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
              onSaved: (value) => _title = value!,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Location',
                labelStyle: TextStyle(color: Palette.neutral70),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.primary100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.neutral50),
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a location' : null,
              onSaved: (value) => _location = value!,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Palette.neutral70),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.primary100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.neutral50),
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
              onSaved: (value) => _description = value!,
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Palette.neutral70,
              ),
              title: const Text(
                'Date',
                style: TextStyle(color: Palette.neutral70),
              ),
              subtitle: Text(
                '${_date.year}-${_date.month}-${_date.day}',
                style: const TextStyle(color: Palette.neutral100),
              ),
              onTap: _selectDate,
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(
                Icons.access_time,
                color: Palette.neutral70,
              ),
              title: const Text(
                'Time',
                style: TextStyle(color: Palette.neutral100),
              ),
              subtitle: Text(
                _time.format(context),
                style: const TextStyle(color: Palette.neutral100),
              ),
              onTap: _selectTime,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.primary100,
              ),
              child: const Text(
                'Create Event',
                style: TextStyle(color: Palette.neutral0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
