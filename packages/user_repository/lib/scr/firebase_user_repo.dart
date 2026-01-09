import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Thêm dòng này
import 'package:user_repository/scr/user_repo.dart'; // Đảm bảo đúng đường dẫn file chứa abstract class

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  // Sửa lỗi cú pháp constructor ở đây
  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  
  @override
  // Phải chỉ định rõ kiểu Stream<MyUser?> theo interface
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      // Logic biến đổi firebaseUser thành MyUser sẽ ở đây
      return null; // Tạm thời để null
    });
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
  
  @override
  Future<void> setUserData(MyUser user) { // Thêm kiểu MyUser
    return usersCollection.doc(user.userId).set(user.toEntity().toDocument());
  }
  
  @override
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  
  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    // Logic tạo user ở đây
    throw UnimplementedError();
  }
}