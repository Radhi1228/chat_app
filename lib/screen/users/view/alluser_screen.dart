import 'package:chatapp_firebase/screen/home/controller/home_controller.dart';
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
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    controller.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Users'),
      ),
      body: Obx(
        () => Stack(
          children: [
            homeController.isTheme == true
                ? Image.asset(
                    "assets/image/chat.jpeg",
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/image/lgh.png",
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.cover,
                  ),
            ListView.builder(
              itemCount: controller.profileList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await FireDbHelper.helper.getChatDoc(
                        AuthHelper.helper.user!.uid,
                        controller.profileList[index].uid!);
                    Get.toNamed('/chat',
                        arguments: controller.profileList[index]);
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
          ],
        ),
      ),
    );
  }
}
