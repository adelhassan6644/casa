import 'package:flutter/material.dart';
import 'package:casa/features/profile/page/profile.dart';
import 'package:casa/main_page/provider/main_page_provider.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../data/network/network_info.dart';
import '../../features/favourite/page/favourites.dart';
import '../../features/home/page/home.dart';
import '../../features/maps/page/map_page.dart';
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
    super.initState();
  }

  Widget fragment(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const Profile();
      case 2:
        return const MapPage();
      case 3:
        return const Favourites();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (_, provider, child) {
      return Scaffold(
        backgroundColor: Styles.BACKGROUND_COLOR,
        bottomNavigationBar: const NavBar(),
        body: fragment(provider.selectedIndex),
      );
    });
  }
}
