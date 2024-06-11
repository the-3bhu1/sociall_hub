import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dash.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  void signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text,
      );
      Get.to(() => const DashScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An unknown error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            children: [
              SizedBox(height: height * 0.02,),
              Image(image: const AssetImage('assets/images/logo.png'),
                width: width * 1.5,
                height: height * 0.35,),
              SizedBox(height: height * 0.03,),
              SizedBox(
                height: height * 0.06,
                child: TextFormField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)),
                    hintText: 'Username',
                  ),
                ),
              ),
              SizedBox(height: height * 0.02,),
              SizedBox(
                height: height * 0.06,
                child: TextFormField(
                  controller: emailEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)),
                    hintText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: height * 0.02,),
              SizedBox(
                height: height * 0.06,
                child: TextFormField(
                  controller: passwordEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)),
                    hintText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: height * 0.05,),
              SizedBox(
                width: double.infinity,
                height: height * 0.08,
                child: ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      side: const BorderSide(color: Colors.black, width: 2),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black
                  ),
                  child: Text(
                    'Register', style: TextStyle(fontSize: width * 0.07),),
                ),
              ),
              SizedBox(height: height * 0.07,),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                  child: Text('Already a member? Click here to Login',
                    style: TextStyle(
                        color: Colors.blue, fontSize: width * 0.03),)
              )
            ],
          ),
        ),
      ),
    );
  }
}