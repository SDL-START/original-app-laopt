import 'package:flutter/material.dart';
import 'package:insuranceapp/core/constants/app_images.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/date_time_extension.dart';
import 'package:insuranceapp/core/models/sos_message.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';

import '../../../../core/params/preview_img_params.dart';
import 'components/bubble_component.dart';
import 'components/image_component.dart';
import 'components/live_location_component.dart';
import 'components/map_component.dart';

class MessageBubble extends StatelessWidget {
  final SOSMessage? message;
  final bool isUserMessage;
  final bool isStaff;
  const MessageBubble({
    super.key,
    this.message,
    this.isUserMessage = false,
    this.isStaff = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            (isUserMessage) ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          (!isUserMessage)
              ? CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: (!isStaff)
                      ? Image.asset(AppImages.support_active)
                      : const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                )
              : const SizedBox(),
          if (message?.messageType == MessageType.LOCATION.name) ...[
            Column(
              crossAxisAlignment: (isUserMessage)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                MapComponent(message: message),
                const SizedBox(height: 10),
                Text(
                  message?.createdAt?.toLocal().formatTime() ?? '',
                  style: const TextStyle(fontSize: 8),
                )
              ],
            )
          ],
          if (message?.messageType == MessageType.TEXT.name) ...[
            BubbleComponent(
              message: message,
              isUserMessage: isUserMessage,
            ),
          ],
          if (message?.messageType == MessageType.FILE.name) ...[
            Column(
              crossAxisAlignment: (isUserMessage)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                ImageComponent(
                  message: message,
                  onTap: () {
                    AppNavigator.navigateTo(
                      AppRoute.previewImageRoute,
                      params: PreviewImageParams(
                        createdAt: message?.createdAt?.toLocal(),
                        imageUrl: message?.image,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  message?.createdAt?.toLocal().formatTime() ?? '',
                  style: const TextStyle(fontSize: 8),
                )
              ],
            ),
          ],
          if (message?.messageType == MessageType.LIVE_LOCATION.name) ...[
            Column(
              crossAxisAlignment: (isUserMessage)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                LiveLocationComponent(
                  message: message,
                ),
                const SizedBox(height: 10),
                Text(
                  message?.createdAt?.toLocal().formatTime() ?? '',
                  style: const TextStyle(fontSize: 8),
                )
              ],
            )
          ],
          (isUserMessage)
              ? CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: (isStaff)
                      ? Image.asset(AppImages.support_active)
                      : const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
