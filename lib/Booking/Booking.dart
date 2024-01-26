import 'package:nfs_room_booking/Users/User.dart';
import 'package:nfs_room_booking/Rooms/Room.dart';

class Booking{

  final String id;
  final User user;
  final Room room;
  final String startTime;
  final String endTime;

  Booking({required this.id, required this.room, required this.user, required this.startTime, required this.endTime});

  factory Booking.fromJson(Map<String, dynamic> json)
  {
    return Booking(id: json['id'], startTime: json['startTime'], endTime: json['endTime'], room: Room.fromJson(json['room']), user: User.fromJson(json['userProfile']));
  }


}