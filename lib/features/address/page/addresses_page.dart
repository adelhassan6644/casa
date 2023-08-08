import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:casa/components/custom_button.dart';
import 'package:casa/features/address/provider/addresses_provider.dart';
import 'package:casa/features/product_schedule/model/schedule_model.dart';
import 'package:casa/main_models/base_model.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../components/empty_widget.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../widgets/address_card.dart';
import '../widgets/delete_confirmation_dialog.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key, this.model}) : super(key: key);
  final ScheduleModel? model;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AddressesProvider>(builder: (_, provider, child) {
        return Scaffold(
          backgroundColor: Styles.SCAFFOLD_BG,
          body: Column(
            children: [
              CustomAppBar(
                title: getTranslated(
                    model != null ? "address_selection" : "addresses", context),
              ),
              !provider.isLoading
                  ? Expanded(
                      child: RefreshIndicator(
                        color: Styles.PRIMARY_COLOR,
                        onRefresh: () async {
                          provider.getAddresses();
                        },
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            if (provider.model != null &&
                                provider.model!.data!.isNotEmpty)
                              ...List.generate(
                                  provider.model!.data!.length,
                                  (index) => Dismissible(
                                        background: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                              width: 100.w,
                                              height: 30.h,
                                              text: getTranslated(
                                                  "delete", context),
                                              svgIcon: SvgImages.cancel,
                                              iconSize: 12,
                                              iconColor: Styles.IN_ACTIVE,
                                              textColor: Styles.IN_ACTIVE,
                                              backgroundColor: Styles.IN_ACTIVE
                                                  .withOpacity(0.12),
                                            ),
                                          ],
                                        ),
                                        key: ValueKey(index),
                                        confirmDismiss:
                                            (DismissDirection direction) async {
                                          CustomSimpleDialog.parentSimpleDialog(
                                            customListWidget: [
                                              DeleteConfirmationDialog(
                                                  id: provider
                                                      .model!.data![index].id)
                                            ],
                                          );
                                          return false;
                                        },
                                        child: AddressCard(
                                          onTap: () {
                                            if (provider.selectedAddress?.id !=
                                                provider
                                                    .model!.data![index].id) {
                                              provider.selectAddress(
                                                  provider.model!.data![index]);
                                            } else {
                                              provider.selectAddress(null);
                                            }
                                          },
                                          addressItem:
                                              provider.model!.data![index],
                                          isSelect: model != null
                                              ? provider.selectedAddress?.id ==
                                                  provider
                                                      .model!.data![index].id
                                              : false,
                                        ),
                                      )),
                            if (provider.model == null ||
                                provider.model!.data!.isEmpty)
                              EmptyState(
                                txt: getTranslated(
                                    "there_is_no_addresses", context),
                                btnText: getTranslated("add_address", context),
                                onTap: () =>
                                    CustomNavigator.push(Routes.PICK_LOCATION,
                                        arguments: BaseModel(
                                          valueChanged:
                                              provider.onSelectStartLocation,
                                        )),
                                originalButton: false,
                              ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: ListAnimator(
                          data: [
                            SizedBox(
                              height: 8.h,
                            ),
                            ...List.generate(
                                10,
                                (index) => Container(
                                      margin: EdgeInsets.only(
                                          bottom:
                                              Dimensions.PADDING_SIZE_SMALL.h),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Styles.LIGHT_BORDER_COLOR,
                                                  width: 1.h))),
                                      child: CustomShimmerContainer(
                                        width: context.width,
                                        height: 80.h,
                                        radius: 15,
                                      ),
                                    ))
                          ],
                        ),
                      ),
                    ),

              /// To Add Address
              Visibility(
                visible: !provider.isLoading &&
                    provider.model != null &&
                    provider.model!.data!.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL.h,
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: CustomButton(
                    text: getTranslated("add_address", context),
                    onTap: () {
                      CustomNavigator.push(Routes.PICK_LOCATION,
                          arguments: BaseModel(
                            valueChanged: provider.onSelectStartLocation,
                          ));
                    },
                  ),
                ),
              ),

              /// To Check Out
              Visibility(
                visible: model != null &&
                    !provider.isLoading &&
                    provider.model != null &&
                    provider.model!.data!.isNotEmpty,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: CustomButton(
                        text: getTranslated("follow_and_payment", context),
                        onTap: () {
                          if (provider.selectedAddress != null) {
                            CustomNavigator.push(Routes.CHECK_OUT);
                          } else {
                            showToast(getTranslated(
                                "oops_you_must_select_address", context));
                          }
                        },
                        backgroundColor: Styles.WHITE_COLOR,
                        withShadow: true,
                        withBorderColor: true,
                        textColor: Styles.PRIMARY_COLOR,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
