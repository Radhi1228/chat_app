import 'package:chatapp_firebase/screen/home/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color/app_color.dart';
import '../../../utils/helper/auth_helper.dart';
import '../../../utils/helper/fire_db_helper.dart';
import '../../profile/model/profile_model.dart';
import '../controller/chat_controller.dart';
import '../model/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController txtChat = TextEditingController();
  ProfileModel model = Get.arguments;
  ChatController controller = Get.put(ChatController());
  HomeController  homeController  = Get.put(HomeController());

  @override
  void initState() {
    controller.getChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.name}"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: fav,
                child: Text(
                  model.name![0],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        actions: const [

          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.videocam_outlined,
              size: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.call),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Obx(
        () =>  Stack(
          children: [
            homeController.isTheme== true?Image.asset(
              "assets/image/chat.jpeg",
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
            ):Image.asset(
              "assets/image/lgh.png",
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: controller.dataSnap,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else if (snapshot.hasData) {
                          List<ChatModel> chatList = [];
                          QuerySnapshot? snap = snapshot.data;
                          for (var x in snap!.docs) {
                            Map m1 = x.data() as Map;
                            ChatModel c1 = ChatModel.mapToModel(m1);
                            c1.docId = x.id;
                            chatList.add(c1);
                          }
                          return ListView.builder(
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 40,
                                margin: const EdgeInsets.all(5),
                                width: 200,
                                alignment: chatList[index].senderId !=
                                        AuthHelper.helper.user!.uid
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: InkWell(
                                  onLongPress: () {
                                    if (chatList[index].senderId ==
                                        AuthHelper.helper.user!.uid) {
                                      Get.defaultDialog(
                                          title: "Chatify",
                                          middleText:
                                              "Are you sure want to delete this message?",
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("Cancel")),
                                            TextButton(
                                                onPressed: () async {
                                                  await FireDbHelper.helper
                                                      .deleteChat(
                                                          chatList[index].docId!);
                                                  Get.back();
                                                },
                                                child: const Text("Delete")),
                                          ]);
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width * 0.50,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: fav,
                                      borderRadius: chatList[index].senderId !=
                                              AuthHelper.helper.user!.uid
                                          ? const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10))
                                          : const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12,right: 12),
                                      child: Column(
                                        children: [
                                          Text("${chatList[index].msg}"),
                                          Align(
                                             alignment: Alignment.bottomRight,
                                              child: Text("${chatList[index].dateTime!.toDate().hour}:${chatList[index].dateTime!.toDate().minute}")),
                                        ],
                                      ),
                                    ),
                                  )
                                ),
                              );
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
                ),
                Card(
                  color: fav,
                  margin: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12,),
                      Expanded(
                        child: TextFormField(
                          controller: txtChat,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(wordSpacing: 1),
                            hintText: "Write message",
                          ),
                        ),
                      ),
                      const Icon(Icons.keyboard_voice),
                      IconButton(
                        onPressed: () {
                          ChatModel chatModel = ChatModel(
                              dateTime: Timestamp.now(),
                              msg: txtChat.text,
                              senderId: AuthHelper.helper.user!.uid);
                          FireDbHelper.helper.sendMessage(
                              AuthHelper.helper.user!.uid, "${model.uid}", chatModel);
                        },
                        icon: const Icon(Icons.send),
                        color: Colors.white,
                      )
                    ],
                  ),
                )

              ],
            ),
            //const SearchBar(),
          ],
        ),
      ),
    );
  }
}
