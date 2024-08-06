import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print("Kullanıcı Oluşturuldu: ${userCredential.user?.email}");
  } on FirebaseAuthException catch (e) {
    print("HATA: ${e.message}");
  }
}

Future<void> addUser(String username, String email, String password) async {
  try {
    // Kullanıcıyı oluşturun
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Kullanıcı ID'sini alın
    final userId = userCredential.user!.uid;

    // Kullanıcı verilerini Firestore'a ekleyin
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'name': username, 'email': email})
        .then((value) => print("Kullanıcı Eklendi"))
        .catchError((error) => print("Kullanıcı eklenirken hata: $error"));
  } on FirebaseAuthException catch (e) {
    print("HATA: ${e.message}");
  }
}
