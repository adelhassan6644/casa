import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../../home/models/places_model.dart';
import '../models/location_model.dart';
import '../models/prediction_model.dart';
import '../repo/maps_repo.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  final MapsRepo locationRepo;
  LocationProvider({
    required this.locationRepo,
  });

  List<PredictionModel> _predictionList = [];
  bool isLoading = false;
  String pickAddress = '';
  LocationModel? addressModel;
  Position? _myPosition;
  Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  Position pickPosition = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  Future<List<PredictionModel>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Either<ServerFailure, Response> response =
          await locationRepo.searchLocation(text);
      response.fold((error) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated(error.error,
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        _predictionList = [];
        response.data['predictions'].forEach((prediction) =>
            _predictionList.add(PredictionModel.fromJson(prediction)));
      });
    }
    return _predictionList;
  }

  LocationModel? currentLocation;
  getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position newLocalData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    Either<ServerFailure, Response> response =
    await locationRepo.getAddressFromGeocode(
        LatLng(newLocalData.latitude, newLocalData.longitude));
    response.fold((l) => null, (response) {
      pickAddress = response.data['results'][0]['formatted_address'].toString();
      currentLocation = LocationModel(
        latitude: newLocalData.latitude.toString(),
        longitude: newLocalData.longitude.toString(),
        address: response.data['results'][0]['formatted_address'].toString(),
      );
    });
    notifyListeners();
  }

  getLocation(
    bool fromAddress, {required GoogleMapController mapController,}) async {
    isLoading = true;
    notifyListeners();
      await Geolocator.requestPermission();
      Position newLocalData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,);
      _myPosition = newLocalData;
    if (fromAddress) {
      position = _myPosition!;
    } else {
      pickPosition = _myPosition!;
    }

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(_myPosition!.latitude, _myPosition!.longitude),
          zoom: 18),
    ));

    await decodeLatLong(
      latitude: _myPosition!.latitude,
      longitude: _myPosition!.longitude,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> decodeLatLong({
    required latitude,
    required longitude,
  }) async {
    Either<ServerFailure, Response> response =
        await locationRepo.getAddressFromGeocode(LatLng(latitude, longitude));

    response.fold((l) => null, (response) {
      pickAddress = response.data['results'][0]['formatted_address'].toString();
      addressModel = LocationModel(
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        address: response.data['results'][0]['formatted_address'].toString(),
      );
      notifyListeners();
    });
  }

  updatePosition(
    CameraPosition position,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      pickPosition = Position(
        latitude: position.target.latitude,
        longitude: position.target.longitude,
        timestamp: DateTime.now(),
        heading: 1,
        accuracy: 1,
        altitude: 1,
        speedAccuracy: 1,
        speed: 1,
      );
      decodeLatLong(
          latitude: position.target.latitude,
          longitude: position.target.longitude);
      isLoading = false;

      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }

  }


}
