import 'package:chatapp_firebase/screen/users/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color/app_color.dart';
import '../../../utils/helper/auth_helper.dart';
import '../../../utils/helper/fire_db_helper.dart';

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
      body: Obx(
        () => ListView.builder(
          itemCount: controller.profileList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await FireDbHelper.helper.getChatDoc(
                    AuthHelper.helper.user!.uid,
                    controller.profileList[index].uid!);
                Get.toNamed('/chat', arguments: controller.profileList[index]);
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: fav,
                  child: Text(controller.profileList[index].name![0]),
                ),
                title: Text('${controller.profileList[index].name}'),
                subtitle: Text('${controller.profileList[index].mobile}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
