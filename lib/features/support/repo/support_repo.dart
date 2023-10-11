import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class SupportRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SupportRepo({required this.dioClient, required this.sharedPreferences});
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  // final ref = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://casa-50155-default-rtdb.firebaseio.com/').ref();
  Future<Either<ServerFailure, Response>> startNewChat(
     ) async {
    try {
      Response response = await dioClient.post(
        uri: EndPoints.startNewChat,
        data: {
          'client_id': sharedPreferences.getString(AppStorageKey.userId)
        },
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<ServerFailure, String>> sendMessage({
    required String message,
  }) async {
    try {



      final userId = sharedPreferences.getString(AppStorageKey.userId);


     await  ref.child("messages").child("$userId").push().set({
        "conv_id": userId,
        "sender_id": userId,
        "message": message,
        "receiver_id": 50500,
        "created_at": DateTime.now().toString(),
      }).then((value)  {
      });
      log("success");
      return Right("success");
    } catch (e) {
      log("fail");
      return Left(ServerFailure(ApiErrorHandler.getMessage(e)));
    }
  }


}
