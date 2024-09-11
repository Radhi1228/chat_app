import 'package:chatapp_firebase/screen/login/controller/profile_controller.dart';
import 'package:chatapp_firebase/utils/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color/app_color.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chatify'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.search),
          ),
          // PopupMenuButton(
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       child: IconButton(
          //         onPressed: () {
          //           homeController.setThemeData();
          //         },
          //         icon: Icon(
          //           homeController.isTheme == false
          //               ? Icons.light_mode
          //               : Icons.dark_mode,
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: fav,
                      radius: 45,
                      child: Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 08,
                    ),
                    Column(
                      children: [
                        Text(
                          "Radhi Rakhasiya",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text("+91 8160473626"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 0.5,
                  child: ListTile(
                    onTap: () {
                      Get.offAllNamed('/profile');
                    },
                    title: const Text("Manage you're profile"),
                    leading: const Icon(Icons.account_circle),
                  ),
                ),
                Card(
                  elevation: 0.5,
                  child: ListTile(
                    onTap: (){
                      Get.offAllNamed('/signUp');
                    },
                    title: const Text("Add Account"),
                    leading: const Icon(Icons.add),
                  ),
                ),
                const Card(
                  elevation: 0.5,
                  child: ListTile(

                    title: Text("New Group"),
                    //trailing: const Icon(Icons.group),
                    leading: Icon(Icons.group),
                  ),
                ),
                Card(
                  elevation: 0.5,
                  child: ListTile(
                    onTap: (){
                      Get.offAllNamed('/user');
                    },
                    title: const Text("you're Contacts"),
                    leading: const Icon(Icons.contact_page),
                  ),
                ),
                const Card(
                  elevation: 0.5,
                  child: ListTile(
                    title: Text("Calls"),
                    leading: Icon(Icons.call),
                  ),
                ),
                const Card(
                  elevation: 0.5,
                  child: ListTile(
                    title: Text("Peoples Nearby"),
                    leading: Icon(Icons.near_me_outlined),
                  ),
                ),
                const Card(
                  elevation: 0.5,
                  child: ListTile(
                    title: Text("Saved Messages"),
                    leading: Icon(Icons.bookmark),
                  ),
                ),
                const Card(
                  elevation: 0.5,
                  child: ListTile(
                    title: Text("Setting"),
                    leading: Icon(Icons.settings),
                  ),
                ),
                const Card(
                  elevation: 0.5,
                  child: ListTile(
                    title: Text("Invite Friends"),
                    leading: Icon(Icons.person_add),
                  ),
                ),
                 Card(
                  elevation: 0.5,
                  child: ListTile(
                    onTap: (){
                      homeController.setThemeData();
                    },
                    title: const Text("Theme"),
                    leading: const Icon(Icons.invert_colors_sharp),
                  ),
                ),
                const Card(
                  elevation: 0.5,
                  child: ListTile(
                    title: Text("Chatify Features"),
                    leading: Icon(Icons.more_outlined),
                  ),
                ),
                Card(
                  elevation: 0.5,
                  child: ListTile(
                    onTap: () async {
                      await AuthHelper.helper.signOut();
                      Get.offAllNamed('/signIn');
                    },
                    title: const Text("Logout you're account"),
                    leading: const Icon(Icons.logout),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: homeController.chatUsers,
        builder: (context, snapshot) {
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
              homeController.getUIDUsers(receiverID).then(
                (value) {
                  homeController.userList.add(homeController.model!);
                },
              );
            }

            return Obx(
              () =>
                  // Column(
                  //   children: [
                  //     GridView.builder(
                  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 2),
                  //       itemBuilder: (context, index) {
                  //         return Container();
                  //       },
                  //     ),
              //     Stack(children: [
              //   Image.asset(
              //     "assets/image/image.jpg",
              //     height: MediaQuery.sizeOf(context).height,
              //     width: MediaQuery.sizeOf(context).width,
              //   ),
              //
              // ]),
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      await FireDbHelper.helper.getChatDoc(
                          AuthHelper.helper.user!.uid,
                          homeController.userList[index].uid!);
                      Get.toNamed('/chat',
                          arguments: homeController.userList[index]);
                    },
                    leading: CircleAvatar(
                      backgroundColor: fav,
                      child:
                      Text("${homeController.userList[index].name![0]}"),
                    ),
                    title: Text("${homeController.userList[index].name}"),
                    subtitle:
                    Text("${homeController.userList[index].mobile}"),
                  );
                },
                itemCount: homeController.userList.length,
              )
              //],),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: fav,
        onPressed: () {
          Get.toNamed('/user');
        },
        child: const Icon(Icons.person),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(icon: Icon(Icons.change_circle_rounded)),
      //     BottomNavigationBarItem(icon: Icon(Icons.call)),
      //     BottomNavigationBarItem(icon: Icon(Icons.star_border)),
      //   ],
      // ),
    );
  }
}
