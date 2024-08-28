import 'package:chatapp_firebase/screen/profile/model/profile_model.dart';
import 'package:chatapp_firebase/utils/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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

  Future<ProfileModel?> getSignInProfile()
  async {
    DocumentSnapshot documentData = await firestore.collection('User').doc(AuthHelper.helper.user!.uid).get();
    if(documentData.exists)
      {
        Map m1 = documentData.data() as Map;
        ProfileModel model = ProfileModel.mapToModel(m1);
        return model;
      }
    else
      {
        return null;
      }
  }
}
