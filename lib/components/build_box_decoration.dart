import 'package:flutter/material.dart';

BoxDecoration? customBoxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.01),
        blurRadius: 4,

        // offset: Offset(4, 10), // Shadow position
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.09),
        blurRadius: 4,

        // offset: Offset(-4, -10), // Shadow position
      ),
    ],
  );
}
