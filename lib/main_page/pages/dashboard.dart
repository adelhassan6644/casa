import 'package:casa/features/favourite/provider/favourite_provider.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:casa/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:casa/features/profile/page/profile.dart';
import 'package:casa/main_page/provider/main_page_provider.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/styles.dart';
import '../../data/config/di.dart';
import '../../data/network/network_info.dart';
import '../../features/address/provider/addresses_provider.dart';
import '../../features/home/page/home.dart';
import '../../features/more/page/more.dart';
import '../../features/reservations/page/reservations.dart';
import '../widget/nav_bar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    NetworkInfo.checkConnectivity();
    sl<HomeProvider>().getCategories();
    sl<FavouriteProvider>().getFavourites();
    sl<AddressesProvider>().getAddresses();
    sl<ProfileProvider>().getProfile();
    super.initState();
  }

  Widget fragment(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const Reservations();
      case 2:
        return const Profile();
      case 3:
        return const More();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Scaffold(
        backgroundColor: Styles.SCAFFOLD_BG,
        bottomNavigationBar: const NavBar(),
        body: fragment(provider.selectedIndex),
      );
    });
  }
}
