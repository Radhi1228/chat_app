import 'package:chatapp_firebase/screen/home/controller/home_controller.dart';
import 'package:chatapp_firebase/screen/login/controller/profile_controller.dart';
import 'package:chatapp_firebase/screen/profile/model/profile_model.dart';
import 'package:chatapp_firebase/utils/helper/fire_db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  ProfileController controller = Get.put(ProfileController());
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  void getProfileData() async {
    await controller.getSignInData();
    if (controller.profileModel != null) {
      txtMobile.text = controller.profileModel!.mobile!;
      txtName.text = controller.profileModel!.name!;
      txtEmail.text = controller.profileModel!.email!;
      txtBio.text = controller.profileModel!.bio!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fromKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Profile'),
        ),
        body: Stack(
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mobile is required";
                        }
                        return null;
                      },
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
                    // style: ButtonStyle(
                    //     backgroundColor: homeController.isTheme.value == true
                    //         ? Color(0xff03346E)
                    //         : Color(0xff03346E)),
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        FireDbHelper.helper.setProfile(
                          ProfileModel(
                              name: txtName.text,
                              email: txtEmail.text,
                              bio: txtBio.text,
                              mobile: txtMobile.text),
                        );
                        Get.offAllNamed('/home');
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}
