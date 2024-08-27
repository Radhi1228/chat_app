import 'package:chatapp_firebase/screen/profile/model/profile_model.dart';
import 'package:chatapp_firebase/utils/helper/fire_db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtBio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Profile'),
      ),
      body: Center(
        child: Card(
          child: Column(
            children: [
              // ListTile(
              //   onTap: (){},
              //   leading: const CircleAvatar(radius: 30),
              //   title: const Text('Name',style: TextStyle(fontSize: 20,),),
              //   subtitle: const Text('Bio',style: TextStyle(fontSize: 16),),
              // ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: CircleAvatar(radius: 50),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: txtName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: txtEmail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: txtMobile,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: txtBio,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bio',
                    prefixIcon: Icon(Icons.text_snippet),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  FireDbHelper.helper.setProfile(ProfileModel(
                      name: txtName.text,
                      email: txtEmail.text,
                      bio: txtBio.text,
                      mobile: txtMobile.text));
                  Get.offAllNamed('/home');
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
