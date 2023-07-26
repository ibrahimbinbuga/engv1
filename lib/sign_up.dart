import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';
// import 'model.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  _SignUpState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =
      new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var role = "teacher";
  var department = "";
  var grade = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        //add back button to sign in page
                        Row(
                          children: [
                           Padding(
                             padding: EdgeInsets.only(left: 5),
                             child: IconButton(
                               icon: Icon(Icons.arrow_back,size: 40,),

                               onPressed: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => SignInPage()),
                                 );
                               },
                             ),
                           )
                          ],
                        ),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: const Image(
                            image: AssetImage('assets/logo.png'),
                            height: 150,
                            width: 150,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp("[A-Za-z0-9._%+-]+@(posta\.mu\.edu\.tr|mu\.edu\.tr)")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Confirm Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (confirmpassController.text !=
                                passwordController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                 Container(
                                   height: 50,
                                    width: MediaQuery.of(context).size.width*0.6,
                                     child: DropdownButtonFormField(
                                     decoration: InputDecoration(

                                       filled: true,
                                       fillColor: Colors.white,
                                       enabled: true,
                                       contentPadding: const EdgeInsets.only(
                                           left: 8.0, bottom: 8.0, top: 8.0),
                                       focusedBorder: UnderlineInputBorder(
                                         borderSide: new BorderSide(color: Colors.black),
                                         borderRadius: new BorderRadius.circular(10),
                                       ),
                                       enabledBorder: OutlineInputBorder(
                                         borderSide: new BorderSide(color: Colors.black),
                                         borderRadius: new BorderRadius.circular(10),
                                       ),
                                     ),
                         hint: Text("Department"),
                         items:
                         [DropdownMenuItem(value: "0",child: Text("Computer E."),),
                           DropdownMenuItem(value: "1",child: Text("Software E."),),
                           DropdownMenuItem(value: "2",child: Text("Civil E."),),
                           DropdownMenuItem(value: "3",child: Text("Electrical and Electronics E."),),
                           DropdownMenuItem(value: "4",child: Text("Metallurgy and Materials E."),),
                           DropdownMenuItem(value: "5",child: Text("Geological E."),),
                           DropdownMenuItem(value: "6",child: Text("Mining E."),),
                         ], onChanged:  (value){
                       setState(() {
                         department = value.toString();
                       });}),),

                            SizedBox(
                              width: 5,
                            ),
                         Expanded(
                           child:
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabled: true,

                                  contentPadding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8.0, top: 15.0),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.black),
                                    borderRadius: new BorderRadius.circular(5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.black),
                                    borderRadius: new BorderRadius.circular(5),
                                  ),
                                ),
                                hint: Text("Grade"),
                                items: [
                                 DropdownMenuItem(value: "0",child: Text("Prep School"),
                               ),
                               DropdownMenuItem(value: "1",child: Text("1st Grade"),
                               ),
                               DropdownMenuItem(value: "2",child: Text("2nd Grade"),
                               ),
                               DropdownMenuItem(value: "3",child: Text("3rd Grade"),
                               ),
                               DropdownMenuItem(value: "4",child: Text("4th Grade"),
                               ),

                             ], onChanged: (value){
                           setState(() {
                             grade = value.toString();
                           });
                         }),)
                          ],
                        ),


                        SizedBox(
                          height: 40,
                        ),

                        Row(

                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child:   MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                if(emailController.text.contains("posta")){
                                  role = "student";
                                }
                                signUp(emailController.text,
                                    passwordController.text, role,department,grade);
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password, String role,String department,String grade) async {
    const CircularProgressIndicator();
    print("email: $email");
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, role, department, grade)})
          .catchError((e) {});
    }
  }

  postDetailsToFirestore(String email, String role,String department,String grade) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'role': role,'department':int.parse(department),'grade':int.parse(grade),'received_messages':[]});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
  }
}