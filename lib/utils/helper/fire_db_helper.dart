import 'package:chatapp_firebase/screen/profile/model/profile_model.dart';
import 'package:chatapp_firebase/utils/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //insert,Update (UserData)

  void setProfile(ProfileModel profileModel) async {
    await firestore.collection("User").doc(AuthHelper.helper.user!.uid).set({
      "name": profileModel.name,
      "mobile": profileModel.mobile,
      "email": profileModel.email,
      "bio": profileModel.bio,
    });
  }
}
