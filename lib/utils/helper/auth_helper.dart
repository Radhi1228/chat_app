import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper
{
  static AuthHelper helper = AuthHelper._();
  AuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  Future<String> signUpWithEmailPassword(String email, String password) async
  {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created Successfully";
    }on FirebaseAuthException catch(e)
    {
      return e.message ?? "Failed";
    }
  }

  Future<String> signInWithEmailPassword(String email, String password) async
  {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "SignIn Successfully";
    }on FirebaseAuthException catch(e)
    {
      return e.message ?? "Login failed try again";
    }
  }
  bool checkUser()
  {
    user = auth.currentUser;
    return user != null;
  }

  Future<void> signOut()
  async {
    await auth.signOut();
  }

  Future<String> signInWithGoogle()
  async {
    GoogleSignInAccount? signInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication authentication = await signInAccount!.authentication;
    var cred = GoogleAuthProvider.credential(idToken: authentication.idToken,accessToken:authentication.accessToken );

    UserCredential userCrd = await auth.signInWithCredential(cred);
    user = userCrd.user;
    if(user != null)
      {
       return "SignIn Successfully";
      }
    else
      {
        return "Login failed try again";
      }
  }


}