import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../../main_models/base_model.dart';
import '../provider/map_provider.dart';
import '../widget/location_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({this.baseModel, Key? key}) : super(key: key);
  final BaseModel? baseModel;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  late CameraPosition _cameraPosition;
  late LatLng _initialPosition;

  @override
  void initState() {
    if (widget.baseModel?.object != null) {
      Provider.of<MapProvider>(context, listen: false).pickAddress =
          widget.baseModel?.object.address ?? "";
    } else {
      Provider.of<MapProvider>(context, listen: false).pickAddress =
          AppStrings.defaultAddress;
    }

    Future.delayed(
        const Duration(milliseconds: 100), () => getInitialPosition());
    super.initState();
  }

  getInitialPosition() {
    if (widget.baseModel?.object != null) {
      _initialPosition = LatLng(
          double.parse(
              widget.baseModel?.object.latitude ?? AppStrings.defaultLat),
          double.parse(
              widget.baseModel?.object.longitude ?? AppStrings.defaultLong));
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPosition, zoom: 192),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
          Consumer<MapProvider>(builder: (_, locationProvider, child) {
        return Stack(children: [
          ///Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              bearing: 192,
              target: LatLng(
                double.parse(AppStrings.defaultLat),
                double.parse(AppStrings.defaultLong),
              ),
              zoom: 14,
            ),
            minMaxZoomPreference: const MinMaxZoomPreference(0, 100),
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController mapController) {
              _mapController = mapController;
              if (widget.baseModel?.object == null) {
                locationProvider.getLocation(false,
                    mapController: _mapController!);
              }
            },
            scrollGesturesEnabled: true,
            zoomControlsEnabled: false,
            onCameraMove: (CameraPosition cameraPosition) {
              _cameraPosition = cameraPosition;
            },
            onCameraIdle: () {
              locationProvider.updatePosition(
                _cameraPosition,
              );
            },
          ),

          ///Confirm Location
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppBar(
                title: getTranslated("pick_address", context),
                colorBG: Styles.WHITE_COLOR,
              ),
               LocationCard(valueChanged: widget.baseModel?.valueChanged,),
            ],
          ),

          ///Select Location
          Center(
            child: !locationProvider.isLoading
                ? const Icon(
                    Icons.location_on_rounded,
                    size: 40,
                    color: Styles.PRIMARY_COLOR,
                  )
                : const CupertinoActivityIndicator(),
          ),
        ]);
      })),
    );
  }
}
