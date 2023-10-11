import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/features/support/provider/support_provider.dart';
import 'package:casa/features/support/unit/message_bubble.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/core/utils/app_snack_bar.dart';
import '../../app/core/utils/app_storage_keys.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../app/localization/localization/language_constant.dart';
import '../../components/loader_view.dart';
import '../../data/api/end_points.dart';
import '../../data/config/di.dart';
import 'models/chat_model.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();


  int _limit = 15;
  final int _limitIncrement = 20;
  final ScrollController listScrollController = ScrollController();
  List<Message> listMessage = List.from([]);
  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {}
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      _limit += _limitIncrement;
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  initState() {
    listScrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var outlineStyle = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xffF5F5F5), width: 0.0),
      borderRadius: BorderRadius.circular(25.0),
    );
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(getTranslated("support", context),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Consumer<SupportProvider>(
              builder: (context, chat, child) {
                return Column(children: [
                  _getMessageList(),

                  // Bottom TextField
                  Center(
                    child: SizedBox(
                      width: 1170,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 100),
                              child: Ink(
                                color: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color(0xffF5F5F5),
                                  ),
                                  child: Row(children: [
                                    Expanded(
                                      child: TextField(
                                        controller: chat.controller,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        style: const TextStyle(
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE),
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          disabledBorder: outlineStyle,
                                          enabledBorder: outlineStyle,
                                          focusedBorder: outlineStyle,
                                          border: outlineStyle,
                                          hintText: 'أرسل رسالة!',
                                          hintStyle: const TextStyle(
                                              color: Styles.GREY_BORDER,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_LARGE),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {

                                        await chat.sendMessage();
                                        listScrollController.jumpTo(listScrollController.position.maxScrollExtent);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .PADDING_SIZE_DEFAULT),
                                        child: Container(
                                          width: 100,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Styles.PRIMARY_COLOR),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                Images.success,
                                                width: 25, height: 25,
                                                // color: Provider.of<ChatProvider>(context).isSendButtonActive ? Theme.of(context).primaryColor : ColorResources.getGreyBunkerColor(context),
                                              ),
                                              Text(
                                                "إرسال",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]);
              },
            ),
          ),
        ));
  }

  Widget _getMessageList() {

    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: FirebaseAnimatedList(
          controller: listScrollController,
          // shrinkWrap: true,

          defaultChild: const LoaderView(),
          query: ref
              .child("messages")
              .child(sl.get<SharedPreferences>().getString(AppStorageKey.userId)!)
              .limitToLast(_limit),
          itemBuilder: (context, snapshot, animation, index) {

            listMessage = [];
            print(snapshot.value);
            final json = snapshot.value as Map<dynamic, dynamic>;
            final message = Message.fromJson(json);
            listMessage.add(message);
            return MessageBubble(
              addDate: true,
              chat: message,
            );
          },
        ),
      ),
    );
  }
}
