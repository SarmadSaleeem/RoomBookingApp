import 'dart:convert';
import 'Room.dart';
import 'package:http/http.dart' as http;
import 'package:nfs_room_booking/config.dart';

class RoomRepository{

  Future<Room> getRoomById(String id) async
  {
    final response = await http.get(Uri.parse("${Config.apiUrl}https://localhost:7256/api/v1/Room/GetById?id=$id"));

    if(response.statusCode == 200)
    {
      return Room.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    else{ throw Exception("Something went wrong"); }
  }

  Future<bool> addRoom(String roomName, String roomCapacity, String roomLocation) async
  {
    try
    {
      final response = await http.post(Uri.parse("${Config.apiUrl}/api/v1/Room/Add"),
          headers: <String, String>
          {
            'Content-Type':'application/json'
          },

          body: jsonEncode(<String, String>
          {
            'name' : roomName,
            'capacity' : roomCapacity,
            'location' : roomLocation,
            'image'    : ""
          })
      );

      if (response.statusCode == 200)
      {
        return true;
      }
      else{ return false; }

    }
    catch (e)
    {
      return false;
    }
  }
  
  Future<List<Room>> getAllRooms() async
  {
    final response = await http.get(Uri.parse("${Config.apiUrl}/api/v1/Room/GetAll"));

    if(response.statusCode == 200)
    {
      final List responseBody = jsonDecode(response.body);
      return responseBody.map((e) => Room.fromJson(e)).toList();
    }
    else
    {
     throw Exception("Unable to get the Rooms");
    }
    
  }

}