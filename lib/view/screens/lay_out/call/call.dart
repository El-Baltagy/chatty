import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/chat/chat.dart';
import '../../../../models/call_model.dart';
import '../../../../shared/utils/global.dart';
import '../../../../shared/widgets/loader.dart';

class CallScreen extends StatefulWidget {

  final String channelId;
  final Call call;
  final bool isGroupChat;
  const CallScreen({
    Key? key,
    required this.channelId,
    required this.call,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  AgoraClient? client;



  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tokenUrl: AgoraConfig.baseUrl,
      ),
    );
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: client == null ? const Loader()
          : SafeArea(
           child: Stack(
          children: [
            AgoraVideoViewer(client: client!),
            AgoraVideoButtons(
              client: client!,
              disconnectButtonChild: IconButton(
                onPressed: () async {
                  await client!.engine.leaveChannel();
                  ()=>Provider.of<ChatProv>(context).endCall(
                    callerId: widget.call.callerId,
                    receiverId: widget.call.receiverId,
                    context: context,
                  );
                  ()=> Navigator.pop(context);
                },
                icon: const Icon(Icons.call_end),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
