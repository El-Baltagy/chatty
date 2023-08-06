import 'package:flutter/material.dart';
import '../../../models/call_model.dart';
import '../../../models/group_model.dart' as model;
import '../../../models/user_model.dart';
import '../../../shared/utils/app_methods.dart';
import '../../../shared/utils/global.dart';
import '../../../view/screens/lay_out/call/call.dart';
import 'package:uuid/uuid.dart';

class ChatProv extends ChangeNotifier{

  //makeCall

  void makeCall({required BuildContext context,
    required String receiverName,
    required String receiverUid,
    required String receiverProfilePic,
    required bool isGroupChat}) {

      String callId = const Uuid().v1();
      Call senderCallData = Call(
        callerId: currentFirebaseUser!.uid,
        callerName: user!.name,
        callerPic: user!.profilePic,
        receiverId: receiverUid,
        receiverName: receiverName,
        receiverPic: receiverProfilePic,
        callId: callId,
        hasDialled: true,
      );

      Call recieverCallData = Call(
        callerId: currentFirebaseUser!.uid,
        callerName: user!.name,
        callerPic: user!.profilePic,
        receiverId: receiverUid,
        receiverName: receiverName,
        receiverPic: receiverProfilePic,
        callId: callId,
        hasDialled: false,
      );
      if (isGroupChat) {
        makeGroupCall(senderCallData, context, recieverCallData);
      } else {
        makeCallRepo(senderCallData, context, recieverCallData);
      }

  }


  void makeCallRepo(
      Call senderCallData,
      BuildContext context,
      Call receiverCallData,
      ) async {
    try {
      await firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());
      await firestore
          .collection('call')
          .doc(senderCallData.receiverId)
          .set(receiverCallData.toMap());
          Future.delayed(const Duration(milliseconds: 150)).whenComplete(
          ()=>GoPage().push(context, path: CallScreen(
           channelId: senderCallData.callId,
           call: senderCallData,
           isGroupChat: false,
      )));
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  //makeGroupCall
  void makeGroupCall(
      Call senderCallData,
      BuildContext context,
      Call receiverCallData,
      ) async {
    try {
      await firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());

      var groupSnapshot = await firestore
          .collection('groups')
          .doc(senderCallData.receiverId)
          .get();
      model.Group group = model.Group.fromMap(groupSnapshot.data()!);

      for (var id in group.membersUid) {
        await firestore
            .collection('call')
            .doc(id)
            .set(receiverCallData.toMap());
      }

          ()=>GoPage().push(context, path: CallScreen(
        channelId: senderCallData.callId,
        call: senderCallData,
        isGroupChat: false,
      ));
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  //endCall
  void endCall(
      { required String callerId,
        required String receiverId,
        required BuildContext context,}
      ) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      await firestore.collection('call').doc(receiverId).delete();
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  //endGroupCall
  void endGroupCall(
      String callerId,
      String receiverId,
      BuildContext context,
      ) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      var groupSnapshot =
      await firestore.collection('groups').doc(receiverId).get();
      model.Group group = model.Group.fromMap(groupSnapshot.data()!);
      for (var id in group.membersUid) {
        await firestore.collection('call').doc(id).delete();
      }
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context: context, content: e.toString());
    }
  }
}