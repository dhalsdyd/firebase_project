import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
;

class AuthService extends GetxService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _firebaseUser = Rx(null);
  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    _firebaseUser.value = _auth.currentUser;
    super.onInit();
  }

  Future<void> loginWithGoogle() async {
    Map result = await GoogleSignInHelper().authenticate();
    try {
      await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: result['idToken'],
          accessToken: result['accessToken'],
        ),
      );
    } catch (e) {
    }
  }
}