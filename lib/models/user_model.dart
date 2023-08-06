//
//
// class UserModel  {
//   final String? userName;
//   final String? email;
//   final String? image;
//   final String? uId;
//
//   const UserModel({
//     required this.userName,
//     required this.email,
//     required this.image,
//     required this.uId,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       userName: json['userName'],
//       email: json['email'],
//       image: json['image'],
//       uId: json['uId'],
//     );
//   }
//
//   Map<String, dynamic> tomap() {
//     return {
//       'userName': userName,
//       'email': email,
//       'image': image,
//       'uId': uId,
//     };
//   }
//
//   @override
//   List<Object?> get props => [
//         userName,
//         email,
//         image,
//         uId,
//       ];
// }
//
// class PeopleModel {
//   final String name;
//   final String image;
//   PeopleModel({
//     required this.image,
//     required this.name,
//   });
// }
//
//
import 'dart:io';

class UserModel {
  final String name;
  final String email;
  final String uid;
  final String profilePic;
   String? bio;
  final bool isOnline;
  final List<String> groupId;
  UserModel(  {
    required this.name,
    required this.uid,
     this.bio,
    required this.email,
    required this.profilePic,
    required this.isOnline,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'bio': bio,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ,
      uid: map['uid'] ,
      bio: map['bio'] ,
      profilePic: map['profilePic'] ?? '',
      isOnline: map['isOnline'] ?? false,
      groupId: List<String>.from(map['groupId']),
      email:  map['email'],
    );
  }
}
