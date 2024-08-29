import 'package:chatapp_firebase/screen/users/controller/user_controller.dart';
import 'package:chatapp_firebase/users/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    controller.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Obx(() => ListView.builder(
          itemCount: controller.profileList.length,
          itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(controller.profileList[index].name![0]),
            ),
            title: Text('${controller.profileList[index].name}'),
            subtitle: Text('${controller.profileList[index].mobile}'),
          );
        },),
      ),
    );
  }
}
