import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../models/chat_model.dart';
import '../repo/support_repo.dart';


class SupportProvider extends ChangeNotifier{
  SupportRepo repo;
  SupportProvider({required this.repo});
  bool isLoading = false;
  bool isSendButtonActive = false;
  bool isLoadingNewChat = false;
  ChatModel? selectedChat;


  startNewChat() async {
    isLoadingNewChat = true;
    notifyListeners();
    Either<ServerFailure, Response> apiResponse =
    await repo.startNewChat();
    apiResponse.fold((l) {
      isLoadingNewChat = false;
      notifyListeners();
    }, (success) {

      // MyApp.navigatorKey.currentState!.push(
      //   MaterialPageRoute(
      //     builder: (context) => ChatScreen(chatModel: selectedChat!,),
      //   ),
      // );
      isLoadingNewChat = false;
      notifyListeners();
    });
  }
  final TextEditingController controller = TextEditingController();
  sendMessage() async {
    isLoading = true;
    notifyListeners();
    if (controller.text.isNotEmpty) {
      Either<ServerFailure, String> apiResponse =
      await repo.sendMessage(message: controller.text, );
      apiResponse.fold((l) {
        print("faill");
      }, (success) {
        controller.clear();

      });
    } else {
      showToast(getTranslated("you_must_change_something",
          CustomNavigator.navigatorState.currentContext!));



    }

  }
}