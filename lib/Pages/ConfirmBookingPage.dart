import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting
import 'package:nfs_room_booking/Booking/BookingRepository.dart';
import 'package:nfs_room_booking/Users/User.dart';
import 'package:nfs_room_booking/Rooms/Room.dart';
class ConfirmBooking extends StatefulWidget {
  final User user;
  final Room room;
  const ConfirmBooking({super.key, required this.user, required this.room});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  final BookingRepository _bookingRepository = BookingRepository();
  DateTime? _selectedStartTime;
  DateTime? _selectedEndTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.blue.shade100],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.blue.shade900,
          title: const Text(
            'Confirm Booking',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Room Image
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  "https://www.corporatevision-news.com/wp-content/uploads/2020/04/7-Steps-to-Make-the-Best-Conference-Room-for-Your-Office.jpg", // Replace with actual image URL
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),

              // Room Details
              const Text(
                'Room Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),

              // Capacity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${widget.room.name}"),
                ],
              ),
              const SizedBox(height: 8.0),

              // Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Capacity:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.room.capacity}'),
                ],
              ),
              const SizedBox(height: 8.0),

              // Location
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Location:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.room.location}'),
                ],
              ),
              const SizedBox(height: 8.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Button

                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade500),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                      onPressed: () async{

                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _selectedStartTime = DateTime(
                            picked.year,
                            picked.month,
                            picked.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      }
                    }
                  }, child: const Text("Start Time")),

                  // Text

                  Text(
                    _selectedStartTime != null
                        ? DateFormat('MMMM d, y HH:mm').format(_selectedStartTime!)
                        : 'Select Start Time',
                  ),
                ],
              ),

              const SizedBox(height: 8.0),

              // End Time Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Button

                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade500),
                          foregroundColor: MaterialStateProperty.all(Colors.white)),
                      onPressed: () async{

                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (date != null) {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _selectedEndTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  }, child: const Text("End Time")),

                  // Text

                  Text(
                    _selectedEndTime != null
                        ? DateFormat('MMMM d, y HH:mm').format(_selectedEndTime!)
                        : 'Select End Time',
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Confirm Booking Button
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                ),
                onPressed: () async{

                  var isSuccessful = await _bookingRepository.addBooking(widget.user.id, widget.room.id, _selectedStartTime.toString(), _selectedEndTime.toString());

                  if (isSuccessful)
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Booking Confirmed'),
                          content: const Text('Your booking has been confirmed.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                  }
                  else
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Booking Not Confirmed'),
                          content: const Text('An Error Occurred while Processing your booking.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                },
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
