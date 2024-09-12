import 'package:chatapp_firebase/screen/home/controller/home_controller.dart';
import 'package:chatapp_firebase/utils/color/app_color.dart';
import 'package:chatapp_firebase/utils/helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Stack(
          children: [
            // Obx(() =>
            //   homeController.isTheme== true?Image.asset(
            //     "assets/image/chat.jpeg",
            //     height: MediaQuery.sizeOf(context).height,
            //     width: MediaQuery.sizeOf(context).width,
            //     fit: BoxFit.cover,
            //   ):Image.asset(
            //     "assets/image/lgh.png",
            //     height: MediaQuery.sizeOf(context).height,
            //     width: MediaQuery.sizeOf(context).width,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Chatify',
                  style: TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold, color: fav),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign In to your account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid data";
                    } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  controller: txtEmail,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  controller: txtPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(

                  onPressed: () async {
                    if (formKey.currentState!.validate())
                    {
                      String msg = await AuthHelper.helper
                          .signInWithEmailPassword(txtEmail.text, txtPassword.text);
                      if (msg == "SignIn Successfully") {
                        AuthHelper.helper.checkUser();
                        Get.offAndToNamed('/profile');
                        Get.snackbar('Login Successful', 'Chatify');
                      } else {
                        Get.snackbar(msg, 'Login failed try again');
                      }
                    }
                  },
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    String msg = await AuthHelper.helper.signInWithGoogle();
                    if (msg == "SignIn Successfully") {
                      AuthHelper.helper.checkUser();
                      Get.offAndToNamed('/profile');
                      Get.snackbar('Login Successful', 'Chatify');
                    } else {
                      Get.snackbar(msg, 'Login failed try again');
                    }
                  },
                  child: Card(
                    child: Image.asset(
                      'assets/image/b1.png',
                      width: 230,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/signUp');
                  },
                  child: const Text("Don't have an account? Sign Up"),
                )
              ],
            ),
          ),],

        ),
      ),
    );
  }
}
