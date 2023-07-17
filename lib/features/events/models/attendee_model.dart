class AttendeesModel {
  String userId;
  String eventId;

  AttendeesModel({
    required this.userId,
    required this.eventId,
  });

  AttendeesModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        eventId = json['eventId'];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'eventId': eventId,
    };
  }
}
