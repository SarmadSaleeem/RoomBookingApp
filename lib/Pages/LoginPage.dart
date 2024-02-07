import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfs_room_booking/Components/customButton.dart';
import 'package:nfs_room_booking/Components/customFields.dart';
import 'package:nfs_room_booking/Pages/HomePage.dart';
import 'package:nfs_room_booking/Pages/SignUpPage.dart';
import 'package:nfs_room_booking/Users/User.dart';
import 'package:nfs_room_booking/Users/userRepository.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final UserRepository _userRepository = UserRepository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Container(
        //Page decoration
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade50, Colors.blue.shade100], begin: Alignment.centerLeft, end: Alignment.centerRight)
        ),

        //Scaffold
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [

                    const SizedBox(height: 140,),

                    //Icon

                    Icon(
                      Icons.lock,
                      size: 100,
                      color: Colors.blue.shade900,
                    ),

                    const SizedBox(height: 20),

                    //login text

                     Align(
                       alignment: Alignment.centerLeft,
                       child: Container(
                         padding: const EdgeInsets.only(left: 40.0),
                         child: Text("Sign in"
                           ,style: GoogleFonts.roboto(
                               color: Colors.blue.shade900,
                               letterSpacing: 1,
                               fontSize: 17,
                               fontWeight: FontWeight.bold
                           ),),
                       ),
                     ),

                    const SizedBox(height: 20.0),

                    //Email Input Field

                    CustomInputField(key: const ValueKey("EmailInputField"), controller: emailController, labelText: "Email", iconData: Icons.email_outlined, validator: (value) {

                      final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

                      if (value == null || value.isEmpty ){
                        return "Email is Required";
                      }
                      else if(!emailRegex.hasMatch(value)){

                        return "Invalid email address";
                    }
                      return null;

                    },),

                    const SizedBox(height: 20.0),

                    // Password Input Field

                    CustomInputField(key: const ValueKey<String>("PasswordInputField"), controller: passwordController, labelText: "Password",

                      iconData: Icons.password,
                      isPassword: true,
                      validator: (value)
                      {
                      if (value == null || value.isEmpty){
                        return "Password is Required";
                      }
                      else{
                        return null;
                      }
                    },),

                    // Forget Password

                    const SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forgot Password?",
                          style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),

                    // Sign In button

                    const SizedBox(height: 15),


                    CustomButton(
                      widgetKey: ValueKey<String>("LoginButton"),
                      onTap: () async
                      {
                        if (_formkey.currentState != null && _formkey.currentState!.validate())
                        {
                           User? userDetials = await _userRepository.signInUser(emailController.text, passwordController.text);

                           if (userDetials != null)
                           {
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful"), key: ValueKey("Login Success"),));
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(user : userDetials)));
                           }
                           else
                             {
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Email or Password"), key: ValueKey("Invalid"),));
                             }
                        }
                      },

                      buttonText: "Sign in", textColor: Colors.white,
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

                    CustomButton(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                      },

                      buttonText: "Create an account", textColor: Colors.blue.shade900, border: Border.all(
                        color: Colors.blue.shade900,
                        width: 2
                    ),),

                    const SizedBox(height: 20,)



                  ],
                ),
              ),
            ),
          )
        ),
      ),
    );
  }

}



