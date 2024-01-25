import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nfs_room_booking/Users/User.dart';
import 'package:nfs_room_booking/config.dart';

class UserRepository{

  Future<User?> signInUser(String email, String password) async{

    try
    {
      final response = await http.post(Uri.parse("${Config.apiUrl}/login"),

          headers:<String,String>
          {
            'Content-Type':'application/json'
          },

          body: jsonEncode(<String,String>{
            "email" : email,
            "password" :  password,
          }));

      if (response.statusCode == 200)
      {

        Map<String, dynamic> responseMap = jsonDecode(response.body);
        String accessToken = responseMap['accessToken'];
        String refreshToken = responseMap['refreshToken'];

        // Calling function to get User details
        User userDetails = await getUserDetailsByEmail(email);
        return userDetails;
      }
      else
      {
        return null;
      }

    }

    catch (e)
    {
      return null;
    }

  }
  
  Future<User>? getUserDetailsById() async
  {

    String apiUrl = "${Config.apiUrl}/api/v1/User/GetUserProfileById";

    final response = await http.get(Uri.parse(apiUrl));

    if(response.statusCode ==200)
    {

      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    }
    else
    {
      throw Exception("Failed to get User Details");

    }

  }

  Future<bool> createUser(String firstName, String lastName, String email, String password) async
  {
    try
    {
      const apiUrl = "https://10.0.2.2:7256/api/v1/User/CreateUser";

      final response = await http.post(Uri.parse(apiUrl),
          headers:<String, String>
          {
            'Content-Type':'application/json'
          },

          body: jsonEncode(<String, String>
          {
            'email' : email,
            'firstName' : firstName,
            'lastName' : lastName,
            'password' : password
          })
      );

      if(response.statusCode == 200)
      {
        return true;
      }
      else
      {
        return false;
      }

    }
    catch (e)
    {
      return false;
    }

  }

  Future<User> getUserDetailsByEmail(String email) async
  {
    var url = Uri.parse("${Config.apiUrl}/api/v1/User/GetUserProfileByEmail?email=$email");

    final response = await http.get(url);

    if (response.statusCode == 200)
    {

      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    }
    else
    {
      throw Exception("Failed to Fetch User Details");
    }
  }
  
}