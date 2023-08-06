import 'package:chatty/controller/provider/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/user_model.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/global.dart';
import '../../../../shared/widgets/loader.dart';
import '../call/call_pickup_screen.dart';
import 'component/bottom_chat.dart';
import 'component/chat_list.dart';

class MobileChatScreen extends StatelessWidget {

  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ChatProv>(context,listen: false);
    return
      CallPickupScreen(
        scaffold:  Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBarColor,
            title: isGroupChat
                ? Text(name)
                : StreamBuilder<UserModel>(
                stream: userData(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return Column(
                    children: [
                      Text(name),
                      Text(
                        snapshot.data!.isOnline ? 'online' : 'offline',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () => provider.makeCall(
                  context: context,
                  receiverName: name,
                  receiverUid:  uid,
                  receiverProfilePic:  profilePic,
                  isGroupChat: isGroupChat,),
                icon: const Icon(Icons.video_call),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ChatList(
                  recieverUserId: uid,
                  isGroupChat: isGroupChat,
                ),
              ),
              BottomChatField(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ],
          ),
        ),
      );
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
        event.data()!,
      ),
    );
  }
}
