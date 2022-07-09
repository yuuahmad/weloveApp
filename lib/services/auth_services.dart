import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth;
  AuthServices(this._firebaseAuth);

  Stream<User?> get keadaanAuthberubah => _firebaseAuth.authStateChanges();

  Future<void> keluar() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> masuk({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "berhasil masuk";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> daftar({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "berhasil daftar";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}