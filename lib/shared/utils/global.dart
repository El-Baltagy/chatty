import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user_model.dart';


FirebaseAuth fAuth=FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage firestorage = FirebaseStorage.instance;


UserModel? user;
User? currentFirebaseUser;

class AgoraConfig {
  static String token = '';
  static String appId = '01254a6c76514e4787628f4b6bdc1786';
  static String appcertificate = 'd4cafc0cc7d3466d9b51b9d604d971ff';
  static String baseUrl = 'https://whatsapp-clone-rrr.herokuapp.com';
}