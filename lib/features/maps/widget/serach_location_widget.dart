import 'package:casa/features/maps/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../models/prediction_model.dart';

class SearchLocationWidget extends StatelessWidget {
  final GoogleMapController? mapController;
  final String pickedAddress;
  final bool isEnabled;
  final bool? isPickedUp;
  final String? hint;
  const SearchLocationWidget(
      {super.key,
      this.mapController,
      required this.pickedAddress,
      required this.isEnabled,
      this.isPickedUp,
      this.hint});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller =
        TextEditingController(text: pickedAddress);
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Dimensions.RADIUS_DEFAULT),
      ),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Styles.BORDER_COLOR,
        width: 0,
      ),
    );
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          border: border,
          disabledBorder: border,
          focusedBorder: border,
          enabledBorder: border,
          alignLabelWithHint: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Icon(
              Icons.location_on,
              size: 25,
              color: (isEnabled == null || isEnabled)
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 30),
          suffixIcon: Icon(Icons.search,
              size: 25, color: Theme.of(context).textTheme.bodyText1?.color),
          isDense: true,
          filled: true,
          hintText: "search location",
          fillColor: Theme.of(context).cardColor,
          hintStyle: AppTextStyles.regular.copyWith(
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: Styles.DISABLED),
          contentPadding: EdgeInsets.only(
            bottom: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),
        ),
        style: AppTextStyles.regular.copyWith(
          color: Theme.of(context).textTheme.bodyText1?.color,
          fontSize: Dimensions.FONT_SIZE_LARGE,
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await Provider.of<MapProvider>(context, listen: false)
            .searchLocation(context, pattern);
      },
      itemBuilder: (context, PredictionModel suggestion) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
              color: Styles.BORDER_COLOR,
              width: 0,
            ),
          ),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(children: [
            Icon(
              Icons.location_on,
              color: Styles.PRIMARY_COLOR,
              size: 25,
            ),
            SizedBox(
              width: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(suggestion.description ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).textTheme.bodyText1?.color,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        )),
              ),
            ),
          ]),
        );
      },
      onSuggestionSelected: (PredictionModel suggestion) {
        // if (isPickedUp == null) {
        //   Get.find<LocationController>().setLocation(suggestion.placeId,
        //       suggestion.description, mapController);
        // } else {
        //   Get.find<ParcelController>().setLocationFromPlace(
        //       suggestion.placeId, suggestion.description, isPickedUp);
        // }
        // Get.back();
      },
      hideOnLoading: true,
    );
  }
}
