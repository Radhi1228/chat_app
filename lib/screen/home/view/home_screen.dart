import 'package:chatapp_firebase/utils/helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Chat'),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              ListTile(
                onTap: () async{
                  await AuthHelper.helper.signOut();
                  Get.offAllNamed('/signIn');
                },
                title: const Text("Logout you're account"),
                trailing: const Icon(Icons.logout),
              ),
              ListTile(
                onTap: () {
                  Get.offAllNamed('/profile');
                },
                title: const Text("Manage you're profile"),
                trailing: const Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 30,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.20,
              child: ListTile(
                onTap: (){},
                leading: const CircleAvatar(),
                title: const Text('Name'),
              ),
            );
          },),
    );
  }
}
