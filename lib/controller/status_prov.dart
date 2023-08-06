import 'dart:io';
import 'package:chatty/controller/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/status_model.dart';
import '../models/user_model.dart';
import '../shared/utils/app_methods.dart';
import '../shared/utils/global.dart';

class StatusProv extends ChangeNotifier{


  Future<List<Status>> getStatus(BuildContext context) async {
    List<Status> statusData = [];
    try {

        var statusesSnapshot = await firestore
            .collection('status')
            .where(
          'createdAt',
          isGreaterThan: DateTime.now()
              .subtract(const Duration(hours: 24))
              .millisecondsSinceEpoch,
        ).get();

        for (var tempData in statusesSnapshot.docs) {
          Status tempStatus = Status.fromMap(tempData.data());
          if (tempStatus.whoCanSee.contains(fAuth.currentUser!.uid)) {
            statusData.add(tempStatus);
          }
        }


    } catch (e) {
      if (kDebugMode) debugPrint(e.toString());
      showSnackBar(context: context, content: e.toString());
    }
    return statusData;
  }


void addStatus(
   File statusImage,
   BuildContext context,
) async {
  try {
    var statusId = const Uuid().v1();
    String uid = fAuth.currentUser!.uid;
    String imageurl = await Provider.of<AuthProv>(context).
        storeFileToFirebase(
      '/status/$statusId$uid',
      statusImage,
    );

    List<String> uidWhoCanSee = [];

      var userDataFirebase = await firestore.collection('users').get();
      if (userDataFirebase.docs.isNotEmpty) {
        var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
        uidWhoCanSee.add(userData.uid);
      }


    List<String> statusImageUrls = [];
    var statusesSnapshot = await firestore
        .collection('status')
        .where(
      'uid',
      isEqualTo: fAuth.currentUser!.uid,
    ).get();

    if (statusesSnapshot.docs.isNotEmpty) {
      Status status = Status.fromMap(statusesSnapshot.docs[0].data());
      statusImageUrls = status.photoUrl;
      statusImageUrls.add(imageurl);
      await firestore
          .collection('status')
          .doc(statusesSnapshot.docs[0].id)
          .update({
        'photoUrl': statusImageUrls,
      });
      return;
    } else {
      statusImageUrls = [imageurl];
    }

    Status status = Status(
      uid: uid,
      username: user!.name,
      photoUrl: statusImageUrls,
      createdAt: DateTime.now(),
      profilePic: user!.profilePic,
      statusId: statusId,
      whoCanSee: uidWhoCanSee,
    );

    await firestore.collection('status').doc(statusId).set(status.toMap());
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
}
}