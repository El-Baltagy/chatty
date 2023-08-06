import 'package:chatty/view/screens/lay_out/user_chat/component/text_image_gif.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../controller/provider/chat/bottom_chat.dart';


class MessageReplyPreview extends StatelessWidget {
  const MessageReplyPreview({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context ) {

    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  MessageReply.value().isMe! ? 'Me' : 'Opposite',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
                onTap: (){
                  //cancelReply
                  Provider.of<ChatListProv>(context,listen: false).updateMessageReply(isMe: null, messageEnum: null, Strmsg: null);
                }  ,
              ),
            ],
          ),
          const SizedBox(height: 8),
          DisplayTextImageGIF(
            message: MessageReply.value().message!,
            type: MessageReply.value().messageEnum!,
          ),
        ],
      ),
    );
  }
}
