import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nfs_room_booking/Bookings/Booking.dart';
import 'package:nfs_room_booking/config.dart';

class BookingRepository{

  Future<bool> addBooking(String userId, String roomId, String startTime, String endTime) async
  {
    
    var response = await http.post(Uri.parse("${Config.apiUrl}/api/v1/Booking/AddBooking"),
    headers: <String, String>
    {
      'Content-Type':'application/json'
    },
    body: jsonEncode(<String, String>
    {
      'applicationUserId': userId,
      'roomId': roomId,
      'startTime': startTime,
      'endTime': endTime
    }));

    if(response.statusCode == 200)
    {
      return true;
    }
    else{ return false; }
    
    
  }

  Future<List<Booking>> getAllBookings() async
  {
    var response = await http.get(Uri.parse("${Config.apiUrl}/api/v1/Booking/GetAllBookings"));

    if (response.statusCode == 200)
    {
      final List bookingList = jsonDecode(response.body);

      return bookingList.map((e) => Booking.fromJson(e)).toList();

    }

    else
      {
        throw Exception("Unable to fetch data");
      }
    
  }

  Future<List<Booking>> getAllBookingsByUserName(String userName) async
  {
    var response = await http.get(Uri.parse("${Config.apiUrl}/api/v1/Booking/GetBookingsByUserName?userName=$userName"));

    if (response.statusCode == 200)
    {
      final List bookingList = jsonDecode(response.body);

      return bookingList.map((e) => Booking.fromJson(e)).toList();

    }

    else
    {
      throw Exception("Unable to fetch data");
    }

  }
}