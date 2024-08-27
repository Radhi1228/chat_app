import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color/app_color.dart';
import '../../../utils/helper/auth_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Chatify',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: fav),),
            const SizedBox(height: 20),
            const Text('Sign Up to your account',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            const SizedBox(height: 30),
            TextFormField(
              controller: txtEmail,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail)
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: txtPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () async {
              String msg = await AuthHelper.helper.signUpWithEmailPassword(txtEmail.text, txtPassword.text);
              if(msg == "Account Created Successfully")
              {
                Get.back();
                Get.snackbar('Account created Successfully', 'Chatify');
              }
              else
              {
                Get.snackbar(msg, 'Login failed');
              }
            },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20),
            TextButton(onPressed: (){
              Get.back();
            }, child: const Text("Already have an account? Sign In"),)
          ],
        ),
      ),
    );
  }
}
