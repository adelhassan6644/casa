import 'package:casa/app/core/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../data/config/di.dart';
import '../models/chat_model.dart';

class MessageBubble extends StatelessWidget {
  final Message chat;
  final bool addDate;
  MessageBubble({required this.chat, required this.addDate});

  @override
  Widget build(BuildContext context) {
    final myId = sl.get<SharedPreferences>().getString(AppStorageKey.userId);
    bool isMe = chat.senderId == myId;


    return Column(
      crossAxisAlignment:
          !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: isMe
              ? EdgeInsets.fromLTRB(50, 5, 10, 5)
              : EdgeInsets.fromLTRB(10, 5, 50, 5),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft:
                              isMe ? Radius.circular(15) : Radius.circular(0),
                          bottomRight:
                              isMe ? Radius.circular(0) : Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        color: isMe
                            ? Styles.PRIMARY_COLOR
                            : Styles.GREY_BORDER,
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_LARGE,
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: SelectableText( chat.massage ,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: isMe
                                        ?  Colors.white
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 1),
              // Text(dateTime,
              //     style: TextStyle(
              //         fontSize: 8, color: ColorResources.COLOR_GREY_BUNKER)),
            ],
          ),
        ),
      ],
    );
  }
}
