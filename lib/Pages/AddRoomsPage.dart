import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfs_room_booking/Components/customButton.dart';
import 'package:nfs_room_booking/Components/customFields.dart';
import 'package:nfs_room_booking/Rooms/RoomRepository.dart';
class AddRoomsPage extends StatefulWidget {
  const AddRoomsPage({super.key});

  @override
  State<AddRoomsPage> createState() => _AddRoomsPageState();
}

class _AddRoomsPageState extends State<AddRoomsPage> {

  final RoomRepository _roomRepository = RoomRepository();

  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final capacityController = TextEditingController();
  final locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade50, Colors.blue.shade100], begin: Alignment.centerLeft, end: Alignment.centerRight)
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              backgroundColor: Colors.blue.shade900,
              title: const Text("Add Room", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),),
            ),

            body: SingleChildScrollView(
              child: Center(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [

                        const SizedBox(height: 100,),


                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.only(left: 25),
                              child: Text("Add Room Details", style: GoogleFonts.saira(color: Colors.blue.shade900, fontWeight: FontWeight.bold, fontSize: 23),)),
                        ),



                        const SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                                child: Image.network("https://www.corporatevision-news.com/wp-content/uploads/2020/04/7-Steps-to-Make-the-Best-Conference-Room-for-Your-Office.jpg"))),

                        const SizedBox(height: 25,),

                        CustomInputField(labelText: "Name", iconData: Icons.abc, controller: nameController, validator: (value)
                        {
                          if(value == null || value.isEmpty)
                          {
                            return "Required";
                          }
                          else{ return null; }

                        },),

                        const SizedBox(height: 10,),

                        CustomInputField(labelText: "Capacity", iconData: Icons.group_add_outlined, controller: capacityController, validator: (value)
                        {
                          if(value == null || value.isEmpty)
                          {
                            return "Required";
                          }
                          else{ return null; }

                        }),

                        const SizedBox(height: 10,),

                        CustomInputField(labelText: "Location", iconData: Icons.maps_home_work_outlined, controller: locationController, validator: (value)
                        {
                          if(value == null || value.isEmpty)
                          {
                            return "Required";
                          }
                          else{ return null; }

                        }),

                        const SizedBox(height: 10,),

                        CustomButton(gradient: LinearGradient(
                            colors: [Colors.blue.shade700, Colors.blue.shade900],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                            buttonText: "Create Room",
                            textColor: Colors.white,
                            onTap: () async
                            {
                              if (_formkey.currentState!=null && _formkey.currentState!.validate())
                              {
                                bool isSuccessful = await _roomRepository.addRoom(nameController.text, capacityController.text, locationController.text);
                                
                                if (isSuccessful)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Room Created")));
                                }
                                else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error Occurred")));
                                }

                              }

                            }
                        ),

                        const SizedBox(height: 30,),



                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
