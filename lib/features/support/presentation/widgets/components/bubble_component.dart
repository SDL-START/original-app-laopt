import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/core/extensions/date_time_extension.dart';
import 'package:insuranceapp/core/models/sos_message.dart';

class BubbleComponent extends StatelessWidget {
  final SOSMessage? message;
  final bool isUserMessage;
  const BubbleComponent({super.key, this.message, this.isUserMessage = false});

  @override
  Widget build(BuildContext context) {
    return Bubble(
      nip: (isUserMessage) ? BubbleNip.rightTop : BubbleNip.leftTop,
      padding: const BubbleEdges.only(top: 20),
      child: Column(
        crossAxisAlignment:
            (isUserMessage) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
            child: Text("${message?.message}"),
          ),
          const SizedBox(height: 10),
          Text(
            message?.createdAt?.toLocal().formatTime()??'',
            style: const TextStyle(fontSize: 8),
          )
        ],
      ),
    );
  }
}
