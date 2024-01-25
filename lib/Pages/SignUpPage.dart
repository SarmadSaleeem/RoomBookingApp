import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfs_room_booking/Components/customButton.dart';
import 'package:nfs_room_booking/Components/customFields.dart';
import 'package:nfs_room_booking/Pages/HomePage.dart';
import 'package:nfs_room_booking/Pages/LoginPage.dart';
import 'package:nfs_room_booking/Users/User.dart';
import 'package:nfs_room_booking/Users/userRepository.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}
class SignUpState extends State<SignUp> {

  final UserRepository _userRepository = UserRepository();

  final _formkey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Container(

        //Background Setup
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue.shade50, Colors.blue.shade100], begin: Alignment.centerLeft, end: Alignment.centerRight)
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,

          //Body

          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [

                    const SizedBox(height: 50,),

                    //Logo

                    Icon(
                      Icons.app_registration,
                      color: Colors.blue.shade900,
                      size: 100,
                    ),

                    const SizedBox(height: 10,),

                    //Sign Up text

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text("Create an account"
                          ,style: GoogleFonts.roboto(
                              color: Colors.blue.shade900,
                              letterSpacing: 1,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),

                    const SizedBox(height: 10,),

                    // FirstName Input Field


                    CustomInputField(controller: firstNameController, labelText: "FirstName", iconData: Icons.abc, validator: (value){

                      if (value == null || value.isEmpty){
                        return "FirstName is required";
                      }

                      else {
                        return null;
                      }

                    },),

                    const SizedBox(height: 15,),

                    // LastName

                    CustomInputField(controller: lastNameController, labelText: "LastName", iconData: Icons.abc , validator: (value){

                      if (value == null || value.isEmpty){
                        return "LastName is required";
                      }

                      else {
                        return null;
                      }

                    },),

                    const SizedBox(height: 15,),

                    // Email

                    CustomInputField(controller: emailController, labelText: "Email", iconData: Icons.email_outlined, validator: (value){

                      final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

                      if (value == null || value.isEmpty ){
                        return "Email is Required";
                      }
                      else if(!emailRegex.hasMatch(value)){

                        return "Invalid email address";
                      }
                      return null;

                    },),

                    const SizedBox(height: 15,),

                    // Password

                    CustomInputField(controller: passwordController, labelText: "Password", isPassword: true, iconData: Icons.password, validator: (value){

                      if (value == null || value.isEmpty){
                        return "Password is required";
                      }

                      else {
                        return null;
                      }

                    },),

                    const SizedBox(height: 15,),

                    //Confirm Password

                    CustomInputField(controller: confirmPasswordController, labelText: "Confirm Password", isPassword: true, iconData: Icons.password, validator: (value){

                      if (value == null || value.isEmpty){
                        return "Password is required";
                      }

                      else if(passwordController.text != value){
                        return "Password not match";
                      }

                      else {
                        return null;
                      }

                    },),

                    const SizedBox(height: 25,),

                    // Sign up

                    CustomButton(
                      onTap: () async
                      {
                        if(_formkey.currentState != null && _formkey.currentState!.validate())
                        {

                          User user = (await _userRepository.createUser(firstNameController.text, lastNameController.text, emailController.text, passwordController.text)) as User;

                          if (user != null)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(user: user,)));
                          }
                          else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong unable to create user")));

                          }
                        }

                      },
                      buttonText: "Sign up", textColor: Colors.white,
                      gradient: LinearGradient(colors: [Colors.blue.shade700, Colors.blue.shade900],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),),

                    // Divider

                    const SizedBox(height: 40),

                    Row(
                      children: [
                        Expanded(child: Divider(
                          thickness: 2,
                          color: Colors.blue.shade900,
                        )),

                        Text("       OR       ", style: TextStyle(color: Colors.blue.shade900, letterSpacing: 2, fontSize: 15),),

                        Expanded(child: Divider(
                          thickness: 2,
                          color: Colors.blue.shade900,
                        ))
                      ],
                    ),

                    const SizedBox(height: 40),

                    //Button for Sign in page

                    CustomButton(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));

                      },
                      buttonText: "Already have an account", textColor: Colors.blue.shade900, border: Border.all(
                      color: Colors.blue.shade900,
                      width: 2
                    ),),

                    const SizedBox(height: 40,),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


