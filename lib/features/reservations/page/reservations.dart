import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/features/guest/guest_mode.dart';
import 'package:casa/features/reservations/widgets/next_reservations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/config/di.dart';
import '../../auth/provider/auth_provider.dart';
import '../provider/reservations_provider.dart';
import '../widgets/reservation_header.dart';
import '../widgets/previous_reservations.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations>
    with AutomaticKeepAliveClientMixin<Reservations> {
  @override
  void initState() {
    if (sl<AuthProvider>().isLogin) {
      Future.delayed(Duration.zero, () {
        sl<ReservationsProvider>().getNextReservations();
        sl<ReservationsProvider>().getPreviousReservations();
      });
    }

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
                Consumer<ReservationsProvider>(builder: (_, provider, child) {
                  if(provider.isLogin) {
                    return content[provider.currentTab];
                  }
                  else {
                    return GuestMode();
                  }
            }),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
