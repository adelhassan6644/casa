import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../model/contact_model.dart';
import '../repo/contact_repo.dart';

class ContactProvider extends ChangeNotifier {
  ContactRepo contactRepo;
  ContactProvider({required this.contactRepo}){
    getContact();
  }

  ///Get contact Data
  bool isLoading = false;
  ContactModel? contactModel;
  getContact() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await contactRepo.getContact();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        contactModel = ContactModel.fromJson(response.data['data']["contact"]);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  launchWebsite() {
    try {
      launchUrl(Uri.parse(
        contactModel?.website??'https://codoweb.com/',
      ));
    } catch (e) {
      log("=====> Exception WebSite Launch $e");
    }
  }

  launchMail() {
    try {
      launchUrl(Uri(
        scheme: 'mailto',
        path:   contactModel?.email??'adelhassan6644@gmail.com',
        query: 'subject=Hello&body=Test',
      ));
    } catch (e) {
      log("=====> Exception Mail Launch $e");
    }
  }

  launchTwitter() {
    try {
      launchUrl(Uri.parse(
        contactModel?.twitter??'https://www.twitter.com/Software_Cloud2',
      ));
    } catch (e) {
      log("=====> Exception Twitter Launch $e");
    }
  }

  launchCustomerService() {
    try {
      launch("tel:// ${  contactModel?.phone?? "+2966555666777"}");
    } catch (e) {
      log("=====> Exception Customer Service Launch $e");
    }
  }
}
