import 'package:flutter/material.dart';
import 'package:nfs_room_booking/Components/RoomsListView.dart';
import 'package:nfs_room_booking/Pages/AddRoomsPage.dart';
import 'package:nfs_room_booking/Pages/BookingsPage.dart';
import 'package:nfs_room_booking/Rooms/Room.dart';
import 'package:nfs_room_booking/Rooms/RoomRepository.dart';
import 'package:nfs_room_booking/Users/User.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  RoomRepository roomRepository = RoomRepository();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue.shade50, Colors.blue.shade100], begin: Alignment.centerLeft, end: Alignment.centerRight)
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text("Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),),
                backgroundColor: Colors.blue.shade900,
                centerTitle: true,
              ),
              drawer: NavigationDrawer(
                children: [
                  // Header

                  Container(
                    color: Colors.blue.shade900,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),

                          //Image

                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://belmontperiodontist.com/wp-content/uploads/AdobeStock_219702545.jpeg"),
                          ),

                          const SizedBox(height: 7,),

                          // Name

                          Text("${widget.user.firstName} ${widget.user.lastName}", style: const TextStyle(color: Colors.white),),

                          const SizedBox(height: 7,),

                          //Email

                          Text(widget.user.email, style: const TextStyle(color: Colors.white),),

                          const SizedBox(height: 17,),
                        ],
                      ),
                    ),
                  ),


                  // Items

                  //Home
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.blue.shade900,),
                    title: Text("Home", style: TextStyle(color: Colors.blue.shade900),),
                    onTap: ()
                    {
                      Navigator.of(context).pop();

                    },
                  ),

                  //Add Room
                  ListTile(
                    leading: Icon(Icons.add, color: Colors.blue.shade900,),
                    title: Text("Add Room", style: TextStyle(color: Colors.blue.shade900),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddRoomsPage()));

                    },
                  ),

                  //Check Bookings
                  ListTile(
                    leading: Icon(Icons.search, color: Colors.blue.shade900,),
                    title: Text("Check Bookings", style: TextStyle(color: Colors.blue.shade900),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ViewBooking()));

                    },
                  ),

                  //Divider
                  Row(
                    children: [
                      Expanded(child: Divider(
                        thickness: 1,
                        color: Colors.blue.shade900,
                      ))
                    ],
                  ),

                  // Log out
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.blue.shade900,),
                    title: Text("Logout", style: TextStyle(color: Colors.blue.shade900),),
                    onTap: ()
                    {

                    },
                  ),

                ],
              ),



              //Body Starts from here

              body: FutureBuilder<List<Room>>(
                future: roomRepository.getAllRooms(),
                builder: (context, snapshot)
                {
                  if (snapshot.connectionState == ConnectionState.waiting)
                  {
                    return const CircularProgressIndicator();
                  }
                  else if (snapshot.hasData)
                  {
                    final rooms = snapshot.data;
                    return RoomsListView(rooms: rooms!, user: widget.user, );
                  }
                  else
                  {
                    return const Text("No Room Available");
                  }

                },
              )
              


            ),
          ),
        ));
  }
}
