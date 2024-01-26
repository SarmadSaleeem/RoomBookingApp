import 'package:flutter/material.dart';
import 'package:nfs_room_booking/Pages/ConfirmBookingPage.dart';
import 'package:nfs_room_booking/Rooms/Room.dart';
import 'package:nfs_room_booking/Users/User.dart';


class RoomsListView extends StatefulWidget {
  final List<Room> rooms;
  final User user;
  const RoomsListView({Key? key, required this.rooms, required this.user}) : super(key: key);

  @override
  State<RoomsListView> createState() => _RoomsListViewState();
}

class _RoomsListViewState extends State<RoomsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.rooms.length,
      itemBuilder: (context, index)
      {
        final room = widget.rooms[index];
        return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 4,
            clipBehavior: Clip.antiAlias, // Clip the contents of the card to its bounds
            child: Row(
              children: [
                // Image container
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.network(
                    "https://www.corporatevision-news.com/wp-content/uploads/2020/04/7-Steps-to-Make-the-Best-Conference-Room-for-Your-Office.jpg",
                    fit: BoxFit.cover, // Cover the area without stretching
                  ),
                ),
                // Text and button container
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // To wrap the content in the column
                      children: [
                        Text(
                          room.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Capacity: ${room.capacity}"),
                        Text("Location: ${room.location}"),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmBooking(room: widget.rooms[index], user: widget.user,)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text('Book Room'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
