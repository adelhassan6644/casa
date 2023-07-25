import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/features/my_appointments/widgets/cancelation_dailog.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/config/di.dart';
import '../provider/my_appointments_provider.dart';
import 'appointment_card.dart';

class NextAppointments extends StatefulWidget {
  const NextAppointments({Key? key}) : super(key: key);

  @override
  State<NextAppointments> createState() => _NextAppointmentsState();
}

class _NextAppointmentsState extends State<NextAppointments> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<MyAppointmentsProvider>().nextScroll(controller);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Styles.PRIMARY_COLOR,
      onRefresh: () async {
        // sl<MyAppointmentsProvider>().getNextAppointments();
      },
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: ListAnimator(
                controller: controller,
                data: List.generate(
                  2,
                  (index) => Dismissible(
                    background: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomButton(
                          width: 85.w,
                          height: 30.h,
                          text: getTranslated("cancel", context),
                          svgIcon: SvgImages.cancel,
                          iconSize: 12,
                          iconColor: Styles.IN_ACTIVE,
                          textColor: Styles.IN_ACTIVE,
                          backgroundColor: Styles.IN_ACTIVE.withOpacity(0.12),
                        ),
                      ],
                    ),
                    key: ValueKey(index),
                    confirmDismiss: (DismissDirection direction) async {
                      CustomSimpleDialog.parentSimpleDialog(
                        customListWidget: [const CancelDialog()],
                      );
                      return false;
                    },
                    child: const AppointmentCard(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
