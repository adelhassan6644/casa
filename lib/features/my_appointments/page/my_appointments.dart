import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/features/my_appointments/widgets/next_appointments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/my_appointments_provider.dart';
import '../widgets/my_appointment_header.dart';
import '../widgets/previous_appointments.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key}) : super(key: key);

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments>
    with AutomaticKeepAliveClientMixin<MyAppointments> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // sl<MyAppointmentsProvider>().getNextAppointments();
      // sl<MyAppointmentsProvider>().getPreviousAppointments();
    });

    super.initState();
  }

  List<Widget> content = [
    const NextAppointments(),
    const PreviousAppointments()
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        children: [
          const MyAppointmentHeader(),
          SizedBox(
            height: Dimensions.PADDING_SIZE_DEFAULT.h,
          ),
          Expanded(
            child:
                Consumer<MyAppointmentsProvider>(builder: (_, provider, child) {
              return content[provider.currentTab];
            }),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
