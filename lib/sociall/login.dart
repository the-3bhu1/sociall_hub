import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_hub/sociall/dash.dart';
import 'package:social_hub/sociall/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController  emailEditingController = TextEditingController();
  TextEditingController  passwordEditingController = TextEditingController();

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
              Image(image: const AssetImage('assets/images/logo.png'), width: width * 1.5, height: height * 0.35,),
              SizedBox(height: height * 0.03,),
              SizedBox(
                height: height * 0.06,
                child: TextFormField(
                  controller: emailEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
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
                    signIn();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      side: const BorderSide(color: Colors.black, width: 2),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black
                  ),
                  child: Text('Login', style: TextStyle(fontSize: width * 0.07),),
                ),
              ),
              SizedBox(height: height * 0.07,),
              GestureDetector(
                onTap:(){ Get.to(() => const RegisterPage());},
                  child: Text('Not a member? Click here to Register', style: TextStyle(color: Colors.blue, fontSize: width * 0.03),)
              )
            ],
          ),
        ),
      ),
    );
  }
}