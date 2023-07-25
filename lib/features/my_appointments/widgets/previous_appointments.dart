import 'package:casa/components/animated_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/config/di.dart';
import '../provider/my_appointments_provider.dart';
import 'appointment_card.dart';

class PreviousAppointments extends StatefulWidget {
  const PreviousAppointments({Key? key}) : super(key: key);

  @override
  State<PreviousAppointments> createState() => _PreviousAppointmentsState();
}

class _PreviousAppointmentsState extends State<PreviousAppointments> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      sl<MyAppointmentsProvider>().previousScroll(controller);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  RefreshIndicator(
      color: Styles.PRIMARY_COLOR,
      onRefresh: () async {
        // sl<MyAppointmentsProvider>().getPreviousAppointments();
      },
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: ListAnimator(
                controller: controller,
                data: List.generate(10, (index) => const AppointmentCard(isNext: false,)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
