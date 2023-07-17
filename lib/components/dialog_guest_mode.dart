// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:provider/provider.dart';
// import '../../../app/core/utils/dimensions.dart';
// import '../../app/core/utils/images.dart';
// import '../../controller/auth_provider.dart';
// import '../../domain/localization/language_constant.dart';
// import '../../main.dart';
//
//
// guestModeDialog(BuildContext context,String massage) {
//   return showAnimatedDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return Consumer<AuthProvider>(builder: (context, authProvider, child) {
//         return AlertDialog(
//           shape: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(30.0)),
//           content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//             Padding(
//               padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     Images.logo,
//                     height: 40,
//                   ),
//                   const SizedBox(height: 5,),
//                   Text(massage,
//                       style: const TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   const SizedBox(height: 30,),
//                   InkWell(
//                     onTap: (){
//                   authProvider.guestMode();
//                   MyApp.navigatorKey.currentState!
//                       .pushNamedAndRemoveUntil(Routes.authRouteName, (route) => false);
//                     },
//                     child: Container(
//                   padding:
//                   const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//                   alignment: Alignment.center,
//                   decoration:  BoxDecoration(
//                     color: Theme.of(context).primaryColor,
//                     boxShadow: [
//                       BoxShadow(
//                          color: Colors.grey.withOpacity(0.2),
//                           spreadRadius: 4,
//                           blurRadius: 5,
//                           offset: const Offset(0, 2)
//                       )
//                     ],
//                       borderRadius:const BorderRadius.all(Radius.circular(25))),
//                       child:  Text( getTranslated("log_in", context),
//                           style: const TextStyle(
//                               color: Colors.white)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//           ]),
//         );
//       });
//     },
//     animationType: DialogTransitionType.slideFromRight,
//     curve: Curves.easeInOutBack,
//     duration: const Duration(milliseconds: 700),
//   );
// }
