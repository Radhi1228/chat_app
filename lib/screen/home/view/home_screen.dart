import 'package:chatapp_firebase/screen/login/controller/profile_controller.dart';
import 'package:chatapp_firebase/utils/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/fire_db_helper.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileController controller = Get.put(ProfileController());
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    homeController.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatify'),
        actions: [],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Get.offAllNamed('/profile');
                },
                title: const Text("Manage you're profile"),
                trailing: const Icon(Icons.account_circle),
              ),
              ListTile(
                onTap: () async{
                  await AuthHelper.helper.signOut();
                  Get.offAllNamed('/signIn');
                },
                title: const Text("Logout you're account"),
                trailing: const Icon(Icons.logout),
              ),

            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: homeController.chatUsers,
        builder: (context, snapshot)  {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            homeController.userList.clear();
            QuerySnapshot? qs = snapshot.data;

            List<QueryDocumentSnapshot> qsList = qs!.docs;

            for (var x in qsList) {
              Map m1 = x.data() as Map;
              List uidList = m1['uids'];
              String receiverID = "";
              if (uidList[0] == AuthHelper.helper.user!.uid) {
                receiverID = uidList[1];
              } else {
                receiverID = uidList[0];
              }

              //getUserData receiver User UID
              homeController.getUIDUsers(receiverID).then((value) {
                homeController.userList.add(homeController.model!);
              },);
            }

            return Obx(
                  () => ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      await FireDbHelper.helper.getChatDoc(AuthHelper.helper.user!.uid, homeController.userList[index].uid!);
                      Get.toNamed('/chat',arguments: homeController.userList[index]);
                    },
                    leading: CircleAvatar(
                      child: Text("${homeController.userList[index].name![0]}"),
                    ),
                    title:  Text("${homeController.userList[index].name}"),
                    subtitle: Text("${homeController.userList[index].mobile}"),
                  );
                },
                itemCount: homeController.userList.length,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Get.toNamed('/user');
      },child: const Icon(Icons.person),),
    );
  }
}
