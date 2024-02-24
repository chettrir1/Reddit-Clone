import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/failure.dart';
import 'package:reddit_clone/core/providers/firebase_provider.dart';
import 'package:reddit_clone/core/type_defs.dart';
import 'package:reddit_clone/models/user_model.dart';

final authRepositoryProvider = Provider((ref) =>
    AuthRepository(
      firestore: ref.read(firestoreProvider),
      auth: ref.read(authProvider),
      googleSignIn: ref.read(
        googleSignInProvider,
      ),
    ));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;


  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })
      : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      UserModel model;
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        model = UserModel(
          name: userCredential.user?.displayName ?? "N/A",
          profilePic:
          userCredential.user?.photoURL ?? AssetsConstants.avatarDefault,
          banner: AssetsConstants.avatarDefault,
          uid: userCredential.user?.uid ?? "",
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );
        await _users.doc(model.uid).set(model.toMap());
      } else {
        model = await getUserData(userCredential.user?.uid ?? "").first;
      }
      return right(model);
    } on FirebaseException catch (e) {
      throw e.message ?? "Something went wrong!";
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
            (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
