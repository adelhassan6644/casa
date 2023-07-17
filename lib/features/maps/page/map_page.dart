import 'package:casa/app/core/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../main_models/base_model.dart';
import '../provider/location_provider.dart';
import '../widget/map_places.dart';

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
    Provider.of<LocationProvider>(context, listen: false).isGetPlaces = true;
    if (widget.baseModel?.object != null) {
      Provider.of<LocationProvider>(context, listen: false).pickAddress =
          widget.baseModel?.object.address ?? "";
    } else {
      Provider.of<LocationProvider>(context, listen: false).pickAddress =
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
        CameraPosition(target: _initialPosition, zoom: 100),
      ));
      Provider.of<LocationProvider>(context, listen: false)
          .getPlaces(_initialPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child:
          Consumer<LocationProvider>(builder: (c, locationController, _) {
        return Stack(alignment: Alignment.bottomCenter, children: [
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
                locationController.getLocation(false,
                    mapController: _mapController!);
              }
            },
            scrollGesturesEnabled: true,
            zoomControlsEnabled: false,
            onCameraMove: (CameraPosition cameraPosition) {
              _cameraPosition = cameraPosition;
            },
            onCameraIdle: () {
              locationController.updatePosition(
                _cameraPosition,
              );
            },
          ),
          Center(
              child: !locationController.isLoading
                  ? const Icon(
                      Icons.location_on_rounded,
                      size: 50,
                      color: ColorResources.PRIMARY_COLOR,
                    )
                  : const CupertinoActivityIndicator()),

          ////  prediction section

          /*   Positioned(
            top: Dimensions.PADDING_SIZE_LARGE,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL,
            child: SearchLocationWidget(
                mapController: _mapController,

                pickedAddress: locationController.pickAddress,
                isEnabled: true),
          ),
*/

          Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: const MapPlaces(),
          )
        ]);
      }))),
    );
  }
}
